import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _newmarkers = <Marker>[];
  final List<LatLng> _latlong = <LatLng>[
    LatLng(9.7670, 79.9399),
    LatLng(9.7675, 79.9429),
    LatLng(9.7670, 79.9450)
  ];

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

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _addMarker() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('defaultlocation'),
          position: _defaultLocation.target,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: const InfoWindow(
              title: "This is your place", snippet: "You r super Hero")));
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
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    final Uint8List markerIcon = await getBytesFromAssets(images, 200);
    for (int i = 0; i < 3; i++) {
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
    return Scaffold(
      appBar: AppBar(title: Text("Near By Accidents")),
      body: Stack(
        children: [
          GoogleMap(
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
    );
  }
}
