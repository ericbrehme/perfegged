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
  late Future<List<Preset>> _presets;

  @override
  void initState() {
    super.initState();
    _presets = parseJson('assets/data/presets.json');
  }

  @override
  Widget build(BuildContext context) {
        return FutureBuilder<List<Preset>>(
          future: _presets,
          builder: (ctx, snapshot) {
            List<Preset>? presets = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.done:
              return _buildListView(presets!);
              default:
              return _buildLoadingScreen();
            }
      }
    );
  }


  Widget _buildListView(List<Preset> presets) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return PresetCard(presets[idx]);
      },
      itemCount: presets.length,
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
        child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
        ),
      );
  }
}


class PresetCard extends StatelessWidget{
  final Preset preset;

  PresetCard(this.preset);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10),
            child: Text(
              preset.id.toString(),
            ),
          ),
          Expanded(
            child: Text (
              preset.eggWeight.toString(),
            )
          ),
          Expanded(
            child: Text(
              preset.yolkTemp.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
 



