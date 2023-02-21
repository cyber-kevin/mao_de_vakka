import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/models/User.dart';

class UserDAOFirestore {
  static CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> addUser(String userId, String name, String gender,
      String maritalStatus, String educationLevel, DateTime birthDate) async {
    // DocumentReference docUser = connection.doc();
    // user.id = docUser.id;
    // final json = user.toJson();
    // await docUser.set(json);
    collection.doc(userId).set({
      'name': name,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'educationLevel': educationLevel,
      'birthDate': birthDate
    });
  }

  @override
  static dynamic findUser(String email, String password) async {
    var json = await collection.get();
    var user = null;
    print(json.docs.map((e) {
      var data = e.data() as Map;
      if ((data['email'] == email) && (data['password'] == password)) {
        print('in');
        user = data;
      }
    }));

    return user;
  }

  @override
  static void update(User user, String field, dynamic value) {
    DocumentReference docUser = collection.doc(user.id);
    docUser.update({
      field: value,
    });
  }

  @override
  static void delete() {}
}
