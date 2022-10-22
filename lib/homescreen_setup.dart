import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:perfegged/functional_elements/appbar.dart';

class HomescreenSetup extends StatefulWidget {
  const HomescreenSetup({ Key? key }) : super(key: key);

  @override
  _HomescreenSetupState createState() => _HomescreenSetupState();
}

class _HomescreenSetupState extends State<HomescreenSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Perfegged'),
      drawer: const Navigation(),
    );
  }
}

