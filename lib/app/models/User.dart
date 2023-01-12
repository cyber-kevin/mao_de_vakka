import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/models/Entry.dart';
import 'package:mao_de_vakka/app/models/Month.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  DateTime birthday;
  double income = 0.0;
  Map<String, List<double>> _saveMoney = Map();
  Map<String, List<List<Entry>>> _entryList = Map();

  User(
      {this.id = '',
      required this.name,
      required this.email,
      required this.password,
      required this.birthday});

  List<Entry> getEntryList(String year, Month month) {
    return _entryList[year]![month.value - 1];
  }

  void addEntry(Entry entry, String year, Month month) {
    _entryList[year]![month.value - 1].add(entry);
  }

  void deleteEntry(Entry entry, String year, Month month) {
    _entryList[year]![month.value - 1].remove(entry);
  }

  double getSaveMoney(String year, Month month) {
    return _saveMoney[year]![month.value - 1];
  }

  void setSaveMoney(double value, String year, Month month) {
    _saveMoney[year]![month.value - 1] = value;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'birthday': birthday,
        'income': income,
        'saveMoneyList': _saveMoney,
        'entryList': _entryList,
      };

  // static User fromJson(Map<String, dynamic> json) {
  //   User user = User(
  //       json['name'], json['email'], (json['birthday'] as Timestamp).toDate());
  //   user.income = json['income'];
  //   user._entryList = json['entryList'];
  //   user._saveMoney = json['saveMoney'];

  //   return user;
  // }
}

/*
User data example:

name = Enzo Baptista
email = enzobaptista@gmail.com
birthDate = 2000-01-01
income = 974.97

** Each index in the list represents a month, like:

  saveMoney['2022'][0] --> January save money
  saveMoney['2022'][1] --> February save money

**

saveMoney = {

  '2022' = [50.0, 70.0, 0.0, 0.0, 0.0, 40.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  '2023' = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  '2024' = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  '2025' = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  '2026' = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

}

** Each column in the list represents the entries in an specific month, like: 

  entryList['2022'][0] --> January entries
  entryList['2022'][1] --> February entries

**

entryList = {

  '2022' = [[entry, entry], [entry], [], [], [], [], [], [], [], [], [], []]
  '2023' = [[], [], [], [], [], [], [], [], [], [], [], []]
  '2024' = [[], [], [], [], [], [], [], [], [], [], [], []]
  '2025' = [[], [], [], [], [], [], [], [], [], [], [], []]
  '2026' = [[], [], [], [], [], [], [], [], [], [], [], []]

}


*/

abstract class UserDAO {
  void addUser(User user);
  dynamic findUser(String email, String password);
  void update(User user, String field, dynamic value);
  void delete();
}
