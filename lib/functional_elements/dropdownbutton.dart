import 'package:flutter/material.dart';

class DropDownButtonFromList extends StatefulWidget {
  final List<String> stringList; // List of options for dropdown
  final String? value;
  const DropDownButtonFromList({Key? key, required this.stringList, this.value}) : super(key: key);

  @override
  State<DropDownButtonFromList> createState() => _DropDownButtonFromListState(chosenStringList: stringList, defaultValue: value);
}

class _DropDownButtonFromListState extends State<DropDownButtonFromList> {
  List<String> chosenStringList;
  String? defaultValue;

  _DropDownButtonFromListState({required this.chosenStringList, this.defaultValue});

  @override
  Widget build(BuildContext context) {
    return buildDropdownButton(dropdownList: chosenStringList);
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
          alignment: AlignmentDirectional.centerStart,
          child: Text(items),
        );
      }).toList(),
    );
  }
}
