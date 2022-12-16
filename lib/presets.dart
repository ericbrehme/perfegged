import 'package:flutter/material.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:provider/provider.dart';
import 'functional_elements/appbar.dart';
import 'dataclasses/preset.dart';

class Presets extends StatefulWidget {
  const Presets({Key? key}) : super(key: key);

  @override
  _PresetsState createState() => _PresetsState();
}

class _PresetsState extends State<Presets> {
  //late final Future<List<Preset>>? _presets = AppState().getPresets;

  @override
  void initState() {
    super.initState();
    //_presets = parsePresetJson('assets/data/presets.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Presets'),
      //body: futurebuilder(),
      body: listBuilder(),
    );
  }

  Widget listBuilder() {
    return Builder(builder: (context) {
      List<Preset>? presets = AppState.list;
      return _buildListView(presets!);
    });
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
            subtitle: Text('${calcYolkConsistency(presets[index].yolkTemp)} (${presets[index].yolkTemp.toString()}°C)'),
            trailing: Text('${presets[index].minutes.toString()}:${presets[index].seconds.toString()}'),
            onTap: () {
              Provider.of<AppState>(context, listen: false).setCurrPreset(presets[index]);
              //AppState().setCurrPreset(presets[index]);
              Navigator.pop(context);
            },
            onLongPress: () async {
              return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Preset"),
                      content: SingleChildScrollView(
                          child: ListBody(
                        children: const <Widget>[
                          Text('Would you like to remove this Preset?'),
                        ],
                      )),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              AppState.fireStoreInstance!
                                  .collection('users')
                                  .doc(AppState().getUser?.uid)
                                  .collection('presets')
                                  .doc(presets[index].id.toString())
                                  .delete();
                              presets.remove(presets[index]); //in Appstate ändern (muss dort Funktion dafür haben)
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text("Delete"))
                      ],
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
