import 'package:flutter/material.dart';
import 'screens/harmonic_circles.dart';
import 'screens/build_your_own_lissajous.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: BuildYourOwnLissajous(),
      )
    );
  }
}