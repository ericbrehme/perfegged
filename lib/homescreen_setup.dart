import 'package:flutter/material.dart';
import 'package:perfegged/homescreen_cook.dart';
import 'navigation.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:perfegged/dataclasses/preset.dart';

class HomescreenSetup extends StatefulWidget {
  const HomescreenSetup({Key? key}) : super(key: key);

  @override
  _HomescreenSetupState createState() => _HomescreenSetupState();
}

class _HomescreenSetupState extends State<HomescreenSetup> {
  int _weightValue = 10;
  int _temperatureValue = 8;
  int _pressureValue = 1015;
  int _yolkTemp = 75;

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 16),
          Text('Egg weight', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: _weightValue,
            minValue: 0,
            maxValue: 100,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => _weightValue = value),
          ),
          SizedBox(height: 16),
          Text('Egg Temperature', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: _temperatureValue,
            minValue: 1,
            maxValue: 35,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => _temperatureValue = value),
          ),
          SizedBox(height: 16),
          Text('Air Pressure', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            //selectedTextStyle: TextStyle(fontSize: 16, color: Color(4284809178)), //irgendwie besser machen!
            itemCount: 5,
            itemWidth: 100,
            axis: Axis.horizontal,
            value: _pressureValue,
            minValue: 300,
            maxValue: 1500,
            step: 10,
            haptics: true,
            onChanged: (value) => setState(() => _pressureValue = value),
          ),
          SizedBox(height: 16),
          Text('Yolk Temp', style: Theme.of(context).textTheme.headline6),
          NumberPicker(
            itemCount: 10,
            itemWidth: 50,
            axis: Axis.horizontal,
            value: _yolkTemp,
            minValue: 60,
            maxValue: 100,
            step: 1,
            haptics: true,
            onChanged: (value) => setState(() => _yolkTemp = value),
          ),
          Spacer(),
          ElevatedButton(
            child: Text('Start Timer', style: Theme.of(context).textTheme.button),
            onPressed: () {
              Preset preset = Preset(id: 100, eggWeight: _weightValue, envTemp: _temperatureValue, yolkTemp: _yolkTemp, pressure: _pressureValue);
              //Navigator.push(context, '/homescreen_cook');
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomescreenCook(preset: preset)));
            },
          ),
          SizedBox(height: 24),
        ])));
  }
}
