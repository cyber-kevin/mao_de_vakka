import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  final String text;
  bool obscureText;
  Function(String)? onChanged;
  final TextEditingController controller;

  InputField(
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
                style: const TextStyle(
                    color: Color.fromARGB(255, 34, 197, 94),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
                controller: controller,
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}