import 'package:flutter/material.dart';
import '../molecules/orbital.dart';

class HarmonicCircles extends StatefulWidget {
  _HarmonicCirclesState createState() => _HarmonicCirclesState();
}

class _HarmonicCirclesState extends State<HarmonicCircles> {
  List<Row> rows = [];

  @override
  void initState() {
    for(var x=0; x <= 7; x++){
      List<Orbital> curves = [];
      for(var y=0; y <= 7; y++){
        curves.add(Orbital(x.toDouble(), y.toDouble()));
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
        // child: Orbital(6, 11, diameter: 200,),
        child: Column(
          children: rows,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}