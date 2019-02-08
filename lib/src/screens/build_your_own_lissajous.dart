import 'package:flutter/material.dart';
import '../molecules/orbital.dart';
import '../atom/dashed_line.dart';
import '../atom/lissajous_inanimate.dart';
import '../atom/satellite.dart';

class BuildYourOwnLissajous extends StatefulWidget {
  _BuildYourOwnLissajousState createState() => _BuildYourOwnLissajousState();
}

class _BuildYourOwnLissajousState extends State<BuildYourOwnLissajous> 
  with TickerProviderStateMixin{
  double x, y;
  LissajousPath curve;

  @override
  void initState() {
    x=y=1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double side = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double diameter = side*0.4;
    double padding = side *0.05;
    double sliderHeight = 30;
    
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: (screenHeight - (side+sliderHeight))/2 + padding,
          child: DashedLine(y, false, diameter, this, side),
        ),
        Positioned(
          right: padding,
          top: 0,
          child: DashedLine(x, true, diameter, this, screenHeight),
        ), 
        Container(
          width: side,
          height: side+sliderHeight,//for slider
          child: Stack(
            children: [
              Positioned(
                right: padding,
                top: padding,
                child: _buildSelector(x, true, diameter),
              ),
              Positioned(
                left: padding,
                bottom: padding,
                child: _buildSelector(y, false, diameter),
              ),
              PositionedDirectional(
                end: padding,
                bottom: padding,
                child: _buildDisplay(diameter),
              ),
            ]
          ) 
        )
      ]
    );
  }

  Widget _buildSelector(double axis, bool isXAxis, double diameter){
    Orbital orb = Orbital(isXAxis ? axis : 0, isXAxis ? 0 : axis, ticker: this, diameter: diameter,);
    return Column(children: <Widget>[
    Container(
      width: diameter,
      child: Slider(
        inactiveColor: Colors.grey[800],
        activeColor: orb.generateColor(),
        min: 1.0,
        max: 20,
        value: axis,
        onChanged: (value) => setState(()=> isXAxis ? x=value : y=value),
      )
    ),
    orb,
      ],
    );
  }
  Widget _buildDisplay(double diameter){
    setState(() {
      curve = LissajousPath(
          x, 
          y, 
          Orbital(x, y).generateColor(), 
          diameter: diameter,);
    });
    return Stack(
      children: <Widget>[
        curve,
        Satellite(x, y, diameter, ticker: this),
      ]
    );
  }
}

