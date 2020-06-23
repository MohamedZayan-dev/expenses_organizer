import 'package:expenses/componenets/signup_login_button.dart';
import 'package:expenses/componenets/signup_login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:expenses/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatelessWidget {
  Future<bool> _isLogged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(kIsLoggedIn, false);
    return sharedPreferences.getBool(kIsLoggedIn);
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    _isLogged().then((val) {
      print("is logged in ? " + val.toString());
    });
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              'Expenses',
              style: kAppTitleStyle,
            ),
            SizedBox(
              height: 40,
            ),
            MySignupLoginTextField(
              iconData: Icons.person,
              hintText: 'Full name',
            ),
            SizedBox(
              height: 10,
            ),
            MySignupLoginTextField(
              iconData: Icons.email,
              hintText: 'Email',
              onChanged: (newValue) {
                email = newValue;
              },
            ),
            SizedBox(
              height: 10,
            ),
            MySignupLoginTextField(
              iconData: Icons.lock,
              hintText: 'Password',
              onChanged: (newValue) {
                password = newValue;
              },
            ),
            SizedBox(
              height: 30,
            ),
            SignupLoginButton(
              //first check if sign up is successful
              onPressed: () async {
                try {
                  final user =
                      await firebaseAuth.createUserWithEmailAndPassword(
                          email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, kLoginScreen);
                  }
                } catch (ex) {
                  print(ex);
                }

                Navigator.pushNamed(context, kLoginScreen);
              },
              text: 'Signup',
            ),
            SizedBox(height: 50),
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, kLoginScreen);
              },
              child: Text(
                'Already have an account?',
                style: TextStyle(color: kMainColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
