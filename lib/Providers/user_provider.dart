import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  var user;

  Future<String> fetchSignOut(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'email-already-in-use':
          return 'This Email Already In Use';
          break;
        case 'invalid-email':
          return 'Invalid Email';
        default:
          return 'This Password Is Weak';
      }
    } on SocketException catch (error) {
      print(error);
      return 'Network Error';
    }
  }

  Future<String> fetchLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          return 'Invalid Email Or Password';
          break;
        case 'user-disabled':
          return 'User Disabled';
        case 'user-not-found':
          return 'User Not Found';
        default:
          return 'Invalid Email Or Password';
      }
    } on SocketException catch (error) {
      print(error);
      return 'Network Error';
    }
  }

  Future<String> fetshForgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      print(error.code);
      return "Please Try Agin";
    }
  }
}
