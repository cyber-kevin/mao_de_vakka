import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mao_de_vakka/app/models/Category.dart';

class CategoryDetails extends StatefulWidget {
  final Map<String, dynamic> userData;

  const CategoryDetails({super.key, required this.userData});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  String category = 'Cartao';

  dynamic getDate(Timestamp date) {
    DateFormat format = DateFormat('dd/MM');
    return format.format(date.toDate());
  }

  bool isCredit(String category) {
    return category == 'Saldo';
  }

  List<Map<String, dynamic>> getEntries(String category) {
    final entries = widget.userData['entryList'];
    final filteredList = entries.where((e) => e['category'] == category);
    return filteredList.toList();
  }

  List<Map<String, dynamic>> getExpensesPerCategory(String category) {
    List<Map<String, dynamic>> entries = [];
    widget.userData['entryList']['$year']['$month'].forEach((e) => {
          if (e['category'] == category) {entries.add(e)}
        });

    print(entries);

    return entries;
  }

  void deleteExpense(String id) {
    widget.userData['entryList']['$year']['$month']
        .removeWhere((e) => e['id'] == id);
  }

  String? selectedValue;

  final List<String> items = [
    'Saude',
    'Alimentacao',
    'Transporte',
    'Cartao',
    'Contas',
    'Lazer',
    'Beleza',
    'Casa',
    'Outro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Text('Detalhe das despesas',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text('Selecione a categoria da despesa',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                DropdownButton(
                  hint: const Text(
                    'Selecione uma categoria',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: category,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color.fromARGB(255, 34, 197, 94)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 3, 83, 21),
                  ),
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      category = value!;
                      if (value == 'Cartao') {
                        selectedValue = Category.Cartao.name;
                      } else if (value == 'Saude') {
                        selectedValue = Category.Saude.name;
                      } else if (value == 'Alimentacao') {
                        selectedValue = Category.Alimentacao.name;
                      } else if (value == 'Transporte') {
                        selectedValue = Category.Transporte.name;
                      } else if (value == 'Contas') {
                        selectedValue = Category.Contas.name;
                      } else if (value == 'Lazer') {
                        selectedValue = Category.Lazer.name;
                      } else if (value == 'Beleza') {
                        selectedValue = Category.Beleza.name;
                      } else if (value == 'Casa') {
                        selectedValue = Category.Casa.name;
                      } else if (value == 'Outro') {
                        selectedValue = Category.Outro.name;
                      }
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text('Selecione o período da despesa',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                DropdownButton(
                  hint: const Text('Mês',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600)),
                  value: month,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color.fromARGB(255, 34, 197, 94)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 3, 83, 21),
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('Janeiro'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text('Fevereiro'),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text('Março'),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text('Abril'),
                      value: 4,
                    ),
                    DropdownMenuItem(
                      child: Text('Maio'),
                      value: 5,
                    ),
                    DropdownMenuItem(
                      child: Text('Junho'),
                      value: 6,
                    ),
                    DropdownMenuItem(
                      child: Text('Julho'),
                      value: 7,
                    ),
                    DropdownMenuItem(
                      child: Text('Agosto'),
                      value: 8,
                    ),
                    DropdownMenuItem(
                      child: Text('Setembro'),
                      value: 9,
                    ),
                    DropdownMenuItem(
                      child: Text('Outubro'),
                      value: 10,
                    ),
                    DropdownMenuItem(
                      child: Text('Novembro'),
                      value: 11,
                    ),
                    DropdownMenuItem(
                      child: Text('Dezembro'),
                      value: 12,
                    ),
                  ],
                  onChanged: (Object? value) {
                    setState(() {
                      month = value as int;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                DropdownButton(
                  hint: const Text('Selecione o Ano',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600)),
                  value: year,
                  icon: const Icon(Icons.arrow_downward,
                      color: Color.fromARGB(255, 34, 197, 94)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: const Color.fromARGB(255, 3, 83, 21),
                  ),
                  items: const [
                    DropdownMenuItem(
                      child: Text('2021'),
                      value: 2021,
                    ),
                    DropdownMenuItem(
                      child: Text('2022'),
                      value: 2022,
                    ),
                    DropdownMenuItem(
                      child: Text('2023'),
                      value: 2023,
                    ),
                    DropdownMenuItem(
                      child: Text('2024'),
                      value: 2024,
                    ),
                    DropdownMenuItem(
                      child: Text('2025'),
                      value: 2025,
                    ),
                    DropdownMenuItem(
                      child: Text('2026'),
                      value: 2026,
                    ),
                    DropdownMenuItem(
                      child: Text('2027'),
                      value: 2027,
                    ),
                    DropdownMenuItem(
                      child: Text('2028'),
                      value: 2028,
                    ),
                    DropdownMenuItem(
                      child: Text('2029'),
                      value: 2029,
                    ),
                    DropdownMenuItem(
                      child: Text('2030'),
                      value: 2030,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      year = value!;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                if (getExpensesPerCategory(category).length == 0)
                  Container(
                      child: Text(
                          'Você ainda não tem despesas com este tipo de filtro.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color.fromARGB(255, 20, 219, 139),
                              fontWeight: FontWeight.w600)))
                else
                  const Text('Selecione uma despesa para alterar',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600)),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Expanded(
                  child: ListView.builder(
                    itemCount: getExpensesPerCategory(category)
                        .length, // the number of widgets to load
                    itemBuilder: (BuildContext context, int index) {
                      // build each widget
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black, // Set border color
                              width: 1.0, // Set border width
                            )),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 40),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          getExpensesPerCategory(
                                              category)[index]['title'],
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          "R\$ ${getExpensesPerCategory(category)[index]['value']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      final list = widget.userData['entryList']
                                          ['$year']['$month'];

                                      for (var i = 0; i < list.length; i++) {
                                        final e = list[i];
                                        if (e['id'] ==
                                            getExpensesPerCategory(
                                                category)[index]['id']) {
                                          widget.userData['income'] +=
                                              e['value'];
                                          deleteExpense(e['id']);
                                          i--;
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        shape: const CircleBorder()),
                                    child: const Icon(Icons.delete,
                                        color:
                                            Color.fromARGB(255, 34, 197, 94)))
                              ],
                            )),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
