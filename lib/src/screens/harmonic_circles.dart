import 'package:flutter/material.dart';
import '../molecules/orbital.dart';

class HarmonicCircles extends StatefulWidget {
  _HarmonicCirclesState createState() => _HarmonicCirclesState();
}

class _HarmonicCirclesState extends State<HarmonicCircles> 
  with TickerProviderStateMixin{
  List<Row> rows = [];
  int gridSize;

  @override
  void initState() {
    gridSize = 6;
    for(var x=0; x <= gridSize; x++){
      List<Orbital> curves = [];
      for(var y=0; y <= gridSize; y++){
        curves.add(Orbital(x.toDouble(), y.toDouble(), ticker: this));
      }
      rows.add(
        Row(
          children: curves,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: size.width, maxWidth: size.width),
        // child: Orbital(4, 2, ticker: this, diameter: 44,),
        child: Column(
          children: rows,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   this.
  //   super.dispose();
  // }
}