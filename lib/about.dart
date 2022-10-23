import 'package:flutter/material.dart';

import 'functional_elements/appbar.dart';

class About extends StatelessWidget {
const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(title: 'About'),
      body: Container(),
      );
  }
}