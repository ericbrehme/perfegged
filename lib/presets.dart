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
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: AppState.list!.length,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(AppState.list![index].id),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: Text((index + 1).toString()),
            title: Row(
              children: [
                Text('${AppState.list![index].calcEggSize()} (${AppState.list![index].eggWeight}g)'),
              ],
            ),
            subtitle: Text('${calcYolkConsistency(AppState.list![index].yolkTemp)} (${AppState.list![index].yolkTemp.toString()}°C)'),
            trailing: Text('${AppState.list![index].minutes.toString()}:${AppState.list![index].seconds.toString()}'),
            onTap: () {
              Provider.of<AppState>(context, listen: false).setCurrPreset(AppState.list![index]);
              //AppState().setCurrPreset(AppState.list![index]);
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
                                  .doc(AppState.list![index].id.toString())
                                  .delete();
                              AppState.list!.remove(AppState.list![index]);
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
