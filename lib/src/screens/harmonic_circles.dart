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
        curves.add(Orbital(x, y));
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
        child: Column(
          children: rows,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );





    // return Column(
    //   // color: Colors.yellow,
    //   // width: size.width,
    //   // height: size.height,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.min,
    //   children: [GridView.builder(
    //     physics: NeverScrollableScrollPhysics(),
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 7,
    //       mainAxisSpacing: 4.0,
    //       crossAxisSpacing: 4.0,
    //     ),
    //     padding: EdgeInsets.all(16.0),
    //     itemCount: 49,
    //     itemBuilder: (context, index){
    //       return Container(
    //         color: Colors.grey,
    //         width: 50,
    //         height: 50,
    //       );
    //     },
    //   ),]
    // );
  }
}