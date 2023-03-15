import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:core';
import 'package:mao_de_vakka/app/dao/UserDAOFirestore.dart';
import 'package:mao_de_vakka/app/views/InitialScreen.dart';
import 'HomePage.dart';

class ConfigPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ConfigPage({super.key, this.userData = const {}});
  State<ConfigPage> createState() => _ConfigPage();
}

class _ConfigPage extends State<ConfigPage> {
  TextEditingController lougoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> entrys = [];

    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(60), topRight: Radius.circular(60)),
        child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: const Color.fromARGB(255, 34, 197, 94),
            child: IconTheme(
              data:
                  IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () async {
                          var userData = widget.userData;

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => HomePage(
                                    userData: userData,
                                  )));
                        },
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.black,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.attach_money,
                            color: Colors.black)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bar_chart, color: Colors.black)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person, color: Colors.white))
                  ],
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              const Text('Personalizar perfil',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600)),
              const Padding(padding: EdgeInsets.only(top: 60)),
              CircleAvatar(
                radius: 120,
                backgroundColor: const Color.fromARGB(255, 34, 197, 94),
                child: Image.asset(
                  'assets/images/vakka_logo.png',
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 70)),
              SizedBox(
                height: 80,
                width: 360,
                child: TextFormField(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 34, 197, 94),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 34, 197, 94),
                              width: 1.5)),
                      suffixIcon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.only(top: 10),
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Poppins'),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 34, 197, 94),
                              width: 1)),
                    ),
                    initialValue: widget.userData['name'],
                    onChanged: (value) {
                      (value.isEmpty || value.characters.length < 2)
                          ? setState(() {
                              widget.userData['name'] = widget.userData['name'];
                            })
                          : setState(() {
                              UserDAOFirestore.update(widget.userData);
                              widget.userData['name'] = value;
                            });
                    }),
              ),
              SizedBox(
                height: 80,
                width: 360,
                child: TextFormField(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 34, 197, 94),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 34, 197, 94),
                              width: 1.5)),
                      suffixIcon: Icon(Icons.edit, color: Colors.black),
                      contentPadding: EdgeInsets.only(top: 10),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Poppins'),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 34, 197, 94),
                              width: 1)),
                    ),
                    initialValue: widget.userData['email'],
                    onChanged: (value) {
                      setState(() {
                        widget.userData['email'] = value;
                      });
                    }),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Text(
                    'As ilustrações utilizadas no aplicativo Mão de Vakka estão disponíveis gratuitamente para uso nos sites: \n \nhttps://thenounproject.com/ \nhttps://storyset.com/',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 34, 197, 94)),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Text(
                    'Prezado usuário, caso encontre algum bug ou erro, reportar para o e-mail: \n\nakkavgroup@gmail.com',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 25),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      minimumSize: const Size(360, 50),
                      backgroundColor: Color.fromARGB(0, 0, 248, 91),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 34, 197, 94),
                              width: 3),
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const InitialScreen()));
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 34, 197, 94),
                  ),
                  label: const Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 34, 197, 94),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
