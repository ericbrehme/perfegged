import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'functional_elements/appbar.dart';
import 'dataclasses/preset.dart';

class Presets extends StatefulWidget {
  const Presets({ Key? key }) : super(key: key);

  @override
  _PresetsState createState() => _PresetsState();
}

// Fetch content from the json file
  Future<List<Preset>> readPresets() async {
    //print("Test");
    final String response = await rootBundle.loadString('resources/presets.json');
    final List<dynamic> data =  jsonDecode(response).toList();
    final List<Preset> presets = data.map((i) => Preset(id: i[0],eggWeight: i[1], envTemp: i[2], yolkTemp: i[3])).toList();
    return presets;
  }
 
class _PresetsState extends State<Presets> {

  List<Preset> _presetList = [];

  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: MyAppBar(title: 'Presets'),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return FutureBuilder<List<Preset>>(
      future: readPresets(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ListTile> tiles = snapshot.data!
            .map((c) => _tile(c.eggWeight.toString(), c.yolkTemp.toString(), c.id.toString())).toList();
            return ListView(children: tiles);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  ListTile _tile(String title, String subtitle, String id) => ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: Text(id),
  ); 
}



