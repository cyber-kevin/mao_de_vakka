import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mao_de_vakka/app/views/HomePage.dart';

class UnderscoreInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;

  UnderscoreInputField(
      {super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 300,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                    TextInputFormatter.withFunction(
                      (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll('.', ','),
                      ),
                    ),
                  ],
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.attach_money,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.black),
                      onPressed: () {
                        onPressed();
                      },
                      alignment: Alignment.bottomLeft,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 34, 197, 94),
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2.5,
                          color: const Color.fromARGB(255, 34, 197, 94),
                        )),
                  ),
                ))
          ],
        )
      ],
    );
  }
}
