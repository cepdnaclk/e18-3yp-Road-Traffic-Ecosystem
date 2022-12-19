import 'package:flutter_auth/provider/customer.dart';
import 'package:flutter_auth/provider/customers.dart';
import 'package:flutter_auth/provider/customer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';


void main() {
  test('new customer details added', () async {
    Customer initial = new Customer(
        fname: "kumara",
        lname: "Sangakkara",
        eContactNo: "07672709",
        qrcode: "01001010110");
    Customers customerlist = new Customers();
    int number = await customerlist.addCustomer(initial);
    expect(number, 1);
  });
}
