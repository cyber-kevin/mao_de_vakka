import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/views/sign_up_page.dart';
import 'package:mao_de_vakka/app/views/sing_in_page.dart';
import 'package:mao_de_vakka/app/views/home_page.dart';
import 'package:mao_de_vakka/app/components/default_button.dart';
import 'package:mao_de_vakka/app/components/UnderscoreButton.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 59, 219, 118),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // ****** Logo MAO DE VAKKA *******
                Padding(
                  padding: const EdgeInsets.only(top: 130),
                  child: Image.asset(
                    'assets/images/vakka_logo.png',
                  ),
                ),
                // ****** TITLE *******
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
                // ****** SUBTITLE *******
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
                // ****** CARD *******
                Container(
                  width: 340,
                  height: 220,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      // ****** CARD CONTENT*******
                      children: [
                        // ****** 'Fazer Cadasto' BUTTON *******
                        Padding(
                          padding: const EdgeInsets.only(top: 47),
                          child: DefaultButton(
                            text: 'Fazer cadastro',
                            backgroundColor:
                                const Color.fromARGB(255, 34, 197, 94),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SignUpPage()));
                            },
                          ),
                        ),
                        // ****** 'Login' BUTTON *******
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: DefaultButton(
                              text: 'Login',
                              backgroundColor:
                                  const Color.fromARGB(255, 241, 241, 241),
                              fontColor: const Color.fromARGB(255, 34, 197, 94),
                              borderColor:
                                  const Color.fromARGB(255, 34, 197, 94),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SignInPage()));
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                // ****** 'AKKAV Group' TEXT *******
                const Padding(
                  padding: EdgeInsets.only(top: 70, bottom: 10),
                  child: Text(
                    'AKKAV Group',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
