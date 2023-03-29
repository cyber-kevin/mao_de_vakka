import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mao_de_vakka/app/views/HomePage.dart';

class UnderscoreInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final double width;
  final bool leftIcon;
  final bool rightIcon;
  final double height;

  UnderscoreInputField(
      {super.key,
      required this.controller,
      required this.onPressed,
      required this.width,
      this.height = 40,
      this.leftIcon = false,
      this.rightIcon = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: width,
                height: height,
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
                    prefixIcon: leftIcon == true
                        ? const Icon(
                            Icons.attach_money,
                            color: Colors.black,
                          )
                        : null,
                    suffixIcon: rightIcon == true
                        ? IconButton(
                            icon: const Icon(Icons.add_circle_outline,
                                color: Colors.black),
                            onPressed: () {
                              onPressed();
                            },
                            alignment: Alignment.bottomLeft,
                          )
                        : null,
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
