import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Providers/user_provider.dart';
import 'package:my_shop/Screens/authentication_screen.dart';
import 'package:my_shop/Screens/collecting_data_screen.dart';
import 'package:my_shop/Screens/home_screen.dart';
import 'package:my_shop/Screens/splash.dart';
import 'package:my_shop/Screens/transit_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'MontAl',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (FirebaseAuth.instance.currentUser != null) {
              return TransitScreen();
            } else {
              return AuthenticationScreen();
            }
          }
        },
      ),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
        CollectingDataScreen.routeName: (context) => CollectingDataScreen(),
        TransitScreen.routeName: (context) => TransitScreen(),
      },
    );
  }
}
