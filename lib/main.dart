import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:flutter/services.dart';

void main() {
  //Lock portrait orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new App());
    });
}