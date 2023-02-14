import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mao_de_vakka/app/models/User.dart';

class UserDAOFirestore implements UserDAO {
  CollectionReference connection =
      FirebaseFirestore.instance.collection('users');

  UserDAOFirestore();

  @override
  void addUser(User user) async {
    DocumentReference docUser = connection.doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }

  @override
  dynamic findUser(String email, String password) async {
    var json = await connection.get();
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
  void update(User user, String field, dynamic value) {
    DocumentReference docUser = connection.doc(user.id);
    docUser.update({
      field: value,
    });
  }

  @override
  void delete() {}
}