import 'package:flutter/material.dart';
import 'package:perfegged/about.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:perfegged/help.dart';
import 'package:perfegged/homescreen_setup.dart';
import 'package:perfegged/myLogin.dart';
import 'package:perfegged/navigation.dart';
import 'package:perfegged/presets.dart';
import 'package:perfegged/permissions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
  ].request();
  if (await Permission.location.isPermanentlyDenied || await Permission.storage.isPermanentlyDenied) {
    // The user opted to never again see the permission request dialog for this
    // app. The only way to change the permission's status now is to let the
    // user manually enable it in the system settings.
    openAppSettings();
  }
  print(statuses[Permission.location]);
  await AppState();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<AppState>(
        create: (context) => AppState(),
        child: MaterialApp(
          initialRoute: '/login',
          routes: {
            '/': (context) => const HomescreenSetup(),
            '/homescreen_setup': (context) => const HomescreenSetup(),
            //'/homescreen_cook': (context) => const HomescreenCook(),
            '/about': (context) => const About(),
            '/presets': (context) => const Presets(),
            '/navigation': (context) => const Navigation(),
            '/help': (context) => const Help(),
            '/login': (context) => const MyLogin(),
            '/permissions': (context) => const Permissions()
          },
          title: 'Perfegged',
          theme: ThemeData(
            //primarySwatch: Colors.grey,
            colorScheme: const ColorScheme.dark(
              primary: Color.fromARGB(255, 40, 121, 123),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ));
  }
}
