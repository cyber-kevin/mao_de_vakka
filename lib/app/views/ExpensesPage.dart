import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/input_field.dart';
import 'package:mao_de_vakka/app/components/numeric_input_field.dart';
import 'package:mao_de_vakka/app/components/RadioSelection.dart';
import 'package:mao_de_vakka/app/components/default_button.dart';
import 'package:mao_de_vakka/app/models/Category.dart';
import 'package:mao_de_vakka/app/models/Entry.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:mao_de_vakka/app/views/HomePage.dart';

import '../controllers/direct_to_homepage.dart';

class ExpensesPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ExpensesPage({super.key, this.userData = const {}});
  State<ExpensesPage> createState() => _ExpensesPage();
}

class _ExpensesPage extends State<ExpensesPage> {
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  TextEditingController entryNameController = TextEditingController();
  TextEditingController entryValueController = TextEditingController();
  TextEditingController entryCategoryController = TextEditingController();

  Category _createCategoryEnum(value) {
    Category category;

    switch (value) {
      case 'Cartão de Crédito':
        category = Category.Cartao;
        break;

      case 'Saúde':
        category = Category.Saude;

        break;
      case 'Alimentação':
        category = Category.Alimentacao;

        break;
      case 'Transporte':
        category = Category.Transporte;

        break;
      case 'Contas':
        category = Category.Contas;

        break;
      case 'Lazer':
        category = Category.Lazer;

        break;
      case 'Beleza':
        category = Category.Beleza;

        break;

      case 'Casa':
        category = Category.Casa;

        break;
      case 'Outro':
        category = Category.Outro;

        break;
      case 'Saldo':
        category = Category.Saldo;

        break;
      default:
        category = Category.Outro;
        break;
    }

    return category;
  }

  void updateEntryData() {
    double value =
        double.parse(entryValueController.text.replaceFirst(RegExp(','), '.'));

    Entry entry = Entry.expense(entryNameController.text, value,
        _createCategoryEnum(entryCategoryController.text));

    setState(() {
      widget.userData['income'] = widget.userData['income'] - value;
      widget.userData['entryList']['$currentYear']['$currentMonth']
          .add(entry.toMap());
    });
    UserDAOFirestore.update(widget.userData);
    setState(() {
      entryNameController.clear();
      entryValueController.clear();
      entryCategoryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(250, 231, 229, 229),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70, bottom: 60),
                  child: const Text(
                    'Adicionar nova despesa',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ),
                InputField(text: 'Nome', controller: entryNameController),
                NumericInputField(
                    text: 'Custo', controller: entryValueController),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                ),
                const Text(
                  'Escolha a categoria da despesa',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 22.67),
                ),
                RadioSelection(
                    controller: entryCategoryController,
                    listValues: const [
                      'Alimentação',
                      'Beleza',
                      'Cartão de Crédito',
                      'Contas',
                      'Lazer',
                      'Saúde',
                      'Transporte',
                      'Outro'
                    ]),
                Container(
                  margin: const EdgeInsets.only(bottom: 52.19),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 26.37),
                      child: DefaultButton(
                          text: 'Adicionar',
                          backgroundColor:
                              const Color.fromARGB(255, 34, 197, 94),
                          onPressed: () {
                            updateEntryData();
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text(
                                        'Despesa adicionada',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          RedirectPage(
                                                            userData:
                                                                widget.userData,
                                                          )));
                                            },
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color.fromARGB(
                                                      255, 34, 197, 94)),
                                            ))
                                      ],
                                    )));
                          }),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 22.13),
                )
              ],
            ),
          ),
        ));
  }
}
