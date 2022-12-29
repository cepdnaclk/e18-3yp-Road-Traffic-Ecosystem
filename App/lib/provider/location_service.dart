import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
  final String key = 'AIzaSyD8QEGy23N7qzn7uDSevulFSvO2ByQs31Y';
  Future<String> getPlaceId(String input) async {
    print("karan is map");
    print(input);
    print(key);
    print("object");
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    print("karan is map sol");
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    print("karan is map solvan");
    var json = convert.jsonDecode(response.body);
    print(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    print("karan is map");
    return placeId;
  }



   Future<Map<String,dynamic>> getPlace(String input) async {
     var placeId= await getPlaceId(input);
         final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
         var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    print("karan is map solvan");
    var json = convert.jsonDecode(response.body);
    var results=json['result'] as Map<String,dynamic>;
    print(results);
    return results;

  }
}
