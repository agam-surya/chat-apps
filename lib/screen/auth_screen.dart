import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/form_auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  void submitFromFn(
      String username, String email, String password, bool isLogin) async {
    try {
      if (isLogin) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        
        // Menambahkan akun ke database firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({'username': username, 'email': email});
      }
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: FormAuth(submitForm: submitFromFn),
    );
  }
}
