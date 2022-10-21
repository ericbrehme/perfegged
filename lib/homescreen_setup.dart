import 'package:flutter/material.dart';

import 'navigation.dart';

class HomescreenSetup extends StatefulWidget {
  const HomescreenSetup({ Key? key }) : super(key: key);

  @override
  _HomescreenSetupState createState() => _HomescreenSetupState();
}

class _HomescreenSetupState extends State<HomescreenSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Row(
          children: [
            Text('Perfegged'),
            Icon(Icons.egg),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0,
      ),
      drawer: const Navigation(),
    );
  }
}