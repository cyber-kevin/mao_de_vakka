import 'dart:ffi';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mao_de_vakka/app/components/DefaultButton.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/components/EditableTextWidget.dart';
import 'package:mao_de_vakka/app/components/InputField.dart';
import 'package:mao_de_vakka/app/components/NumericInputField.dart';
import 'package:mao_de_vakka/app/components/PieChart.dart';
import 'package:mao_de_vakka/app/components/TransparentButton.dart';
import 'package:mao_de_vakka/app/models/Category.dart';
import 'package:mao_de_vakka/app/models/Month.dart';
import 'dart:core';
import 'package:intl/intl.dart' as intl;
import 'package:mao_de_vakka/app/components/UnderscoreInputField.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mao_de_vakka/app/models/Entry.dart';
import 'package:mao_de_vakka/app/views/ExpensesPage.dart';
import '../components/LegendItem.dart';
import 'ConfigPage.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomePage({super.key, this.userData = const {}});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  TextEditingController incomeController = TextEditingController();
  TextEditingController editedIncomeController = TextEditingController();

  void updateIncome() {
    var categorys = Category.values.map((e) => e.toString()).toList();

    print(categorys);

    double income =
        double.parse(incomeController.text.replaceFirst(RegExp(','), '.'));
    Entry entry = Entry(income);
    setState(() {
      widget.userData['income'] = widget.userData['income'] + income;
      widget.userData['entryList']['$currentYear']['$currentMonth']
          .add(entry.toMap());
    });
    UserDAOFirestore.update(widget.userData);
    setState(() {
      incomeController.clear();
    });
  }

  void editIncome() {
    double income =
        double.parse(incomeController.text.replaceFirst(RegExp(','), '.'));
    setState(() {
      widget.userData['income'] = income;
    });
    UserDAOFirestore.update(widget.userData);
  }

  void switchMonth(int month) {
    setState(() {
      currentMonth = month;
    });
  }

  bool hasCategory(String category, List<Map<String, dynamic>> map) {
    final filteredList = map.where((e) => e['category'] == category);
    return filteredList.isNotEmpty;
  }

  List<Map<String, dynamic>> getOnlyExpensesEntrys() {
    List<Map<String, dynamic>> entrys = [];
    widget.userData['entryList']['$currentYear']['$currentMonth']
        .forEach((e) => {
              if (e['category'] != 'Saldo') {entrys.add(e)}
            });

    return entrys;
  }

  List<Map<String, dynamic>> getTotalValuesPerCategory() {
    List<Map<String, dynamic>> entrys = getOnlyExpensesEntrys();
    List<Map<String, dynamic>> totalValuesPerCategory = [];

    for (int i = 0; i < entrys.length; i++) {
      if (!hasCategory(entrys[i]['category'], totalValuesPerCategory)) {
        totalValuesPerCategory.add(
            {'category': entrys[i]['category'], 'value': entrys[i]['value']});
      } else {
        int targetIndex = totalValuesPerCategory
            .indexWhere((e) => e['category'] == entrys[i]['category']);

        if (targetIndex != -1) {
          totalValuesPerCategory[targetIndex]['value'] += entrys[i]['value'];
        }
      }
    }

    return totalValuesPerCategory;
  }

  double getSumOfAllExpenses() {
    List<Map<String, dynamic>> totalValuesPerCategory =
        getTotalValuesPerCategory();

    double sum = 0;

    for (int i = 0; i < totalValuesPerCategory.length; i++) {
      sum += totalValuesPerCategory[i]['value'];
    }

    return sum;
  }

  int getPercentagePerCategory(String category) {
    List<Map<String, dynamic>> totalValuesPerCategory =
        getTotalValuesPerCategory();

    double sum = getSumOfAllExpenses();

    var list =
        totalValuesPerCategory.where((e) => e['category'] == category).toList();

    int result = list.isEmpty ? 0 : ((list[0]['value'] / sum) * 100).round();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DefaultTitle(
                text:
                    'Olá, ${widget.userData['name'].toString().split(" ")[0]}',
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month - 1),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month - 1);
                    },
                  ),
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month);
                    },
                  ),
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month + 1),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month + 1);
                    },
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 35),
              ),
              const Text(
                'Saldo Disponível',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('R\$',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 36)),
                  const SizedBox(
                    width: 12,
                  ),
                  EditableTextWidget(
                    initialText: widget.userData['income'].toString(),
                    controller: editedIncomeController,
                    userData: widget.userData,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
              ),
              if (getOnlyExpensesEntrys().isNotEmpty)
                Column(children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartPie(
                      data: getTotalValuesPerCategory()
                          .map((e) {
                            if (e['category'] != 'Saldo') {
                              return {
                                'domain': e['category'],
                                'measure':
                                    ((e['value'] / getSumOfAllExpenses()) * 100)
                                        .round()
                              };
                            } else {
                              return null;
                            }
                          })
                          .whereType<Map<String, dynamic>>()
                          .toList(),
                      fillColor: (pieData, index) {
                        switch (pieData['domain']) {
                          case 'Beleza':
                            return const Color.fromARGB(255, 0, 180, 216);
                          case 'Alimentacao':
                            return const Color.fromARGB(255, 144, 224, 239);
                          case 'Lazer':
                            return const Color.fromARGB(255, 67, 90, 236);
                          case 'Transporte':
                            return const Color.fromARGB(255, 202, 240, 248);
                          case 'CartaoDeCredito':
                            return const Color.fromARGB(255, 2, 62, 138);
                          case 'Contas':
                            return const Color.fromARGB(255, 3, 4, 94);
                          case 'Casa':
                            return const Color.fromARGB(255, 0, 119, 182);
                          case 'Outro':
                            return const Color.fromARGB(255, 106, 104, 104);
                          default:
                            return const Color.fromARGB(255, 0, 180, 216);
                        }
                      },
                      donutWidth: 15,
                      labelPosition: PieLabelPosition.auto,
                      labelColor: Colors.black,
                      labelFontSize: 12,
                      labelLineColor: const Color.fromARGB(255, 34, 197, 94),
                      labelLinelength: 20,
                      labelLineThickness: 2,
                      showLabelLine: false,
                      pieLabel: (pieData, index) {
                        return '';
                      },
                      strokeWidth: 3,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (getPercentagePerCategory('Alimentacao') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 144, 224, 239),
                              text: 'Alimentação',
                              percentage:
                                  getPercentagePerCategory('Alimentacao'),
                            ),
                          if (getPercentagePerCategory('Beleza') != 0)
                            LegendItem(
                                color: const Color.fromARGB(255, 0, 180, 216),
                                text: 'Beleza',
                                percentage: getPercentagePerCategory('Beleza')),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (getPercentagePerCategory('Transporte') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 202, 240, 248),
                              text: 'Transporte',
                              percentage:
                                  getPercentagePerCategory('Transporte'),
                            ),
                          if (getPercentagePerCategory('CartaoDeCredito') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 2, 62, 138),
                              text: 'Cartão de Crédito',
                              percentage:
                                  getPercentagePerCategory('CartaoDeCredito'),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (getPercentagePerCategory('Lazer') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 67, 90, 236),
                              text: 'Lazer',
                              percentage: getPercentagePerCategory('Lazer'),
                            ),
                          if (getPercentagePerCategory('Casa') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 0, 119, 182),
                              text: 'Casa',
                              percentage: getPercentagePerCategory('Casa'),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (getPercentagePerCategory('Contas') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 3, 4, 94),
                              text: 'Contas',
                              percentage: getPercentagePerCategory('Contas'),
                            ),
                          if (getPercentagePerCategory('Outro') != 0)
                            LegendItem(
                              color: const Color.fromARGB(255, 106, 104, 104),
                              text: 'Outro',
                              percentage: getPercentagePerCategory('Outro'),
                            ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      'Total gasto: R\$ ${NumberFormat("##0.00", "en_US").format(getSumOfAllExpenses()).replaceAll('.', ',')}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  )
                ])
              else
                Container(
                  margin: const EdgeInsets.only(top: 80, bottom: 80),
                  child: const Text(
                    'Você ainda não teve despesas neste mês',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 20, 219, 139),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 45),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Adicionar receita',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      UnderscoreInputField(
                        controller: incomeController,
                        width: 300,
                        rightIcon: true,
                        onPressed: updateIncome,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 60),
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
