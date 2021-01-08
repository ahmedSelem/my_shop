import 'package:flutter/material.dart';

class CollectingTitle extends StatelessWidget {
  final String title, data;
  CollectingTitle(this.title, this.data);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              color: Theme.of(context).primaryColor,

              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            data,
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
