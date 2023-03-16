import 'dart:ffi';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/DefaultButton.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/components/PieChart.dart';
import 'package:mao_de_vakka/app/components/TransparentButton.dart';
import 'package:mao_de_vakka/app/models/Month.dart';
import 'dart:core';
import 'package:intl/intl.dart' as intl;
import 'package:mao_de_vakka/app/components/UnderscoreInputField.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mao_de_vakka/app/models/Entry.dart';
import 'package:mao_de_vakka/app/views/ExpensesPage.dart';

import 'ConfigPage.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomePage({super.key, this.userData = const {}});
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  TextEditingController incomeController = TextEditingController();

  void updateIncome() {
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

  void switchMonth(int month) {
    setState(() {
      currentMonth = month;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> entrys = [];
    widget.userData['entryList']['$currentYear']['$currentMonth']
        .forEach((e) => {entrys.add(e)});

    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: const Color.fromARGB(255, 34, 197, 94),
            child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_money),
                        color: Colors.black),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bar_chart),
                        color: Colors.black),
                    IconButton(
                        onPressed: () async {
                          var userData = widget.userData;

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ConfigPage(
                                    userData: userData,
                                  )));
                        },
                        icon: const Icon(Icons.person),
                        color: Colors.black)
                  ],
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DefaultTitle(
                text:
                    'Olá, ${widget.userData['name'].toString().split(" ")[0]}',
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month - 1),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month - 1);
                      print('switched');
                      print(entrys);
                    },
                  ),
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month);
                      print('switched');
                      print(entrys);
                    },
                  ),
                  TransparentButton(
                    text: Month.getMonth(DateTime.now().month + 1),
                    color: Colors.black,
                    onPressed: () {
                      switchMonth(DateTime.now().month + 1);
                      print('switched');
                      print(entrys);
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
              Text(
                "R\$ ${intl.NumberFormat("0.00", "pt_BR").format(widget.userData['income'])}",
                style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 36),
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartPie(
                  data: const [
                    {'domain': 'Flutter', 'measure': 28},
                    {'domain': 'React Native', 'measure': 27},
                    {'domain': 'Ionic', 'measure': 20},
                    {'domain': 'Cordova', 'measure': 15},
                  ],
                  fillColor: (pieData, index) => Colors.purple,
                  donutWidth: 30,
                  labelColor: Colors.white,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 45),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
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
                        onPressed: updateIncome,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 60),
                      ),
                      DefaultButton(
                          alignment: MainAxisAlignment.start,
                          text: 'Adicionar nova despesa',
                          backgroundColor:
                              const Color.fromARGB(255, 34, 197, 94),
                          width: 300,
                          height: 50,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    ExpensesPage(userData: widget.userData)));
                          })
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 50),
              ),
              const Text(
                'Disponível para gastar',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 57, right: 57, top: 17),
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          Text(
                            'R\$ 15,00/',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          Text(
                            'por dia',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: const [
                          Text(
                            'R\$ 105,00/',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          Text(
                            'por semana',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          )
                        ],
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
