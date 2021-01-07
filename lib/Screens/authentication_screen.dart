import 'package:flutter/material.dart';
import 'package:my_shop/Widgets/Authentication/auth_bg_image.dart';
import 'package:my_shop/Widgets/Authentication/auth_form.dart';
import 'package:my_shop/Widgets/Authentication/forget_password.dart';

class AuthenticationScreen extends StatefulWidget {
  static const String routeName = '/Auth-screen';
  @override
  AauthenticationStateScreen createState() => AauthenticationStateScreen();
}

class AauthenticationStateScreen extends State<AuthenticationScreen> {
  bool forgetPassword;
  GlobalKey<ScaffoldState> keyScaffold;
  @override
  void initState() {
    super.initState();
    forgetPassword = false;
    keyScaffold = GlobalKey<ScaffoldState>();
  }
  void showError(String error) {
    keyScaffold.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void toggleForgetPasswordScreen() {
    setState(() {
      forgetPassword = !forgetPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      body: Stack(
        children: [
          AuthBackGroundImage(),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    left: (forgetPassword)
                        ? 0
                        : MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ForgetPassword(showError),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              setState(() {
                                toggleForgetPasswordScreen();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    left: (!forgetPassword)
                        ? 0
                        : -MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: AuthForm(toggleForgetPasswordScreen, showError),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
