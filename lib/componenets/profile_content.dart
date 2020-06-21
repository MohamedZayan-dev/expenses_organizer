import 'dart:io';

import 'package:expenses/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  final imagePicker = ImagePicker();
  File imageFile;
  String name;

  Future getImageFile(ImageSource imageSource) async {
    final file = await imagePicker.getImage(source: imageSource);
    if (file != null) {
      setState(() {
        imageFile = File(file.path);
      });
    }
  }

  Future<void> showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Image from'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await getImageFile(ImageSource.camera);
                    },
                    child: Text('Camera'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await getImageFile(ImageSource.gallery);
                    },
                    child: Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getName() {
    name = firebaseUser.email.substring(
      0,
      firebaseUser.email.indexOf('@'),
    );
  }

  Future getLoggedInUser() async {
    try {
      var user = await firebaseAuth.currentUser();
      if (user != null) {
        firebaseUser = user;
        getName();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: FutureBuilder(
              builder: (context, snapShot) {
                return Text(
                  'Hello ' + name,
                  style: TextStyle(
                      fontSize: 30,
                      color: kMainColor,
                      fontWeight: FontWeight.bold),
                );
              },
              future: getLoggedInUser(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: GestureDetector(
              onTap: () {
                showImageDialog(context);
              },
              child: CircleAvatar(
                radius: 45,
                child: ClipOval(
                  child: imageFile == null
                      ? Text('not found')
                      : Image.file(
                          imageFile,
                          fit: BoxFit.fill,
                          width: 90,
                          height: 100,
                        ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
