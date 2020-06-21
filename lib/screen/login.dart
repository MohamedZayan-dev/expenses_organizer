import 'package:expenses/componenets/signup_login_button.dart';
import 'package:expenses/componenets/signup_login_textfield.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class Login extends StatelessWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> myGoogleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount signedInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await signedInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await firebaseAuth.signInWithCredential(authCredential);
      Navigator.pushNamed(context, kExpenseList);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              iconData: Icons.email,
              hintText: 'Email',
              onChanged: (em) {
                email = em;
              },
            ),
            SizedBox(
              height: 15,
            ),
            MySignupLoginTextField(
              iconData: Icons.lock,
              hintText: 'Password',
              onChanged: (pass) {
                password = pass;
              },
            ),
            SizedBox(
              height: 40,
            ),
            SignupLoginButton(
              onPressed: () async {
                //check first if login is successful
                try {
                  final loggedUser =
                      await firebaseAuth.signInWithEmailAndPassword(
                          email: email, password: password);
                  if (loggedUser != null)
                    Navigator.pushNamed(context, kExpenseList);
                } catch (ex) {
                  print(ex);
                }
              },
              text: 'Login',
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 20,
            ),
            GoogleSignInButton(
              onPressed: () async {
                await myGoogleSignIn(context);
              },
              splashColor: Colors.green,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Dont have an account?',
              style: TextStyle(color: kMainColor),
            ),
            FlatButton(
              child: Text(
                'Sign up!',
                style: TextStyle(color: kMainColor),
              ),
              onPressed: () {
                Navigator.pushNamed(context, kSignUpScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
