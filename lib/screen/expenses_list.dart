import 'package:expenses/componenets/expense_details.dart';
import 'package:expenses/componenets/profile_content.dart';
import 'package:expenses/screen/add_expense.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesList extends StatelessWidget {
  Firestore firestore = Firestore.instance;
  String type, title, price;
  void getExpense() async {
    await for (var snapShot in firestore.collection('expense').snapshots()) {
      for (var expense in snapShot.documents) print(expense.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    getExpense();
    double scrreenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => AddExpense());
        },
        backgroundColor: kMainColor,
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              child: Container(
                width: double.infinity,
                height: scrreenHeight * 0.33,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0x1AD26FB5),
                      Color(0x4AD26FB5),
                      Color(0x80D26FB5),
                    ],
                  ),
                ),
                child: ProfileContent(),
              ),
              clipper: ProfileClipper(),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 30),
              child: Text(
                'Recent Expenses',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  firestore.collection('expense').orderBy('date').snapshots(),
              builder: (context, snapShot) {
                List<ExpenseDetails> expenseDetails = [];
                if (snapShot.hasData) {
                  final expenseDoc = snapShot.data.documents;

                  for (var doc in expenseDoc) {
                    type = doc.data['type'];
                    price = doc.data['price'];
                    title = doc.data['title'];
                    expenseDetails.add(
                      ExpenseDetails(
                        title: title,
                        amount: double.parse(price),
                        type: type,
                      ),
                    );
                  }
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: expenseDetails,
                    padding: EdgeInsets.all(20),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.6);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
