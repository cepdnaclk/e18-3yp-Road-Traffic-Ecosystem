import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCvZbxo-lwr19e6tE-cm7kbg4CHkjmk-6M",
          appId: "1:324383370133:web:c7a778412590a21d43e49c",
          messagingSenderId: "324383370133",
          projectId: "roadsafe-ab1d9"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
