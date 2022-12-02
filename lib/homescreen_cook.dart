import 'package:flutter/material.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:perfegged/functional_elements/countdown_progress_indicator.dart';
import 'navigation.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:perfegged/dataclasses/preset.dart';

class HomescreenCook extends StatefulWidget {
  final Preset preset;
  const HomescreenCook({Key? key, required this.preset}) : super(key: key);

  @override
  _HomescreenCookState createState() => _HomescreenCookState(preset: preset);
}

class _HomescreenCookState extends State<HomescreenCook> {
  final _controller = CountDownController();
  Preset preset;
  var alarmPlugin = FlutterAlarmBackgroundTrigger();
  int duration = 0;
  DateTime? alarmTime;
  List<AlarmItem> alarms = [];

  _HomescreenCookState({required this.preset}) {
    duration = ((preset.calculateTimeWeight()) * (60)).toInt();
    alarmTime = DateTime.now().add(Duration(seconds: duration));
    print(alarmTime.toString());
    alarmPlugin.requestPermission();
    alarmPlugin.addAlarm(alarmTime!, uid: "com.example.perfegged", screenWakeDuration: Duration(seconds: 20));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Perfegged'),
      drawer: const Navigation(),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: CountDownProgressIndicator(
            controller: _controller,
            valueColor: Colors.red,
            backgroundColor: Colors.blue,
            initialPosition: 0,
            duration: duration,
            timeFormatter: (seconds) {
              return Duration(seconds: seconds).toString().substring(2).split('.')[0];
            },
            timeTextStyle: Theme.of(context).textTheme.headline6,
            labelTextStyle: Theme.of(context).textTheme.headline6,
            text: 'mm:ss',
            onComplete: () => null,
          ),
        ),
      ),
    );
  }
}
