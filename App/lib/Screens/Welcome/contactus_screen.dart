import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/home_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:http/http.dart' as http;

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kActiveIconColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kActiveIconColor,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: kActiveIconColor,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      "Contact Us",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: kActiveIconColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              buildTextField("Name", "", false),
              buildTextField("Email", "", false),
              buildTextField("Subject", "", false),
              buildTextField("Message", "", true),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kActiveIconColor,
                        elevation: 2,
                        minimumSize:
                            Size(100, 40) // put the width and height you want
                        ),
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: Text('CANCEL'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: kActiveIconColor,
                          elevation: 10,
                          minimumSize:
                              Size(100, 40) // put the width and height you want
                          ),
                      onPressed: () => Navigator.of(context).pop(true),
                      //return true when click on "Yes"
                      child: Text(
                        'SEND',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      )
                      // OutlineButon(
                      //   padding: EdgeInsets.symmetric(horizontal: 50),
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20)),
                      //   onPressed: () {},
                      //   child: Text("CANCEL",
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           letterSpacing: 2.2,
                      //           color: Colors.black)),
                      // ),
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   color: Colors.green,
                      //   padding: EdgeInsets.symmetric(horizontal: 50),
                      //   elevation: 2,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Text(
                      //     "SAVE",
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         letterSpacing: 2.2,
                      //         color: Colors.white),
                      //   ),
                      // )
                      )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText),
            SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: isPasswordTextField ? 5 : 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  fillColor: kShadowColor,

                  // labelText: labelText,
                  // labelStyle: TextStyle(
                  //   fontSize: 10,
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.black,
                  // ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: placeholder,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
          ],
        ));
  }
}
