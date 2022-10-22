import 'package:flutter/material.dart';

class dropDownButtonFromList extends StatefulWidget {
  final List<String> stringList; // List of options for dropdown
  const dropDownButtonFromList({ Key? key, required this.stringList}) : super(key: key);

  @override
  State<dropDownButtonFromList> createState() => _dropDownButtonFromListState(chosenStringList: stringList);
}

class _dropDownButtonFromListState extends State<dropDownButtonFromList> {

  List<String> chosenStringList;
  String? defaultValue;

  _dropDownButtonFromListState({required this.chosenStringList});

  @override
  Widget build(BuildContext context) {
    return buildDropdownButton(dropdownList: chosenStringList );
  }

  DropdownButton<Object> buildDropdownButton({required List dropdownList}) {

    defaultValue ??= dropdownList.first; //DEFAULT SELECTED ITEM

    return DropdownButton(
      value: defaultValue,
      isExpanded: false,
      onChanged: (value) => setState(() => defaultValue = value.toString()),
      items: dropdownList.map((items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
          alignment: AlignmentDirectional.centerStart ,
          );
      }).toList(),
    );
  }
}

