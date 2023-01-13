import 'package:flutter/material.dart';

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
          child: Text(text,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          margin: EdgeInsets.only(bottom: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 300,
              height: 50,
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
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
