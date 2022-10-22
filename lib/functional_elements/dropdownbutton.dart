import 'package:flutter/material.dart';

//========================================================
// WIDGET: DROPDOWN MENU WITH OPTIONS FROM LIST INPUT
//--------------------------------------------------------
class dropDownButtonFromList extends StatefulWidget {

  final List<String> stringList; // List of options for dropdown
  const dropDownButtonFromList({ Key? key, required this.stringList}) : super(key: key); // ===> ADDED REQUIRED STRING LIST

  @override
  State<dropDownButtonFromList> createState() => _dropDownButtonFromListState(chosenStringList: stringList);
}
// --------------------------------------------------------
class _dropDownButtonFromListState extends State<dropDownButtonFromList> {

  List<String> chosenStringList;
  String? defaultValue;

  _dropDownButtonFromListState({required this.chosenStringList});

  @override
  Widget build(BuildContext context) {
/*     return Center(child:
    FutureBuilder(future: chosenFutureList, // ===> ADDED FUTURE LIST
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){ List? futureDataList = snapshot.data;
            futureDataList ??= ['Loading']; //if snapshot is null
            return buildDropdownButton(dropdownList: futureDataList );
          }else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }else {
            return Center(child: CircularProgressIndicator());
          }
        }
    )
    ); */
    return buildDropdownButton(dropdownList: chosenStringList );
  }
  //----------------------------------
  // DROPDOWNBUTTON EXTRACTED METHOD
  DropdownButton<Object> buildDropdownButton({required List dropdownList}) {

    defaultValue ??= dropdownList.first; //DEFAULT SELECTED ITEM

    return DropdownButton(
      value: defaultValue,
      onChanged: (value) => setState(() => defaultValue = value.toString()),
      items: dropdownList.map((items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
    );
  }
//----------------------------------
}
//=============================================
