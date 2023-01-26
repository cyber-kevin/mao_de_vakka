import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  String text;
  Color backgroundColor;
  var fontColor;
  var borderColor;

  DefaultButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      this.fontColor = Colors.white,
      this.borderColor,
      required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.0,
              color: (borderColor ?? backgroundColor),
            ),
          ),
          child: TextButton(
              child: Center(
                child: Text(text,
                    style:
                        TextStyle(color: fontColor, fontFamily: 'Montserrat')),
              ),
              onPressed: () => {}),
        )
      ],
    );
  }
}

class UnderscoreButton extends StatelessWidget {
  String text;
  Color color;

  UnderscoreButton({super.key, required this.text, required this.color});

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
                    style: TextStyle(color: color, fontFamily: 'Montserrat')),
              ),
              onPressed: () => {}),
        )
      ],
    );
  }
}
