// ignore: file_names
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final int percentage;

  const LegendItem(
      {Key? key, required this.color, required this.text, this.percentage = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$text $percentage%',
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 13,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
