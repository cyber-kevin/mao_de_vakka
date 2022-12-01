import 'package:flutter/material.dart';
import 'custom/buttons.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Image.asset(
                  'assets/images/vakka_logo.png',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Mão de Vakka',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 50),
                child: Text(
                  'Organize suas finanças',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 340,
                height: 290,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 47),
                        child: DefaultButton(
                          text: 'Fazer cadastro',
                          backgroundColor:
                              const Color.fromARGB(255, 34, 197, 94),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 18),
                        child: DefaultButton(
                          text: 'Login',
                          backgroundColor:
                              const Color.fromARGB(255, 241, 241, 241),
                          fontColor: const Color.fromARGB(255, 34, 197, 94),
                          borderColor: const Color.fromARGB(255, 34, 197, 94),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 46),
                        child: UnderscoreButton(
                          text: 'Continuar sem login',
                          color: const Color.fromARGB(255, 34, 197, 94),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'AKKAV Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'MontSerrat',
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
