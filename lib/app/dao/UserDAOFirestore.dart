import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/models/User.dart';

class UserDAOFirestore {
  static CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String userId, String name, String gender,
    String maritalStatus, String educationLevel, DateTime birthDate) async {

      int currentYear = DateTime.now().year;

      print('entrou');

      collection.doc(userId).set({
        'name': name,
        'gender': gender,
        'maritalStatus': maritalStatus,
        'educationLevel': educationLevel,
        'birthDate': birthDate,
        'income': 0,
        'entryList': {
          '$currentYear': {
            '1': [],
            '2': [],
            '3': [],
            '4': [],
            '5': [],
            '7': [],
            '8': [],
            '9': [],
            '10': [],
            '11': [],
            '12': [],
          },
        },
        'saveMoney': {
          '$currentYear': {
            '1': [],
            '2': [],
            '3': [],
            '4': [],
            '5': [],
            '6': [],
            '7': [],
            '8': [],
            '9': [],
            '10': [],
            '11': [],
            '12': [],
          },
        }
      });
  }

  @override
  static Future<Map<String, dynamic>> findUser(String id) async {
    DocumentSnapshot<Object?> snapshot = await collection.doc(id).get();
    Map<String, dynamic> userData = toJson(snapshot, id);

    return userData;
  }

  @override
  static void update(Map<String, dynamic> userData) async{
    DocumentReference docUser = collection.doc(userData['id']);
    await docUser.update(userData);
  }

  @override
  static void delete() {}

  static Map<String, dynamic> toJson(DocumentSnapshot<Object?> snapshot, String id) {

    Map<String, dynamic> userData = {
      'id': id,
      'name': snapshot.get('name'),
      'income': snapshot.get('income'),
      'birthDate': snapshot.get('birthDate'),
      'gender': snapshot.get('gender'),
      'maritalStatus': snapshot.get('maritalStatus'),
      'educationLevel': snapshot.get('educationLevel'),
      'entryList': snapshot.get('entryList'),
      'saveMoney': snapshot.get('saveMoney')
  };

  return userData;
}
}