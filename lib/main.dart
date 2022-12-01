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
              padding: const EdgeInsets.only(top: 130),
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
                      child: DefaultButton(
                        text: 'Fazer cadastro',
                        backgroundColor: Color.fromARGB(255, 34, 197, 94),
                      ),
                      margin: EdgeInsets.only(top: 47),
                    ),
                    Container(
                      child: DefaultButton(
                        text: 'Login',
                        backgroundColor: Color.fromARGB(255, 241, 241, 241),
                        fontColor: Color.fromARGB(255, 34, 197, 94),
                        borderColor: Color.fromARGB(255, 34, 197, 94),
                      ),
                      margin: EdgeInsets.only(top: 18),
                    ),
                    Container(
                      child: UnderscoreButton(
                        text: 'Continuar sem login',
                        color: Color.fromARGB(255, 34, 197, 94),
                      ),
                      margin: EdgeInsets.only(top: 46),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 170,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'AKKAV Group',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ],
        ),
      ),
    ));
  }
}

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
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            color: this.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.0,
              color: (borderColor != null ? borderColor : backgroundColor),
            ),
          ),
          child: TextButton(
              child: Center(
                child: Text(this.text,
                    style:
                        TextStyle(color: fontColor, fontFamily: 'Montserrat')),
              ),
              onPressed: () => {}),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
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
                child: Text(this.text,
                    style: TextStyle(color: color, fontFamily: 'Montserrat')),
              ),
              onPressed: () => {}),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
