import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/provider/map_cordinate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  static String id = 'Map_Screen';
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String locationMessage = "Current Location of the user";
  late String lat = " ";
  late String long;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    lat = "";
  }

  Future<MapCordinate> _getCodinate() async {
    print('ok da chellam paa');

    MapCordinate cord = new MapCordinate();
    cord.lat = " ";
    cord.long = " ";

    final url = Uri.parse(
        'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/Locations.json');
    final response = await http.get(url);
    print(json.decode(response.body));
    print('ok da chellam');
    final extractData = json.decode(response.body) as Map<String, dynamic>;

    extractData.forEach(
      (key, value) {
        if (key == 'User1') {
          cord.lat = value['lat'];
          cord.long = value['long'];
        }
      },
    );

    return cord;

    // var snapshot = await _dbRef.child("UserDetails/$myUserId").get();
    //print(snapshot);
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are diabled");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission  are diabled");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission  are PERMANETLY diabled");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSetting = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSetting)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'Latitude:$lat, Longitude :$long';
      });
    });
  }

  Future<void> _opanMap(String lat, String long) async {
    final url = Uri.parse(
        'https://roadsafe-ab1d9-default-rtdb.firebaseio.com/Locations.json');
    final response = await http.get(url);
    print(json.decode(response.body));
    print('ok da chellam');
    final extractData = json.decode(response.body) as Map<String, dynamic>;

    extractData.forEach(
      (key, value) {
        if (key == 'User1') {
          lat = value['lat'].toString();
          long = value['long'].toString();
        }
      },
    );
    print(lat);
    print(long);
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw 'Could not launch $googleUrl';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current User Location"),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text("LogOut")
                  ],
                )),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            locationMessage,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _getCurrentLocation().then((value) {
                  lat = '${value.latitude}';
                  long = '${value.longitude}';

                  setState(() {
                    locationMessage = 'Latitude:$lat, Longitude :$long';
                  });
                  _liveLocation();
                });
              },
              child: Text("Get Current Location")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _opanMap(lat, long);
              },
              child: const Text("Open in Google Map"))
        ],
      )),
    );
  }
}
