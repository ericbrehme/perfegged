import 'package:flutter/material.dart';
import 'functional_elements/appbar.dart';
import 'dataclasses/preset.dart';
import 'reusable_functions/jsonparser.dart';

class Presets extends StatefulWidget {
  const Presets({Key? key}) : super(key: key);

  @override
  _PresetsState createState() => _PresetsState();
}

/* // Fetch content from the json file
  Future<List<Preset>> readPresets() async {
    //print("Test");
    final String response = await rootBundle.loadString('resources/presets.json');
    final List<dynamic> data =  jsonDecode(response).toList();
    final List<Preset> presets = data.map((i) => Preset(id: i[0],eggWeight: i[1], envTemp: i[2], yolkTemp: i[3])).toList();
    return presets;
  } */

class _PresetsState extends State<Presets> {
  late Future<List<Preset>> _presets;

  @override
  void initState() {
    super.initState();
    _presets = parsePresetJson('assets/data/presets.json');
  }

  Widget futurebuilder() {
    return FutureBuilder<List<Preset>>(
        future: _presets,
        builder: (context, snapshot) {
          List<Preset>? presets = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _buildListView(presets!);
            default:
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
          }
          ;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Presets'),
      body: futurebuilder(),
    );
  }

  Widget _buildListView(List<Preset> presets) {
    return ListView.builder(
      itemCount: presets.length,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(presets[index].id),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Text(presets[index].id.toString()),
            title: Row(
              children: [
                Text('${presets[index].calcEggSize()} (${presets[index].eggWeight}g)'),
              ],
            ),
            subtitle: Text('${presets[index].calcYolkConsistency()} (${presets[index].yolkTemp.toString()}°C)'),
            trailing: Text('${presets[index].minutes.toString()}:${presets[index].seconds.toString()}'),
          ),
        );
      },
    );
  }
}
