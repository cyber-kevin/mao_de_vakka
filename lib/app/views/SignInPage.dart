import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mao_de_vakka/app/components/DefaultTitle.dart';
import 'package:mao_de_vakka/app/components/DefaultButton.dart';
import 'package:mao_de_vakka/app/components/InputField.dart';
import 'package:mao_de_vakka/app/controllers/direct_to_homepage.dart';
import 'package:mao_de_vakka/app/models/User.dart' as UserApp;
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mao_de_vakka/app/views/HomePage.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserDAOFirestore dataBase = UserDAOFirestore();
  String _textError = '';

  void _updateState(String message) {
    setState(() {
      _textError = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 229, 229),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const DefaultTitle(text: 'Login'),
              Container(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/woman2_money.png',
                  height: 300,
                  width: 350,
                ),
              ),
              Container(
                height: 50,
              ),
              Form(
                child: Column(
                  children: [
                    InputField(text: 'E-mail:', controller: emailController),
                    InputField(text: 'Senha:', controller: passwordController),
                    Container(
                      child: Text(
                        _textError,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      margin: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 63, bottom: 33),
                      child: DefaultButton(
                          text: 'Confirmar',
                          backgroundColor:
                              const Color.fromARGB(255, 34, 197, 94),
                          // onPressed: () async {
                          //   dynamic user = await dataBase.findUser(
                          //       emailController.text, passwordController.text);

                          //   if (user != null) {
                          //     print('OK');
                          //   } else {
                          //     print('NO');
                          //   }
                          // },
                          onPressed: () async {
                            final FirebaseAuth _auth = FirebaseAuth.instance;

                            try {
                              final UserCredential userCredential =
                                  await _auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);

                              if (userCredential != null) {
                                User? user = userCredential.user;
                                String uid = user!.uid;

                                DocumentSnapshot snapshot =
                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(user.uid)
                                        .get();

                                Map<String, dynamic> userData =
                                    await UserDAOFirestore.findUser(uid);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => RedirectPage(
                                          userData: userData,
                                        )));
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                _updateState('Este usuário não existe');
                              } else if (e.code == 'wrong-password') {
                                _updateState('A senha está incorreta');
                              } else {
                                _updateState(
                                    'Erro: Tente novamente mais tarde');
                              }
                            }
                          },
                          width: 300),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
