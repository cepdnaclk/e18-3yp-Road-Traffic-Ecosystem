// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/provider/location_service.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late String uid;
  //final uid = user.uid;

  Set<Polyline> _polylines = Set<Polyline>();
  int _polylinecounter = 1;
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _newmarkers = <Marker>[];

  final List<LatLng> _latlong = <LatLng>[LatLng(9.7670, 79.9399)];

  String images = 'assets/icons/marker.png';
  Uint8List? markerImage;
  static const double _deafultlat = 9.7667;
  static const double _defaultlong = 79.939869;
  static CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(_deafultlat, _defaultlong), zoom: 15);
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(_deafultlat, _defaultlong), zoom: 15);

  MapType _currentTypeMap = MapType.normal;

  final Set<Marker> _markers = {};
  Future<void> _goToCity(
    double lat,
    double long,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double long = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 15)));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _removePolyline() {
    _polylines.clear();
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdval = 'polyline_$_polylinecounter';
    _polylinecounter++;
    _polylines.add(Polyline(
      polylineId: PolylineId(polylineIdval),
      width: 5,
      color: Colors.blue,
      points: points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
    ));
    print("intha fuctionwrk ok");
  }

  void _addMarker() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('defaultlocation'),
          position: _defaultLocation.target,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(
              title: "This is your place", snippet: "You are super Hero")));
    });
  }

  void getsds() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("NearbyAccidents/$uid/acc_coordinates");

// Get the Stream

    Stream<DatabaseEvent> stream = ref.onValue;

// Subscribe to the stream!

    stream.listen((DatabaseEvent event) {
      print('Event Type: ${event.type}'); // DatabaseEventType.value;

      print('Snapshot: ${event.snapshot.value}');
      final extractData = event.snapshot.value; // DataSnapshot
      // Map<dynamic, dynamic> map = event.snapshot.value as dynamic;

      List<dynamic> list = [];
      List<Object?> map1 = event.snapshot.value as dynamic;
      list.clear();
      for (int i = 0; i < map1.length; i++) {
        print(map1[i].runtimeType);
        final mapCreated = Map.from(map1[i] as Map<Object?, Object?>);
        print(mapCreated.keys);
        print('working');
        print(mapCreated['lat']);
        _latlong.add(LatLng(double.parse(mapCreated['lat'].toString()),
            double.parse(mapCreated['long'].toString())));
      }
      //list = map.values.toList();
      //print(extractData.toString().length);
      ;

      // print("nishani");

      for (int i = 0; i < _latlong.length; i++) print(_latlong[i]);
      loadData();
    });
  }

  void _changeMapType() {
    setState(() {
      _currentTypeMap = _currentTypeMap == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    var uid = user?.uid;
    print("mela irukkirathu thaan uid");
    print(uid);

    print(uid);

    // TODO: implement initState
    super.initState();
    getsds();
  }

  loadData() async {
    final Uint8List markerIcon = await getBytesFromAssets(images, 200);
    print(_latlong.length);
    for (int i = 0; i < _latlong.length; i++) {
      print("karan");
      print(i);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latlong[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow: InfoWindow(title: "this is accident ")),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print(_originController.text);
        if (_originController.text == "" && _destinationController.text == "") {
          return true;
        } else {
          setState(() {
            _originController.clear();
            _destinationController.clear();
            _polylines.clear();
          });
          return false;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Near By Accidents"),
            backgroundColor: kActiveIconColor,
            elevation: 0,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _originController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              prefixIconColor: kActiveIconColor,
                              border: OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.location_on),
                              hintText: "orgin",
                              fillColor: kShadowColor),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        TextFormField(
                          controller: _destinationController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.location_on),
                              prefixIconColor: kActiveIconColor,
                              hintText: "destination",
                              fillColor: kShadowColor),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Color(0xFFE68342),
                        backgroundColor: Color(0xFFE68342),
                        disabledBackgroundColor: Color(0xFFE68342),
                        hoverColor: kActiveIconColor,
                        focusColor: kActiveIconColor,
                        highlightColor: kActiveIconColor,
                      ),
                      color: kActiveIconColor,
                      onPressed: () async {
                        // print(_serchController.text);
                        var directions = await LocationService().getDirrection(
                            _originController.text,
                            _destinationController.text);
                        print("karean icon");
                        print("sd");
                        print(directions);
                        _goToCity(
                            directions['start_location']['lat'],
                            directions['start_location']['lng'],
                            directions['bounds_ne'],
                            directions['bounds_sw']);
                        // _goToCity(place);
                        print("karan is");
                        setState(() {
                          _setPolyline(directions['polyline_decoded']);
                        });
                        print(directions['polyline_decoded']);
                        print("karan is not");
                      },
                      icon: Icon(Icons.search)),
                ],
              ),
              // Row(
              //   children: [
              //     Expanded(

              //         child: TextFormField(
              //       controller: _serchController,
              //       textCapitalization: TextCapitalization.words,
              //       decoration: InputDecoration(hintText: "Search"),
              //       onChanged: (value) {
              //         print(value);
              //       },
              //     )),

              //   ],
              // ),
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      polylines: _polylines,
                      initialCameraPosition: _kGooglePlex,
                      mapType: _currentTypeMap,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      markers: _markers,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12, right: 12),
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            onPressed: _changeMapType,
                            backgroundColor: Colors.green,
                            child: const Icon(
                              Icons.map,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FloatingActionButton(
                              child: Icon(
                                Icons.add_location,
                                size: 37,
                              ),
                              onPressed: _addMarker,
                              backgroundColor: Colors.deepPurple)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
