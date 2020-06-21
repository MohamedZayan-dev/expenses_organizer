import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  Firestore firestore = Firestore.instance;
  String dropDownValue = 'Food';
  List<DropdownMenuItem<String>> typeItems = [];

  String title;
  String price;
  int date = DateTime.now().millisecondsSinceEpoch;

  void addItems() {
    for (String item in kTypeDropDownItems) {
      typeItems.add(
        DropdownMenuItem(
          child: Text(item),
          value: item,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xb31E265C),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          border: Border(
            left: BorderSide(width: 4, color: kMainColor),
            right: BorderSide(width: 4, color: kMainColor),
            top: BorderSide(width: 4, color: kMainColor),
            bottom: BorderSide(width: 4, color: kMainColor),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Type',
                        style: TextStyle(color: kMainColor),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: 100,
                      child: DropdownButton<String>(
                        value: dropDownValue,
                        items: typeItems,
                        onChanged: (newValue) {
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 30, bottom: 15),
                child: Text(
                  'Details',
                  style: TextStyle(color: kMainColor),
                ),
              ),
            ),
            Expanded(
              child: Details(
                text: 'Title',
                onComplete: (newV) {
                  title = newV;
                },
                textInputType: TextInputType.text,
                marginRight: 30,
              ),
            ),
            Expanded(
              child: Details(
                text: 'Price',
                onComplete: (newV) {
                  price = newV;
                },
                textInputType: TextInputType.number,
                marginRight: 120,
              ),
            ),
            Expanded(
              child: Center(
                child: MaterialButton(
                  onPressed: () {
                    firestore.collection('expense').add({
                      'type': dropDownValue,
                      'title': title,
                      'price': price,
                      'date': date
                    });
                    Navigator.pushNamed(context, kExpenseList);
                  }, //save and insert new expense
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: kMainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  String text;
  Function onComplete;
  TextInputType textInputType;
  double marginRight;
  Details({this.text, this.onComplete, this.textInputType, this.marginRight});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50, bottom: 30),
          child: Text(
            text,
            style: TextStyle(
              color: Color(0x80E99F3F),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 35,
            color: Colors.white,
            margin: EdgeInsets.only(right: marginRight, bottom: 30),
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              keyboardType: textInputType,
              onChanged: onComplete,
            ),
          ),
        )
      ],
    );
  }
}
