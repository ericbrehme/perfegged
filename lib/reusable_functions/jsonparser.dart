import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:perfegged/dataclasses/preset.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

Future<List<Preset>> parsePresetJson(String path) async {
  final jsondata = await rootBundle.loadString(path);
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Preset.fromJson(e)).toList();
}

Future<double> parseMapsHTTP(LocationData locationData) async {
  String lat = locationData.latitude.toString();
  String lon = locationData.longitude.toString();
  String uri = "https://maps.googleapis.com/maps/api/elevation/json?locations=$lat,$lon&key=AIzaSyB1qqRy07-ORTLM8QbZM3d7a1r2p6GYFCA";
  final response = await http.post(Uri.parse(uri));
  final list = jsonDecode(response.body);
  print("Elevation: ${list['results'][0]['elevation']}");
  return list['results'][0]['elevation'];
}

Future<int> parseWeatherHTTP(LocationData locationData) async {
  String lat = locationData.latitude.toString();
  String lon = locationData.longitude.toString();
  String uri = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=abc40fbb218e98fa5cf8c435ac72bb3e";
  final response = await http.post(Uri.parse(uri));
  final list = jsonDecode(response.body);
  print("Pressure: ${list['main']['pressure']}");
  return list['main']['pressure'];
}
