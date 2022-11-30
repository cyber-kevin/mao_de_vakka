import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 219, 118),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 190),
            child: Image.asset(
              'assets/images/vakka_logo.png',
            ),
          ),
        ],
      )),
    ));
  }
}
