import 'package:expenses/componenets/expense_details.dart';
import 'package:expenses/componenets/profile_content.dart';
import 'package:expenses/screen/add_expense.dart';
import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  Firestore firestore = Firestore.instance;

  String type, title, price;

  Future _isLogged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(kIsLoggedIn, true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged().then((onValue) {
      print(onValue.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrreenHeight = MediaQuery.of(context).size.height;
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

                  for (int i = 0; i < expenseDoc.length; i++) {
                    type = expenseDoc[i].data['type'];
                    price = expenseDoc[i].data['price'];
                    title = expenseDoc[i].data['title'];
                    expenseDetails.add(
                      ExpenseDetails(
                        title: title,
                        amount: double.parse(price),
                        type: type,
                        onLongPress: () async {
                          await Firestore.instance.runTransaction(
                              (Transaction myTransaction) async {
                            await myTransaction.delete(expenseDoc[i].reference);
                          });
                        },
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
