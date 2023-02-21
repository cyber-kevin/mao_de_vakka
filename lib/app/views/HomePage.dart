import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/components/TransparentButton.dart';
import 'package:mao_de_vakka/app/models/Month.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentMonth = DateTime.now().month;

  final List<TransparentButton> _buttons = [
    TransparentButton(
      text: Month.getMonth(DateTime.now().month - 1),
      color: Colors.black,
    ),
    TransparentButton(
      text: Month.getMonth(DateTime.now().month),
      color: Colors.black,
    ),
    TransparentButton(
        text: Month.getMonth(DateTime.now().month + 1), color: Colors.black)
  ];

  void switchMonth() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              DefaultTitle(
                text: 'Olá, enzo',
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buttons[0], _buttons[1], _buttons[3]],
              )
            ],
          ),
        ),
      ),
    );
  }
}
