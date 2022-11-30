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
      backgroundColor: const Color.fromARGB(255, 59, 219, 118),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Image.asset(
              'assets/images/vakka_logo.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 35),
            child: Text(
              'Mão de Vakka',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              'Organize suas finanças',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 309),
              child: Text(
                'AKKAV Group',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600),
              ))
        ],
      )),
    ));
  }
}
