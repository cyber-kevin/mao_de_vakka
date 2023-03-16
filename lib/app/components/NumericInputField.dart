import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInputField extends StatelessWidget {
  final String text;
  bool obscureText;
  Function(String)? onChanged;
  final TextEditingController controller;

  NumericInputField(
      {super.key,
      required this.text,
      required this.controller,
      this.obscureText = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(text,
              style: const TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 300,
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) => newValue.copyWith(
                      text: newValue.text.replaceAll('.', ','),
                    ),
                  ),
                ],
                style: const TextStyle(
                    color: Color.fromARGB(255, 34, 197, 94),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
                controller: controller,
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_money, color: Colors.black),
                    alignment: Alignment.bottomLeft,
                    onPressed: () {},
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
