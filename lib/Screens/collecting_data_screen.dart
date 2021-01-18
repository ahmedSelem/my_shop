import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Providers/user_provider.dart';
import 'package:my_shop/Screens/authentication_screen.dart';
import 'package:my_shop/Screens/home_screen.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/first_screen.dart';
import 'package:my_shop/Widgets/Collecting_Data_Widget/second_screen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class CollectingDataScreen extends StatefulWidget {
  static const String routeName = '/collectingScreen';
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController pageViewController;
  File pickedImage;
  String userName, phoneNumber, currentAddress;
  int index;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    pageViewController = PageController();
    isLoading = false;
    index = 0;
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  void nextPage(File pickedImage, String userName, String phoneNumber) {
    setState(() {
      this.pickedImage = pickedImage;
      this.userName = userName;
      this.phoneNumber = phoneNumber;
      index++;
    });
    pageViewController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void prevPage(String currentAddress) {
    pageViewController.previousPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void submitData(String currentAddress) async {
    setState(() {
      this.currentAddress = currentAddress;
      isLoading = true;
    });
    String uploadDone = await Provider.of<UserProvider>(context, listen: false)
        .uploadData(pickedImage, userName, phoneNumber, currentAddress);
    if (uploadDone == null) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      setState(() {
        isLoading= false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Has Accourd Please Try Again'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<bool> prompitCancel() async {
    bool statusDialog = await showDialog(
      context: context,
      builder: (bulider) {
        return AlertDialog(
          title: Text('Are You Soure ?'),
          content: Text(
              'By Logging Out Will Be Asked The Same Information , To Complete Your Profile .'),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );

    return statusDialog;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        bool action = await prompitCancel();
        if (action == false) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context)
              .pushReplacementNamed(AuthenticationScreen.routeName);
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              height: height,
              width: width,
              child: SingleChildScrollView(
                physics: (index == 1)
                    ? NeverScrollableScrollPhysics()
                    : ScrollPhysics(),
                child: SafeArea(
                  child: Container(
                    height: height - MediaQuery.of(context).padding.top - 30,
                    width: width,
                    child: PageIndicatorContainer(
                      length: 2,
                      indicatorColor: Colors.grey,
                      shape: IndicatorShape.roundRectangleShape(
                          size: Size(25, 6), cornerSize: Size.square(10)),
                      indicatorSelectorColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.only(bottom: 25),
                      child: PageView(
                        controller: pageViewController,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          FirstScreen(nextPage, prompitCancel),
                          SecondScreen(prevPage, submitData),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                height: height,
                width: width,
                color: Colors.black38,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
