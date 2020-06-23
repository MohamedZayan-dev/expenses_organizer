import 'package:expenses/screen/expenses_list.dart';
import 'package:expenses/screen/login.dart';
import 'package:expenses/screen/signup.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  bool loggedIn;

  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(kIsLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    isLoggedIn().then((onValue) {
      loggedIn = onValue;
      print("is logged in ? " + loggedIn.toString());
    });
    return MaterialApp(
      home: loggedIn == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : loggedIn ? ExpensesList() : Signup(),
      routes: {
        kSignUpScreen: (context) => Signup(),
        kLoginScreen: (context) => Login(),
        kExpenseList: (context) => ExpensesList(),
      },
    );
  }
}
