import 'package:flutter/material.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'navigation.dart';
import 'package:perfegged/functional_elements/appbar.dart';

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
            duration: 20,
            text: 'SEC',
            onComplete: () => null,
          ),
        ),
      ),
    );
  }
}
