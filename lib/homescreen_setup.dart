import 'package:flutter/material.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:perfegged/homescreen_cook.dart';
import 'package:perfegged/reusable_functions/jsonparser.dart';
import 'package:provider/provider.dart';
import 'navigation.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:perfegged/dataclasses/preset.dart';
import 'package:location/location.dart';
import 'dart:math' as math;

class HomescreenSetup extends StatefulWidget {
  const HomescreenSetup({Key? key}) : super(key: key);

  @override
  _HomescreenSetupState createState() => _HomescreenSetupState();
}

class _HomescreenSetupState extends State<HomescreenSetup> {
/*
  int _weightValue = 0;
  int _temperatureValue = 8;
  int _yolkTemp = 70;
*/
  String _yolkConsistency = "soft liquid";
  int _maxWaterTemp = 100;
  int _waterTemp = 100;
  num _pressureValue = 1015;
  var _locationData;
  String locText = "Loc: unknown";
  List<String> sizeList = [];

  @override
  Widget build(BuildContext context) {
    AppState appState = context.watch<AppState>();
    return Scaffold(
        appBar: MyAppBar(title: 'Perfegged'),
        drawer: const Navigation(),
        floatingActionButton: IconButton(
          onPressed: () => Navigator.pushNamed(context, '/presets'),
          icon: const Icon(Icons.content_paste_search),
          tooltip: 'Presets',
          iconSize: 50,
        ),
        body: Center(
            child: Column(children: <Widget>[
          const SizedBox(height: 16),
          Text('Egg weight', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: appState.getCurrPreset!.eggWeight,
            minValue: 10,
            maxValue: 100,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => appState.getCurrPreset!.eggWeight = value),
          ),
          Text(appState.getCurrPreset!.calcEggSize()),
          const Divider(),
          const SizedBox(height: 16),
          Text('Egg Temperature', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: appState.getCurrPreset!.envTemp,
            minValue: 1,
            maxValue: 35,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => appState.getCurrPreset!.envTemp = value),
          ),
          const Divider(),
          const SizedBox(height: 16),
          Text('Air Pressure', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            //selectedTextStyle: TextStyle(fontSize: 16, color: Color(4284809178)), //irgendwie besser machen!
            itemCount: 5,
            itemWidth: 100,
            axis: Axis.horizontal,
            value: _pressureValue.toInt(),
            minValue: 300,
            maxValue: 1500,
            step: 10,
            haptics: true,
            onChanged: (value) => setState(() {
              _pressureValue = value;
              _waterTemp = calculateWaterTemp(_pressureValue).toInt();
              if (appState.getCurrPreset!.yolkTemp > _waterTemp) {
                appState.getCurrPreset!.yolkTemp = _waterTemp;
              }
              if (_waterTemp <= 100) {
                _maxWaterTemp = _waterTemp;
              }
            }),
          ),
          Text('or fetch location to find pressure', style: Theme.of(context).textTheme.headline6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Find Location', style: Theme.of(context).textTheme.button),
                onPressed: () async {
                  _locationData = await _initLocationService();
                  //print("${_locationData.latitude} ${_locationData.longitude}");
                  var elevation = await parseMapsHTTP(_locationData);
                  var pressure = await parseWeatherHTTP(_locationData);
                  setState(() {
                    locText = ("Loc: (${_locationData.latitude}, ${_locationData.longitude}) @${elevation.toInt()}m");
                    _pressureValue = (pressure * (math.pow((1 - (6.5 * elevation) / 288150), 5.255)));
                  });
                  //print(_pressureValue);
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(locText, style: Theme.of(context).textTheme.bodyText1),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Text('Yolk Temp', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: appState.getCurrPreset!.yolkTemp,
            minValue: 60,
            maxValue: _maxWaterTemp,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() {
              appState.getCurrPreset!.yolkTemp = value;
              _yolkConsistency = calcYolkConsistency(value);
            }),
          ),
          Text(_yolkConsistency, style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                            colors: const [Color.fromARGB(255, 164, 164, 164), Color.fromARGB(255, 255, 255, 255)],
                            radius: 1 - (appState.getCurrPreset!.yolkTemp - 35) * 0.015))),
                Center(
                  child: FractionallySizedBox(
                    heightFactor: 0.65,
                    child: Container(
                        //alignment: AlignmentDirectional(0.5, 0.5),
                        //margin: EdgeInsets.fromWindowPadding(MediaQuery.of(context).viewPadding, MediaQuery.of(context).copyWith().devicePixelRatio),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                                colors: const [Color.fromARGB(255, 255, 226, 184), Color.fromARGB(255, 255, 157, 9)],
                                radius: 1 - (appState.getCurrPreset!.yolkTemp - 50) * 0.02))),
                  ),
                ),
              ],
            ),
          ),
          //Spacer(),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              //Preset preset = Preset(eggWeight: _weightValue, envTemp: _temperatureValue, yolkTemp: _yolkTemp, pressure: _pressureValue.toInt());

              Navigator.push(context, MaterialPageRoute(builder: (context) => HomescreenCook(preset: appState.getCurrPreset!)));
            },
            child: Text('Start Timer', style: Theme.of(context).textTheme.button),
          ),
          const SizedBox(height: 24),
        ])));
  }
}

/* TODO: Handle unavailable Permissions?! */
Future<LocationData> _initLocationService() async {
  var location = Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      //return;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      //return;
    }
  }

  var loc = await location.getLocation();

  return loc;
  //print("${loc.latitude} ${loc.longitude}");
}
