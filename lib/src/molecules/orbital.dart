import 'package:flutter/material.dart';
import '../atom/satellite.dart';
import '../atom/path.dart';

class Orbital extends StatelessWidget {
  final int x;
  final int y;
  final double diameter;

  Orbital(this.x, this.y, {this.diameter : 44});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LissajousPath(x, y, _generateColor(), diameter: diameter,),
        Satellite(x, y, diameter),
      ]
    );
  }

  Color _generateColor(){
    double hue = (x+y-2)/2 * 360/7;
    if(x==0 && y==0) return HSVColor.fromAHSV(0,0,0,0).toColor();
    else if(x==0) hue = (y-1) * 360/7;
    else if(y==0) hue = (x-1) * 360/7;
    else {
      if ((x-y).abs()>4) {
        hue +=180;
        if (hue>=360) hue-=360;
      }
    }
    return HSLColor.fromAHSL(1, hue, 0.60, 0.75).toColor();
  }
}