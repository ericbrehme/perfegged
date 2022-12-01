import 'package:flutter/material.dart';
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

  _HomescreenCookState({required this.preset});

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
            duration: ((preset.calculateTimeWeight()) * (60)).toInt(),
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
