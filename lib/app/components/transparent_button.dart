import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  bool isSelected;
  final VoidCallback onPressed;
  bool shouldShowBorder;

  TransparentButton(
      {super.key,
      required this.text,
      required this.color,
      this.fontSize = 17,
      this.isSelected = false,
      required this.onPressed,
      this.shouldShowBorder = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 100,
            height: 40,
            child: Container(
              decoration: BoxDecoration(
                border: shouldShowBorder
                    ? Border(
                        bottom: BorderSide(
                            width: 0.5,
                            color: const Color.fromARGB(255, 34, 197, 94)),
                      )
                    : null,
              ),
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
            ))
      ],
    );
  }
}