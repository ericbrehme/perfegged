import 'package:flutter/material.dart';
import 'functional_elements/appbar.dart';

class About extends StatelessWidget {
const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MyAppBar(title: 'About'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            aboutEntry(context, title: "Version", value: "1.0"),
            Divider(),
            aboutEntry(context, title: "Authors", value: "Kevin Knippschild & Eric Brehme"),
            Divider(),
            Flexible(
              child: Text(
                "Entwickelt für das Semesterprojekt des Kurses Mobile Systeme im Wintersemester 22/23 an der FH-Kiel",
                style: Theme.of(context).textTheme.bodyLarge,
                ),
            )
          ],
        ),
      ),
      );
  }

  Widget aboutEntry( 
    BuildContext context,
  {  
    required String title,
    required String value
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]
      ),
    );
  }
}