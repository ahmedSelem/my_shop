import 'package:flutter/material.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/first_screen.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/second_screen.dart';
import 'package:page_indicator/page_indicator.dart';

class CollectingDataScreen extends StatefulWidget {
  static const String routeName = '/collectingScreen';
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: height - MediaQuery.of(context).padding.top - 30,
              width: width,
              child: PageIndicatorContainer(
                length: 2,
                indicatorColor: Colors.grey,
                indicatorSelectorColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.only(bottom: 25),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    FirstScreen(),
                    SecondScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
