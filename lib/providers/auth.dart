import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  String? _token;
  // DateTime _expiryDate;
  late String _userId = '';
  late String _userName;

  // bool get isAuth {
  //   return token != null;
  // }

  // String? get token {
  //   if (_expiryDate.isAfter(DateTime.now())) {
  //     return _token;
  //   }
  // }

  String get userId {
    return _userId;
  }

  String get userName {
    return _userName;
  }

  Future<void> fetchUserData() async {
    final userData = await FirebaseAuth.instance.currentUser;
    _userId = userData!.uid;
    print(userId);

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final existingUser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _userId = existingUser.user!.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    _userName = userData['name'];
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
    _userId = newUser.user!.uid;
    _userName = name;
    notifyListeners();
  }
}
