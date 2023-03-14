import 'package:flutter/material.dart';

class RadioSelection extends StatefulWidget {
  TextEditingController controller;
  List<String> listValues;

  RadioSelection({Key? key, required this.controller, required this.listValues})
      : super(key: key);

  @override
  _RadioSelectionState createState() => _RadioSelectionState();
}

class _RadioSelectionState extends State<RadioSelection> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    widget.controller.text = _selected ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.listValues.map((value) {
      return Container(
          margin: const EdgeInsets.only(left: 40),
          child: RadioListTile<String>(
            activeColor: const Color.fromARGB(255, 34, 197, 94),
            title: Text(
              value,
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
            value: value,
            groupValue: _selected,
            onChanged: (value) {
              setState(() {
                _selected = value;
                widget.controller.text = _selected!;
              });
            },
          ));
    }).toList());
  }
}
