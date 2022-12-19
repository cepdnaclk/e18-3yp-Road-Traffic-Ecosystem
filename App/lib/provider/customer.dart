
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
class Customer  with  ChangeNotifier {
  late final String fname;
  late final String lname;

  late final String imageUrl;
  late final String eContactNo;
  late final String qrcode;

 Customer({
    required this.fname,
    required this.lname,
    required this.eContactNo,
    required this.qrcode,
  });
}