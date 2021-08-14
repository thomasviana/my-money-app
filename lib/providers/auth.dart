import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  late String userId;
  late String userName;

  // Future<void> FetchUserData() async {
  //   final userData = await FirebaseFirestore.instance.collection('users').doc().get();
  //   print(userData)
  // }

  Future<void> login(String email, String password) async {
    final existingUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    userId = existingUser.user!.uid;
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(newUser.user!.uid)
        .set({
      'name': name,
      'email': email,
    });
    userId = newUser.user!.uid;
    userName = name;
    notifyListeners();
  }
}
