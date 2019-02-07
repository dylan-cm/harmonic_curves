// import 'package:flutter/material.dart';
// import '../atom/lissajous_inanimate.dart';
// import '../atom/satellite.dart';

// class RateSelector extends StatefulWidget {
//   final double axis, diameter;
//   final bool isXAxis;

//   RateSelector(this.axis, this.isXAxis, this.diameter)

//   _RateSelectorState createState() => _RateSelectorState();
// }

// class _RateSelectorState extends State<RateSelector> {
//   @override
//   Widget build(BuildContext context) {
//     Orbital orb = Orbital(
//       widget.isXAxis ? widget.axis : 0, 
//       widget.isXAxis ? 0 : widget.axis, 
//       ticker: this, 
//       diameter: widget.diameter,);
//     return Column(children: <Widget>[
//     Container(
//       width: widget.diameter,
//       child: Slider(
//         inactiveColor: Colors.grey[800],
//         activeColor: orb.generateColor(),
//         min: 1.0,
//         max: 20,
//         value: widget.axis,
//         onChanged: (value) => setState(()=> widget.isXAxis ? x=value : y=value),
//       )
//     ),
//     orb,
//       ],
//     );
//   }
// }