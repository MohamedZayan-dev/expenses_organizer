import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';

class SignupLoginButton extends StatelessWidget {
  Function onPressed;
  String text;

  SignupLoginButton({@required this.onPressed, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Material(
        color: kMainColor,
        borderRadius: BorderRadius.vertical(),
        child: MaterialButton(
          minWidth: double.infinity,
          height: 45,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
