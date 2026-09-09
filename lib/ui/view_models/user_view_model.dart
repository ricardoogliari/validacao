import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  User? user;

  UserViewModel() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user = user;
      notifyListeners();
    });
  }
}
