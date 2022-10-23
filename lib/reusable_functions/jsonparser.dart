import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

List _items = [];

/* Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
} */

Future parseJson(String path) async {
  final String response = await rootBundle.loadString(path);
  final data = await json.decode(response);
  _items = data['Preset'];
}

List getDataFromJson(String path) {
  parseJson(path);
  //print(_items);
  return _items;
}