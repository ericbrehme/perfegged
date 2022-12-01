import 'package:flutter/material.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:perfegged/functional_elements/dropdownbutton.dart';

const List<String> tempUnitList = <String>['Celsius', 'Fahrenheit', 'Kelvin'];
const List<String> eggSizeStandardList = <String>['Europe', 'North America', 'CIS'];

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              children: const [
                Expanded(
                  child: Text('Temperature Scale',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                dropDownButtonFromList(stringList: tempUnitList),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Row(
              children: const [
                Expanded(
                  child: Text('Egg Size Standard',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                dropDownButtonFromList(stringList: eggSizeStandardList),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
