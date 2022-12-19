import 'package:flutter/material.dart';
import 'package:perfegged/dataclasses/appstate.dart';
import 'package:perfegged/functional_elements/countdown_progress_indicator.dart';
import 'package:vibration/vibration.dart';
import 'package:perfegged/functional_elements/appbar.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class HomescreenCook extends StatefulWidget {
  const HomescreenCook({Key? key}) : super(key: key);

  @override
  _HomescreenCookState createState() => _HomescreenCookState();
}

class _HomescreenCookState extends State<HomescreenCook> {
  final _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Perfegged'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: CountDownProgressIndicator(
                controller: _controller,
                valueColor: Colors.red,
                backgroundColor: Colors.blue,
                initialPosition: 0,
                duration: ((AppState.currPreset!.calculateTimeWeight()) * (60)).toInt(),
                timeFormatter: (seconds) {
                  return Duration(seconds: seconds).toString().substring(2).split('.')[0];
                },
                timeTextStyle: const TextStyle(color: Colors.black),
                labelTextStyle: const TextStyle(color: Colors.black),
                text: 'mm:ss',
                onComplete: () => alarm(),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FlutterRingtonePlayer.stop();
                Navigator.pop(context);
                }, 
              child: Text("Abort Timer", style: Theme.of(context).textTheme.button)),
          ),
        ],
      ),
    );
  }

  void alarm() {
    FlutterRingtonePlayer.play(fromAsset: "assets/sounds/alarm.wav", looping: false, asAlarm: true);
    Vibration.vibrate(duration: 1000);
  }
}
