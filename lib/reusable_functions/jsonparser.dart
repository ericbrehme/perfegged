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
  final jsondata = await rootBundle.loadString(path);
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Preset.fromJson(e)).toList();
}

