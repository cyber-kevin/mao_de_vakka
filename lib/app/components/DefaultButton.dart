import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color fontColor;
  final dynamic borderColor;
  final VoidCallback onPressed;
  double width;
  double height;
  MainAxisAlignment alignment;

  DefaultButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.onPressed,
      this.fontColor = Colors.white,
      this.borderColor,
      this.width = 250,
      this.height = 50,
      this.alignment = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.0,
              color: (borderColor ?? backgroundColor),
            ),
          ),
          child: TextButton(
              onPressed: onPressed,
              child: Center(
                child: Text(text,
                    style:
                        TextStyle(color: fontColor, fontFamily: 'Montserrat')),
              )),
        )
      ],
    );
  }
}