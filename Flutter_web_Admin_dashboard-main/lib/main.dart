import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCvZbxo-lwr19e6tE-cm7kbg4CHkjmk-6M",
          appId: "1:324383370133:web:a2827b6afa3303e643e49c",
          messagingSenderId: "324383370133",
          databaseURL: "https://roadsafe-ab1d9-default-rtdb.firebaseio.com",
          projectId: "roadsafe-ab1d9"));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Eror");
            print(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print("ok");
            return DashboardScreen();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
