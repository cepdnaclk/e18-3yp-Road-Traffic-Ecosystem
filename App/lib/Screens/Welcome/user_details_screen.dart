import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/Screens/Welcome/home_screen.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:flutter_auth/provider/customers.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/customer.dart';

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
  final _formKey = GlobalKey<FormState>();
  var uid;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  // Future<void> _submit(var fname, var lname, var enumber) async {
  //   Customer customer = new Customer(
  //       fname: fname, lname: lname, qrcode: widget.qr, eContactNo: enumber);
  //   await Provider.of<Customers>(context, listen: false).addCustomer(customer);

  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //   return;

  //   // var snapshot = await _dbRef.child("UserDetails/$myUserId").get();
  //   //print(snapshot);
  // }

  Future<void> _submit(var fname, var lname, var enumber) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("accident_check");

    ref.child("$uid").update({
      'check1': false,
      'check2': true,
    });
    bool isValid = false;
    if (_formKey.currentState == null) {
      isValid = false;
    } else if (_formKey.currentState!.validate()) {
      isValid = true;
    }

    try {
      print('ok da chellam paa');
      print(fname);
      print(widget.qr);
      String qr = widget.qr;
      final url = Uri.parse(
          'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/UserDetails.json');
      final response = await http.get(url);

      print('ok da chellam');

      final url1 = Uri.parse(
          'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/Devices/device_map.json');
      print("hari si mass");
      print(uid);

      await http.post(url1,
          body: json.encode({
            '$qr': '$uid',
          }));

      // final url2 = Uri.parse(
      //     'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/accident_check/$uid.json');
      // print("hari si mass");
      // print(uid);

      // await http.post(url2,
      //     body: json.encode({
      //       'check1': 'false',
      //       'check2': 'true',
      //     }));

      await http.post(url,
          body: json.encode({
            'FirstName': '$fname',
            'LastName': '$lname',
            'Enumber': '$enumber',
            'QRcode': '$qr'
          }));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      return;
    } on PlatformException catch (err) {
      var message = "error irukkuda check your credential";
      if (err.message != null) message = err.message!;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    uid = user?.uid;
    print("str uid");
    print(uid);
    super.initState();
  }

  // var snapshot = await _dbRef.child("UserDetails/$myUserId").get();
  //print(snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            const Spacer(),
            Expanded(flex: 8, child: Lottie.asset('assets/userde.json')),
            const Spacer(),
            TextFormField(
              key: Key("fname-field"),
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
                fillColor: Color.fromARGB(255, 240, 219, 205),
                hintText: "First Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.person,
                    color: kActiveIconColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              key: Key("lname-field"),
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
                fillColor: Color.fromARGB(255, 240, 219, 205),
                hintText: "Last Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.person,
                    color: kActiveIconColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              key: Key("enumber-field"),
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
                fillColor: Color.fromARGB(255, 240, 219, 205),
                hintText: "Emergency Contact No",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                    Icons.phone_android,
                    color: kActiveIconColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kActiveIconColor, elevation: 0),
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
    ));
  }
}
