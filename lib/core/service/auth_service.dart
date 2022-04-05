import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendors/core/service_injector/service_injector.dart';
import 'package:vendors/shared/model/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> register({
    required String email,
    required String password,
    required String fName,
    required String lName,
    required String location,
    required String phone,
  }) async {
    String? id;
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredentials) async {
        await si.firebaseService
            .addDoc(
          collection: 'users',
          data: {
            "first_name": fName,
            "last_name": lName,
            "email": email,
            "location": location,
            "phone": phone,
            "user_type": 'admin',
          },
          id: userCredentials.user!.uid,
        )
            .then((value) {
          if (value == true) {
            id = userCredentials.user!.uid;
          } else {
            id = '';
          }
        });
      });
    } catch (e) {
      id = '';
    }
    return id;
  }

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    dynamic user;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredentials) async {
        await si.firebaseService
            .getOneDoc(collection: 'users', id: userCredentials.user!.uid)
            .then((value) {
          user = UserModel(
            fName: value!.data()!['first_name'],
            lName: value.data()!['last_name'],
            email: value.data()!['email'],
            phone: value.data()!['phone'],
            location: value.data()!['location'],
            userType: value.data()!['user_type'],
          );
        });
      });
    } catch (e) {
      user = e.toString().split('] ')[1];
    }
    return user;
  }
}
// .split('] ')[1];
//     }