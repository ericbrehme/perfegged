import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
const Navigation({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    ),
  );
  
  Widget buildHeader(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Container(
      child: Center(
          child: const Text(
            'Menu',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.help),
        title: const Text('Help'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('About'),
        onTap: () {},
      ),
    ],
  );
}



