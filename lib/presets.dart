import 'package:flutter/material.dart';
import 'functional_elements/appbar.dart';
import 'dataclasses/preset.dart';

class Presets extends StatefulWidget {
  const Presets({ Key? key }) : super(key: key);

  @override
  _PresetsState createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: MyAppBar(title: 'Presets'),
      body: Container(),
    );
  }
}