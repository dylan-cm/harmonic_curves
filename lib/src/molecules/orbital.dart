import 'package:flutter/material.dart';
import '../atom/satellite.dart';

class Orbital extends StatelessWidget {
  final int x;
  final int y;
  final double radius;

  Orbital(this.x, this.y, {this.radius : 44});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: _generateColor(),
              width: 2.0
            )
          ),
        ),

        Satellite(x, y, radius),
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