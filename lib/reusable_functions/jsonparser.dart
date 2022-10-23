import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:perfegged/dataclasses/preset.dart';

List _items = [];

/* Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
} */

Future<List<Preset>> parseJson(String path) async {
  //final String response = await rootBundle.loadString(path);
  final response = await rootBundle.loadString(path);
  //final data = json.decode(presets);
  return 
  //return data.map((e) => Preset(id: e.id, eggWeight: e.eggWeight, envTemp: e.envTemp, yolkTemp: e.yolkTemp)).toList() as Future<List<Preset>>;
}

List<Preset> getDataFromJson(String path) {
  parseJson(path);
  //print(_items);
  return _items;
}