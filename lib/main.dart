import 'package:flutter/material.dart';
import 'package:vendors/module/screen/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return MaterialApp(
            title: 'Vendors Home',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SignIn(),
          );
        });
  }
}
