import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'Welcome/welcome_screen.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> _readItemNames(var qr) async {
    final url = Uri.parse(
        'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/UserDetails.json');
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    extractData.forEach(
      (key, value) {
        if (qr == value['QRcode']) {
          print("already exit");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        }
      },
    );
    http.post(url, body: json.encode({'id': 'kka', 'QRcode': '$qr'}));
    print(json.decode(response.body));

    // var snapshot = await _dbRef.child("UserDetails/$myUserId").get();
    //print(snapshot);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  cutOutSize: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      print('karan qr code');
      print(result!.code);
      _readItemNames(result!.code);
      print("Succes");
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
