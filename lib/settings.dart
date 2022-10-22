import 'package:flutter/material.dart';

const List<String> tempUnitList = <String>['Celsius', 'Fahrenheit', 'Kelvin'];

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Row(
          children: [
              Text('Settings'),
              Icon(Icons.egg),
            ],
          ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Temperature Scale:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                )
              ),
              tempUnitDropDownButton(),            
            ],
          ),
        ],
      ),
    );
  }
}

class tempUnitDropDownButton extends StatefulWidget {
  const tempUnitDropDownButton({super.key});

  @override
  State<tempUnitDropDownButton> createState() => _tempUnitDropDownButtonState();
}

class _tempUnitDropDownButtonState extends State<tempUnitDropDownButton> {
  String dropdownValue = tempUnitList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.expand_circle_down),
      elevation: 8,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        // fontWeight: FontWeight.bold,
      ),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: tempUnitList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
