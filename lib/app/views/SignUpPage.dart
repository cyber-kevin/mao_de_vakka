import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/InputField.dart';
import 'package:mao_de_vakka/app/components/DefaultButton.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mao_de_vakka/app/views/HomePage.dart';
import 'package:mao_de_vakka/app/views/InitialScreen.dart';

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

  String _textError = '';

  void _updateState(String message) {
    setState(() {
      _textError = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            const DefaultTitle(text: 'Cadastro'),
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
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    _textError,
                    style: TextStyle(
                        color: Colors.red[400],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 63, bottom: 33),
                  child: DefaultButton(
                      text: 'Confirmar cadastro',
                      backgroundColor: const Color.fromARGB(255, 34, 197, 94),
                      onPressed: () async {
                        if (areAllFieldsFilled()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);

                            await UserDAOFirestore.addUser(
                                userCredential.user!.uid,
                                nameController.text,
                                genderController.text,
                                maritalStatusController.text,
                                educationLevelController.text,
                                DateTime.parse(birthdateController.text));

                            Map<String, dynamic> userData = await UserDAOFirestore.findUser(userCredential.user!.uid);

                            print(userData);

                            _updateState('User has been registered =)');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => HomePage(userData: userData,)));
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'weak-password') {
                              _updateState('A senha é muito fraca');
                            }
                            else if (e.code == 'email-already-in-use') {
                              _updateState(
                                  'Uma conta já existe para este e-mail');
                            } else {
                              _updateState('Erro: Tente novamente');
                              print(e.code);
                            }
                          }
                        } else {
                          _updateState('Por favor, preencha todos os campos');
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
