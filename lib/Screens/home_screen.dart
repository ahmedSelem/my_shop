import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Screens/authentication_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('myShop'),
      ),
      body: RaisedButton(
        child: Text('Log Out'),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context)
              .pushReplacementNamed(AuthenticationScreen.routeName);
        },
      ),
    );
  }
}
