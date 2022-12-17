import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';

class UserDetails extends StatefulWidget {
  String qr;

  UserDetails(this.qr);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final enumber = TextEditingController();

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  Future<void> _submit(var fname, var lname, var enumber) async {
    print('ok da chellam paa');
    print(fname);
    print(widget.qr);
    String qr = widget.qr;
    final url = Uri.parse(
        'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/UserDetails.json');
    final response = await http.get(url);
    
    print('ok da chellam');

    await http.post(url,
        body: json.encode({
          'FirstName': '$fname',
          'LastName': '$lname',
          'Enumber': '$enumber',
          'QRcode': '$qr'
        }));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MapScreen()));
    return;

    // var snapshot = await _dbRef.child("UserDetails/$myUserId").get();
    //print(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 150),
            TextFormField(
              controller: fname,
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return 'Invalid name!';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "First Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty || value == null) {
                  return 'Invalid name!';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              controller: lname,
              decoration: InputDecoration(
                hintText: "Last Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: enumber,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter the Phone Number";
                }
                if (int.tryParse(value) == null) {
                  return "Enter the  Phone Number";
                }
                if (int.tryParse(value)! <= 0) {
                  return "Enter the valid Phone Number";
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Emergency Contact No",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone_android),
                ),
              ),
            ),
            SizedBox(height: 50),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () async {
                  await _submit(fname.text, lname.text, enumber.text);
                },
                child: Text(
                  "Submit".toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
