import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  bool isSelected;
  final VoidCallback onPressed;

  TransparentButton(
      {super.key,
      required this.text,
      required this.color,
      this.fontSize = 17,
      this.isSelected = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: (fontSize == 17) ? 100 : 150,
          height: 40,
          child: TextButton(
              onPressed: onPressed,
              child: Center(
                child: Text(text,
                    style: TextStyle(
                        color: color,
                        fontFamily: 'Montserrat',
                        fontSize: fontSize),
                    textAlign: TextAlign.center),
              )),
        )
      ],
    );
  }
}