import 'package:flutter/material.dart';
import 'package:my_shop/Providers/user_provider.dart';
import 'package:my_shop/Screens/collecting_data_screen.dart';
import 'package:my_shop/Screens/home_screen.dart';
import 'package:my_shop/Screens/splash.dart';
import 'package:provider/provider.dart';

class TransitScreen extends StatelessWidget {
  static const String routeName = '/transit';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UserProvider>(context, listen: false).profileComplete(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return CollectingDataScreen();
        }
      },
    );
  }
}
