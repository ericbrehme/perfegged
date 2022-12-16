import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key? key, title})
      : super(
          key: key,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.egg),
              Text(title),
              const SizedBox(
                width: 40,
              )
            ],
          ),
          centerTitle: true,
          // backgroundColor: Colors.grey[700],
          elevation: 0,
        );
}
