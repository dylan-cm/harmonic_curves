import 'package:flutter/material.dart';
import 'screens/harmonic_circles.dart';
import 'screens/build_your_own_lissajous.dart';
import 'package:flutter/services.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Lock portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: PageView(
          children: <Widget>[
            HarmonicCircles(),
            BuildYourOwnLissajous()
          ],
        )
      )
    );
  }
}