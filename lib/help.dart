import 'package:flutter/material.dart';
import 'functional_elements/appbar.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Help'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              heightFactor: 2,
              child: Text(
                "How To Use",
                style: Theme.of(context).textTheme.headline5)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
              child: Text(
                "The app requires certain parameters to calculate the exact cooking time for your desired egg consistency. "
                "These values can be adjusted by using the sliders on the homescreen and can be saved for later use if you are logged in.",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
            instructionWidget(
              context, 
              number: 1,
              title: "Egg Weight:",
              content:  
                "Measure the weight of your eggs or estimate them roughly by looking for you eggsize (S, M, L, etc.).\n"
                "If you have multiple eggs with vastly different weights, either consider cooking them seperatly or set the weight to be the average. "
                "This may lead to undesired results."
            ),
            instructionWidget(
              context,
              number: 2,
              title: "Egg Temperature",
              content:
                "Eggs idealy should be at the same starting temperature. "
                "If you store them in your fridge, that might be roughly 8 C°, otherwise choose your rooms current temperatur as the value."
              ),
            instructionWidget(
              context,
              number: 3,
              title: "Air Pressure",
              content: 
                "The boiling temperature of water depends on it's surrounding environments pressure. The lower the air pressure, the lower the temperature. "
                "Idealy you'd want to get your value from a barometer and set it manually, but you can also use your current location data to request the atmosperic pressure "
                "for your location from openweather.com. This needs a working internet connection and GPS permission enabled. Air pressure will be automaticly set after pressing the 'Find Location'-button."
              ),
            instructionWidget(
              context,
              number: 4,
              title: "Yolk Temp",
              content:
                "This is the value which determines the consistency of your eggs. The higher the temperature of the yolk, the firmer the consistency. "
                "You can see a rough estimate via the discriptor below the slider, or the graphical representation, which shows how your egg will look like."
            ),
            instructionWidget(context,
              number: 5,
              title: "Cooking Your Eggs",
              content:
                "Fill enough water into a pot so the eggs can be fully emerged in the water. "
                "The more water the better, since putting the cold eggs in the boiling water can cool it down and can prolong the required cooking time. "
                "You might want to gently puncture the shell of the eggs on the side where theres usually an air bubble, so they dont break as the air expands through the heat. "
                "When the water is at boiling temperature, quickly insert the eggs with a spoon and press the 'Start Timer'-button. "
                "As soon as the alarm is triggered, take the pot off the stove and immediatly cool the eggs down with cold water, so the cooking process is stopped."
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
              child: Text(
                "Enjoy your perfeggedly boiled eggs! ;)",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
            const SizedBox(
              height: 36,
            )
          ],
        ),
      ),
    );
  }

  Widget instructionWidget(BuildContext context, {required int number, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Text("$number.", style: Theme.of(context).textTheme.headline6),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text(content, style: Theme.of(context).textTheme.bodyText1 ,textAlign: TextAlign.justify),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
