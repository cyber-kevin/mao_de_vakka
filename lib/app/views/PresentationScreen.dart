import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mao_de_vakka/app/components/UnderscoreButton.dart';
import 'package:flutter/material.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/images/Manage_money_bro_1.png',
                height: 437,
                width: 422,
              ),
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Text(
                    'Este é o aplicativo definitivo para te ajudar a gerenciar seu dinheiro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            // Adicione o botão abaixo
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Adicione a ação do botão aqui
                    },
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(140, 42)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 34, 197, 94))),
                    child: const Text("Próximo"),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}