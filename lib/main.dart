import 'package:flutter/material.dart';
import 'package:perfegged/about.dart';
import 'package:perfegged/help.dart';
import 'package:perfegged/homescreen_cook.dart';
import 'package:perfegged/homescreen_setup.dart';
import 'package:perfegged/loadingscreen.dart';
import 'package:perfegged/navigation.dart';
import 'package:perfegged/presets.dart';
import 'package:perfegged/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/homescreen_setup',
      routes: {
        '/': (context) => const Loadingscreen(),
        '/homescreen_setup': (context) => const HomescreenSetup(),
        '/homescreen_cook': (context) => const HomescreenCook(),
        '/about': (context) => const About(),
        '/presets': (context) => const Presets(),
        '/settings': (context) => const Settings(),
        '/navigation': (context) => const Navigation(),
        '/help': (context) => const Help(),
      },
      title: 'Perfegged',
      theme: ThemeData(
        //primarySwatch: Colors.grey,
        colorScheme: ColorScheme.dark(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

