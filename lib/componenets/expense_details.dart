import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';

class ExpenseDetails extends StatelessWidget {
  IconData icon;
  String title;
  double amount;
  String type;
  Function onLongPress;
  ExpenseDetails({this.title, this.amount, this.type, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    icon = type == 'Food'
        ? Icons.restaurant
        : type == 'Shopping'
            ? Icons.shopping_cart
            : type == 'Rent' ? Icons.home : Icons.device_unknown;
    return GestureDetector(
      onLongPress: onLongPress,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Icon(
            icon,
            color: kMainColor,
          )),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    '\$' + amount.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red.shade400,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    DateTime.now().toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 35,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
