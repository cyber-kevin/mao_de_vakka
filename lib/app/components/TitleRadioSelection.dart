import 'package:flutter/material.dart';

class TitleRadioSelection extends StatelessWidget {
  final String text;

  TitleRadioSelection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 70, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
