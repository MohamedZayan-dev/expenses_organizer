import 'package:expenses/screen/expenses_list.dart';
import 'package:expenses/screen/login.dart';
import 'package:expenses/screen/signup.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(Expenses());

class Expenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Signup(),
      routes: {
        kSignUpScreen: (context) => Signup(),
        kLoginScreen: (context) => Login(),
        kExpenseList: (context) => ExpensesList(),
      },
    );
  }
}
