import 'package:flutter/material.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:perfegged/about.dart';
import 'package:perfegged/help.dart';
import 'package:perfegged/homescreen_setup.dart';
import 'package:perfegged/loadingscreen.dart';
import 'package:perfegged/myLogin.dart';
import 'package:perfegged/navigation.dart';
import 'package:perfegged/presets.dart';
import 'package:perfegged/settings.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterAlarmBackgroundTrigger.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
        //'/homescreen_cook': (context) => HomescreenCook(),
        '/about': (context) => const About(),
        '/presets': (context) => const Presets(),
        '/settings': (context) => const Settings(),
        '/navigation': (context) => const Navigation(),
        '/help': (context) => const Help(),
        '/login': (context) => const MyLogin()
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
