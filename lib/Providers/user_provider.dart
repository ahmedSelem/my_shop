import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop/modal/user.dart' as myShop;

class UserProvider with ChangeNotifier {
  myShop.User currentUser;

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

  Future<String> uploadData(File uploadImage, String userName,
      String phoneNumber, String currentAddress) async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final ref = FirebaseStorage.instance
          .ref('Users/$userId.${uploadImage.path.split('.').last}');
      await ref.putFile(uploadImage);
      String photoUrl = await ref.getDownloadURL();

      FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'image': photoUrl,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'currentAddress': currentAddress,
      });
      return null;
    } catch (error) {
      return 'error Accourrd';
    }
  }

  Future<bool> profileComplete() async {
    try {
      String userId = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      final getDocument = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      if (getDocument.exists) {
       currentUser = myShop.User.formFireBase(email, userId, getDocument);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
