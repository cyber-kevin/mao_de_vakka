import 'package:flutter/material.dart';

class UnderscoreButton extends StatelessWidget {
  final String text;
  final Color color;

  const UnderscoreButton({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color),
            ),
          ),
          child: TextButton(
              child: Center(
                child: Text(text,
                    style: TextStyle(color: color, fontFamily: 'Montserrat'),
                    textAlign: TextAlign.center),
              ),
              onPressed: () => {}),
        )
      ],
    );
  }
}
