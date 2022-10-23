import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:perfegged/dataclasses/preset.dart';

Future<List<Preset>> parseJson(String path) async {
  final jsondata = await rootBundle.loadString(path);
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Preset.fromJson(e)).toList();
}

