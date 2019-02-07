import 'package:flutter/material.dart';
import '../atom/satellite.dart';
import '../atom/lissajous_inanimate.dart';

class Orbital extends StatelessWidget {
  final double x, y, diameter;
  final TickerProvider ticker;

  Orbital(this.x, this.y, this.ticker, {this.diameter : 44});

  @override
  Widget build(BuildContext context) {
    if(x==0 || y==0 || x==y) return Stack(
      children: <Widget>[
        Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(diameter),
            border: Border.all(
              color: generateColor(),
              width: 2.0
            )
          ),
        ),
        Satellite(x, y, diameter, ticker),
      ]
    );
    
    else return Stack(
      children: <Widget>[
        LissajousPath(x.toDouble(), y.toDouble(), generateColor(), diameter: diameter,),
        Satellite(x, y, diameter, ticker),
      ]
    );
  }

  Color generateColor(){
    double hue = (x+y-2)/2 * 360/7;
    if(x==0 && y==0) return HSVColor.fromAHSV(0,0,0,0).toColor();
    else if(x==0) hue = (y-1) * 360/7;
    else if(y==0) hue = (x-1) * 360/7;
    else {
      if ((x-y).abs()>4) {
        hue +=180;
        // if (hue>=360) hue-=360;
        
      }
    }
    hue = hue%360;
    return HSLColor.fromAHSL(1, hue, 0.60, 0.75).toColor();
  }
}