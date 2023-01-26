import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/InputField.dart';
import 'package:mao_de_vakka/app/components/DefaultButton.dart';
import 'package:mao_de_vakka/app/models/User.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'PresentationScreen.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController educationLevelController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserDAOFirestore dataBase = UserDAOFirestore();

  bool areAllFieldsFilled() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        birthdateController.text.isNotEmpty &&
        genderController.text.isNotEmpty &&
        maritalStatusController.text.isNotEmpty &&
        educationLevelController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 70, left: 50),
                  child: Text(
                    'Cadastro',
                    style: TextStyle(
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/images/woman_money.png',
                height: 300,
                width: 350,
              ),
            ),
            Form(
                child: Column(
              children: [
                InputField(text: 'Nome completo', controller: nameController),
                InputField(
                  text: 'Email',
                  controller: emailController,
                  onChanged: (value) {
                    print(value);
                  },
                ),
                InputField(
                    text: 'Data de nascimento',
                    controller: birthdateController),
                InputField(text: 'Gênero', controller: genderController),
                InputField(
                    text: 'Estado Civil', controller: maritalStatusController),
                InputField(
                    text: 'Escolaridade', controller: educationLevelController),
                InputField(
                    text: 'Senha',
                    controller: passwordController,
                    obscureText: true),
                Container(
                  margin: const EdgeInsets.only(top: 63, bottom: 33),
                  child: DefaultButton(
                      text: 'Confirmar cadastro',
                      backgroundColor: const Color.fromARGB(255, 34, 197, 94),
                      onPressed: () {
                        if (areAllFieldsFilled()) {
                          User user = User(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              birthdate:
                                  DateTime.parse(birthdateController.text),
                              gender: genderController.text,
                              maritalStatus: maritalStatusController.text,
                              educationLevel: educationLevelController.text);

                          dataBase.addUser(user);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const PresentationPage()));
                        } else {
                          print('ajeite');
                        }
                      },
                      width: 300),
                )
              ],
            ))
          ],
        ),
      )),
    );
  }
}
