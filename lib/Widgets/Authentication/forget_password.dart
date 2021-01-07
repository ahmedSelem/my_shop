import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/Providers/user_provider.dart';
import 'package:my_shop/Widgets/Authentication/auth_title.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  final Function showError;
  ForgetPassword(this.showError);
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formkey;
  String email;
  bool loading;

  @override
  void initState() {
    super.initState();
    formkey = GlobalKey<FormState>();
    loading = false;
  }

  void validateToRestePassword() async {
    if (formkey.currentState.validate()) {
      loading = true;
      String error = await Provider.of<UserProvider>(context, listen: false)
          .fetshForgetPassword(email);
      if (error == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Email Will Be Send Please Check It'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        widget.showError(error);
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width * .09,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTitle(
              'Reset Password Of',
              UniqueKey(),
            ),
            Form(
              key: formkey,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (EmailValidator.validate(value)) {
                    setState(() {
                      email = value;
                    });
                    return null;
                  }
                  return "Please Enter Valid Email";
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  hintText: "____@example.com",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 40,
            ),
            (loading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: StadiumBorder(),
                      onPressed: () {
                        validateToRestePassword();
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
