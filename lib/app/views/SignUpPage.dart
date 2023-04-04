import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/input_field.dart';
import 'package:mao_de_vakka/app/components/RadioSelection.dart';
import 'package:mao_de_vakka/app/components/TitleRadioSelection.dart';
import 'package:mao_de_vakka/app/components/date_input_field.dart';
import 'package:mao_de_vakka/app/components/default_button.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:mao_de_vakka/app/views/homepage.dart';
import 'package:mao_de_vakka/app/views/InitialScreen.dart';
import 'package:mao_de_vakka/app/views/PresentationScreen.dart';
import 'package:intl/intl.dart';

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
  TextEditingController incomeLevel = TextEditingController();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthdateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
                DateInputField(
                    text: 'Data de nascimento',
                    controller: birthdateController,
                    selectDate: _selectDate),
                TitleRadioSelection(text: 'Gênero'),
                RadioSelection(
                  controller: genderController,
                  listValues: const ['Masculino', 'Feminino', 'Outro'],
                ),
                TitleRadioSelection(text: 'Estado Civil'),
                RadioSelection(
                  controller: maritalStatusController,
                  listValues: const ['Solteiro', 'Casado', 'Divorciado'],
                ),
                TitleRadioSelection(text: 'Escolaridade'),
                RadioSelection(
                  controller: educationLevelController,
                  listValues: const [
                    'Ensino Médio',
                    'Graduação',
                    'Pós-Graduação',
                    'Mestrado',
                    'Doutorado',
                    'PhD',
                    'Outro'
                  ],
                ),
                TitleRadioSelection(text: 'Renda Anual'),
                RadioSelection(
                  controller: incomeLevel,
                  listValues: const [
                    '< 40K',
                    '40K - 60K',
                    '60K - 80K',
                    '80K - 120K',
                    '> 120K'
                  ],
                ),
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
                                DateFormat('dd/MM/yyyy')
                                    .parse(birthdateController.text));

                            Map<String, dynamic> userData =
                                await UserDAOFirestore.findUser(
                                    userCredential.user!.uid);

                            _updateState('O usuário foi registrado =)');

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PresentationPage(
                                      userData: userData,
                                    )));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              _updateState('A senha é muito fraca');
                            } else if (e.code == 'email-already-in-use') {
                              _updateState(
                                  'Uma conta já existe para este e-mail');
                            } else {
                              _updateState('Erro: Tente novamente');
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
