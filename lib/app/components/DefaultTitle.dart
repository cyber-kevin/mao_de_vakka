import 'package:flutter/material.dart';

class DefaultTitle extends StatelessWidget {
  final String text;

  const DefaultTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 50),
          child: Text(
            text,
            style: const TextStyle(
              color: Color.fromARGB(255, 51, 51, 51),
              fontSize: 30,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
  }
}