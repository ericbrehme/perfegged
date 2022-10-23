import 'package:flutter/material.dart';
import 'functional_elements/appbar.dart';
import 'dataclasses/preset.dart';
import 'reusable_functions/jsonparser.dart';

class Presets extends StatefulWidget {
  const Presets({ Key? key }) : super(key: key);

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
 
  List presets = [];

  @override
  void initState() {
    super.initState();
    presets =  getDataFromJson('assets/data/presets.json');
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: MyAppBar(title: 'Presets'),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
              presets.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: presets.length,
                    itemBuilder: (context, index) {
                      return Card(
                        key: ValueKey(presets[index]['id']),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Text(presets[index]['id'].toString()),
                          title: Text(presets[index]['eggWeight'].toString()),
                          subtitle: Text(presets[index]['yolkTemp'].toString()),
                        ),
                      );
                    }
                  ) 
              )
            : Container()
          ]
        )
      ),
    );
  }
}



