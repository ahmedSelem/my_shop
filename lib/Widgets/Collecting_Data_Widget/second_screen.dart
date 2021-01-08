
import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Container(color: Colors.red),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}