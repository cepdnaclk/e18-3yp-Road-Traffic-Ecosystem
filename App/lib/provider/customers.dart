import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/provider/customer.dart';
class  Customers with ChangeNotifier {
  
  List<Customer> _customerList = [];

  Future<int> addCustomer(Customer customer) async {
   try{

      final url = Uri.parse(
        'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/UserDetails.json');

    await http.post(url,
        body: json.encode({
          'FirstName': customer.fname,
          'LastName': customer.lname,
          'Enumber': customer.eContactNo,
          'QRcode': customer.qrcode
        }));

    final newUser = Customer(
        fname: customer.fname,
        lname: customer.lname,
        eContactNo: customer.eContactNo,
        qrcode: customer.qrcode);


        _customerList.add(customer);
   }
   catch(error ){
print(error);
print("user add aakla");
   }
   notifyListeners();
   return 1;
  }



  List<Customer> get customerList {
    return [...customerList];
  }


  //  User findById(String id) {
  //   return _userList.firstWhere((prod) => prod.id == id);
  // }
}
