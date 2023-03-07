import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/models/Entry.dart';
import 'package:mao_de_vakka/app/models/Month.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  DateTime birthdate;
  String gender;
  String maritalStatus;
  String educationLevel;
  double income = 0.0;
  Map<String, List<double>> _saveMoney = Map();
  Map<String, List<List<Entry>>> _entryList = Map();

  User(
      {this.id = '',
      required this.name,
      required this.email,
      required this.password,
      required this.birthdate,
      required this.gender,
      required this.maritalStatus,
      required this.educationLevel});

  // List<Entry> getEntryList(String year, Month month) {
  //   return _entryList[year]![month.value - 1];
  // }

  // void addEntry(Entry entry, String year, Month month) {
  //   _entryList[year]![month.value - 1].add(entry);
  // }

  // void deleteEntry(Entry entry, String year, Month month) {
  //   _entryList[year]![month.value - 1].remove(entry);
  // }

  // double getSaveMoney(String year, Month month) {
  //   return _saveMoney[year]![month.value - 1];
  // }

  // void setSaveMoney(double value, String year, Month month) {
  //   _saveMoney[year]![month.value - 1] = value;
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'birthdate': birthdate,
        'gender': gender,
        'maritalStatus': maritalStatus,
        'educationLevel': educationLevel,
        'income': income,
        'saveMoneyList': _saveMoney,
        'entryList': _entryList,
      };

  static User fromJson(Map<String, dynamic> json) {
    User user = User(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        birthdate: (json['birthdate'] as Timestamp).toDate(),
        gender: json['gender'],
        maritalStatus: json['maritalStatus'],
        educationLevel: json['educationLevel']);
    return user;
  }
}