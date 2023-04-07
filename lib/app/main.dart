import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mao_de_vakka/app/models/User.dart';
import 'package:mao_de_vakka/app/views/initial_screen.dart';
import 'package:mao_de_vakka/app/views/sing_in_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: InitialScreen(),
  ));
}
