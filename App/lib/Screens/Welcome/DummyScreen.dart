import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dummmy_screen extends StatefulWidget {
  const Dummmy_screen({Key? key}) : super(key: key);

  @override
  State<Dummmy_screen> createState() => _Dummmy_screenState();
}

class _Dummmy_screenState extends State<Dummmy_screen> {
  initState() {
    super.initState();
    getsds();
  }

  void getsds() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("Reading");

// Get the Stream
    Stream<DatabaseEvent> stream = ref.onValue;

// Subscribe to the stream!
    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;
      print('Snapshot: ${event.snapshot.value}'); // DataSnapshot
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(""),
    );
  }
}
