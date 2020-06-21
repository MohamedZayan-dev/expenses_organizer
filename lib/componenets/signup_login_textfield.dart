import 'package:flutter/material.dart';
import 'package:expenses/services/constants.dart';

class MySignupLoginTextField extends StatelessWidget {
  IconData iconData;
  String hintText;
  Function onChanged;
  MySignupLoginTextField({this.iconData, this.hintText, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: TextField(
        onChanged: onChanged,
        style: kTextFieldStyle,
        decoration: (InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            iconData,
            size: kRegisterationIconSize,
            color: kMainColor,
          ),
          hintText: hintText,
          hintStyle: kHintTextStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        )),
      ),
    );
  }
}
