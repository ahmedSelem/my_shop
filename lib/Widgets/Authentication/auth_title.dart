import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String text;
  AuthTitle(this.text, key) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          Text(
            'Your Account',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 33,
            ),
          ),
        ],
      ),
    );
  }
}
