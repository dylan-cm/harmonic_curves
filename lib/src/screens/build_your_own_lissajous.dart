import 'package:flutter/material.dart';
import '../molecules/orbital.dart';
import '../atom/dashed_line.dart';

class BuildYourOwnLissajous extends StatefulWidget {
  _BuildYourOwnLissajousState createState() => _BuildYourOwnLissajousState();
}

class _BuildYourOwnLissajousState extends State<BuildYourOwnLissajous> 
  with TickerProviderStateMixin{
  double x, y, diameter;

  @override
  void initState() {
    x=y=1;
    diameter = 180;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment(0, 0),
      child: Stack(
        children: [ 
          Positioned(
            bottom: 201,
            child: DashedLine(y, false, diameter),
          ),
          Positioned(
            right: 17,
            child: DashedLine(x, true, diameter),
          ),
          Positioned(
            right: 16,
            top: 200,
            child: _buildSelector(x, true),
          ),
          Positioned(
            left: 16,
            bottom: 200,
            child: _buildSelector(y, false),
          ),
          Positioned(
            right: 16,
            bottom: 200,
            child: Orbital(x, y, diameter: diameter,),
          ),
        ]
      ) 
    );
  }

  Widget _buildSelector(double axis, bool isXAxis){
    return Column(children: <Widget>[
    Container(
      width: diameter,
      child: Slider(
        inactiveColor: Colors.grey[800],
        activeColor: Orbital(axis, 0).generateColor(),
        min: 1.0,
        max: 20,
        value: axis,
        onChanged: (value) => setState(()=> isXAxis ? x=value : y=value),
      )
    ),
    Orbital(isXAxis ? axis : 0, isXAxis ? 0 : axis, diameter: diameter,),
      ],
    );
  }
}