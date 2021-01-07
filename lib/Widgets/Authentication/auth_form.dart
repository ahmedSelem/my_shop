import 'package:flutter/material.dart';
import 'package:my_shop/Providers/user_provider.dart';
import 'package:my_shop/Screens/home_screen.dart';
import 'package:my_shop/Widgets/Authentication/auth_title.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final Function toggleForgetPasswordScreen, showError;
  AuthForm(this.toggleForgetPasswordScreen, this.showError);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool loginMood,
      isShowPassword,
      isShowConfirmPassword,
      isLoading;
  String email, password, confirmPassword;
  GlobalKey fieldKey;
  GlobalKey<FormState> form;

  double inputHeight;
  FocusNode passwordNode, confirmPasswordNode;
  @override
  void initState() {
    super.initState();
    loginMood = isShowPassword = isShowConfirmPassword = true;
  
    fieldKey = GlobalKey();
    passwordNode = FocusNode();
    confirmPasswordNode = FocusNode();
    form = GlobalKey<FormState>();
    inputHeight = 0;
    isLoading = false;
  }


  void validateToLogin() async {
    if (form.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .fetchLogin(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        setState(() {
          isLoading = false;
        });
        widget.showError(error);
      }
    }
  }

  void validateToRegister() async {
    if (form.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String error = await Provider.of<UserProvider>(context, listen: false)
          .fetchSignOut(email, password);
      if (error == null) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        setState(() {
          isLoading = false;
        });
        widget.showError(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * .09),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: (loginMood)
                ? AuthTitle('Log Into', UniqueKey())
                : AuthTitle('Create', UniqueKey()),
          ),
          Form(
            key: form,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    passwordNode.requestFocus();
                  },
                  validator: (value) {
                    setState(() {
                      email = value;
                    });
                    if (EmailValidator.validate(email)) {
                      return null;
                    }
                    return 'Email Invalid';
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'example@yahoo.com',
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                  ),
                ),
                TextFormField(
                  key: fieldKey,
                  textInputAction:
                      (loginMood) ? TextInputAction.done : TextInputAction.next,
                  focusNode: passwordNode,
                  onFieldSubmitted: (value) {
                    if (!loginMood) {
                      confirmPasswordNode.requestFocus();
                    }
                  },
                  cursorColor: Colors.white,
                  obscureText: isShowPassword,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    setState(() {
                      password = value;
                    });
                    if (value.length >= 6) {
                      return null;
                    }
                    return 'password must have 6 characters';
                  },
                  decoration: InputDecoration(
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                      child: Icon(
                        (isShowPassword)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: '••••••••',
                    hintStyle: TextStyle(color: Colors.white70),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.redAccent,
                      ),
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent),
                  ),
                ),
                SizedBox(height: 10),
                Opacity(
                  opacity: (loginMood) ? 0 : 1,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: inputHeight,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      focusNode: confirmPasswordNode,
                      cursorColor: Colors.white,
                      obscureText: isShowConfirmPassword,
                      validator: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                        if (loginMood || value == password) {
                          return null;
                        }
                        return 'Confirm Password Don\'t Match Password';
                      },
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isShowConfirmPassword = !isShowConfirmPassword;
                            });
                          },
                          child: Icon(
                            (isShowConfirmPassword)
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: '••••••••',
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: (loginMood)
                    ? FlatButton(
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.toggleForgetPasswordScreen();
                          });
                        },
                      )
                    : null,
              ),
              Container(
                width: double.infinity,
                child: (loginMood)
                    ? (isLoading)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : FlatButton(
                            padding: EdgeInsets.all(16),
                            shape: StadiumBorder(),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              validateToLogin();
                            },
                          )
                    : (isLoading)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : FlatButton(
                            padding: EdgeInsets.all(16),
                            shape: StadiumBorder(),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: () {
                              validateToRegister();
                            },
                          ),
              ),
              Container(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: (loginMood)
                      ? Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have Account ?',
                              key: UniqueKey(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Sign Out',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                final state = fieldKey.currentContext;
                                final box =
                                    state.findRenderObject() as RenderBox;
                                setState(() {
                                  inputHeight = box.size.height;
                                  loginMood = !loginMood;
                                });
                              },
                            ),
                          ],
                        )
                      : Row(
                          key: UniqueKey(),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Are you Have Account ?',
                              key: UniqueKey(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  inputHeight = 0;
                                  loginMood = !loginMood;
                                });
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
