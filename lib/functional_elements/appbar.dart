import 'package:flutter/material.dart';


class MyAppBar extends AppBar {
 
  MyAppBar({ Key? key , title}) :
    super(
      key: key,
      title: Row(
        children: [
          Text(title),
          Icon(Icons.egg),
        ],
      ),
      centerTitle: true,
      backgroundColor: Colors.grey[700],
      elevation: 0,
    );
      
}