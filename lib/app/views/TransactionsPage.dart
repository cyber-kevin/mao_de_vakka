import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TransactionsPage({super.key, this.userData = const {}});

  State<TransactionsPage> createState() => _TransactionsPage();
}

class _TransactionsPage extends State<TransactionsPage> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;

  dynamic getDate(Timestamp date) {
    DateFormat format = DateFormat('dd/MM');
    return format.format(date.toDate());
  }

  bool isCredit(String title) {
    return title == 'CrÃ©dito';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 231, 229, 229),
      body: Center(
        child: ListView.builder(
          itemCount: widget
              .userData['entryList'][DateTime.now().year.toString()]
                  [DateTime.now().month.toString()]
              .length, // the number of widgets to load
          itemBuilder: (BuildContext context, int index) {
            // build each widget
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: isCredit(widget.userData['entryList']
                                [DateTime.now().year.toString()]
                            [DateTime.now().month.toString()][index]['title'])
                        ? Colors.green
                        : Colors.red, // Set border color
                    width: 1.0, // Set border width
                  )),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                widget.userData['entryList']['$currentYear']
                                    ['$currentMonth'][index]['title'],
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600),
                              )),
                          Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                "R\$ ${NumberFormat("##0.00", "en_US").format(widget.userData['entryList']['$currentYear']['$currentMonth'][index]['value']).toString().replaceAll('.', ',')}",
                                style: TextStyle(
                                    color: isCredit(widget.userData['entryList']
                                                ['$currentYear']
                                            ['$currentMonth'][index]['title'])
                                        ? Colors.green
                                        : Colors.red,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                      Text(
                        getDate(widget.userData['entryList']['$currentYear']
                            ['$currentMonth'][index]['date']),
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}