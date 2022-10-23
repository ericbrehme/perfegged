import 'package:flutter/material.dart';

import 'functional_elements/appbar.dart';

class Help extends StatelessWidget {
const Help({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(title: 'Help'),
      body: Container(),
      );
  }
}