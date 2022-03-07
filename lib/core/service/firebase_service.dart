import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> register(
      {required String email,
      required String password,
      required String fName,
      required String lName}) async {
    Map<String, dynamic> user = {};
    try {
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _fireStore.collection('users').doc(cred.user!.uid).set({
        "first_name": fName,
        "last_name": lName,
        "email": email,
        "uid": cred.user!.uid,
      }).then((value) {
        user = {
          'user': cred.user!,
        };
      });
    } catch (e) {
      user = {
        'error': e,
      };
    }
    return user;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      } else {
        res = 'Please enter all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
