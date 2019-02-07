import 'package:flutter/material.dart';
import '../molecules/orbital.dart';

class BuildYourOwnLissajous extends StatefulWidget {
  _BuildYourOwnLissajousState createState() => _BuildYourOwnLissajousState();
}

class _BuildYourOwnLissajousState extends State<BuildYourOwnLissajous> {
  double x, y, diameter;
  Orbital xOrb;

  @override
  void initState() {
    x=y=1;
    diameter = 180;
    xOrb = Orbital(x, 0, diameter: diameter,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            SizedBox(height: diameter, width: diameter,),
            Column(children: <Widget>[
              Container(
            width: diameter,
            child: Slider(
              inactiveColor: Colors.grey[800],
              activeColor: Orbital(x, 0).generateColor(),
              min: 1.0,
              max: 20,
              value: x,
              onChanged: (value) => setState(()=>x=value),
            )
          ),
          Orbital(x, 0, diameter: diameter,),
            ],)
          ],),
          
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Container(width: 10,height: 0, color: Colors.red,),
              Column(
                children: <Widget>[
                  Container(
                    width: diameter,
                    child: Slider( //TODO: make vertical slider package
                      inactiveColor: Colors.grey[800],
                      activeColor: Orbital(y, 0).generateColor(),
                      min: 1.0,
                      max: 20,
                      value: y,
                      onChanged: (value) => setState(()=>y=value),
                    )
                  ),
                  Container(width: 10,),
                  Orbital(0, y, diameter: diameter,),
                  Container(width: 10,),
                ],
              ),
              Orbital(x, y, diameter: diameter,),
            ],
          ),
          
         
          
        ]
      )
    );
  }
}