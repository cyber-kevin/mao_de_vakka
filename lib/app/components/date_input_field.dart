import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Function selectDate;

  const DateInputField({
    super.key,
    required this.text,
    required this.controller,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 300,
        margin: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: 300,
            height: 50,
            child: TextField(
              style: const TextStyle(
                  color: Color.fromARGB(255, 34, 197, 94),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500),
              controller: controller,
              decoration: InputDecoration(
                  hintText: 'Selecione uma data',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 3,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 34, 197, 94)))),
              readOnly: true,
              onTap: () => selectDate(context),
            ))
      ])
    ]);
  }
}
