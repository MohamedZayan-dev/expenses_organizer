import 'package:expenses/screen/expenses_list.dart';
import 'package:expenses/screen/login.dart';
import 'package:expenses/screen/signup.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  bool loggedIn = false;

  Future isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(kIsLoggedIn) == null) {
      await sharedPreferences.setBool(kIsLoggedIn, false);
    }
    loggedIn = sharedPreferences.getBool(kIsLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          return loggedIn ? ExpensesList() : Signup();
        },
      ),
      routes: {
        kSignUpScreen: (context) => Signup(),
        kLoginScreen: (context) => Login(),
        kExpenseList: (context) => ExpensesList(),
      },
    );
  }
}
