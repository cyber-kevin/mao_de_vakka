import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class EditableTextWidget extends StatefulWidget {
  String initialText;
  TextEditingController controller;
  final Map<String, dynamic> userData;

  EditableTextWidget(
      {super.key,
      required this.initialText,
      required this.controller,
      required this.userData});

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller =
        TextEditingController(text: widget.initialText.replaceAll(',', '.'));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) => newValue.copyWith(
                      text: newValue.text.replaceAll('.', ','),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(widget.controller.text);
                  },
                ),
              ],
            );
          },
        ).then((value) {
          if (value != null) {
            setState(() {
              widget.controller.text = value;
              widget.userData['income'] =
                  double.parse(widget.controller.text.replaceAll(',', '.'));
              widget.initialText = widget.controller.text;
            });
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            double.parse(widget.initialText.replaceAll(',', '.'))
                .toStringAsFixed(2)
                .replaceAll('.', ','),
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 36),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.edit),
        ],
      ),
    );
  }
}
