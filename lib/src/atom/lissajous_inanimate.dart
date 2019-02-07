import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class LissajousPath extends StatelessWidget {
  final double x, y, diameter, weight;
  final Color color;

  LissajousPath(this.x, this.y, this.color, {this.diameter : 44, this.weight: 2.0});

  @override
  Widget build(BuildContext context) {
    double radius = diameter/2;
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment(3, 1),
        child: CustomPaint(
          painter: PathPainter(
            color: color, 
            weight: weight,
            radius: radius,
            x: x,
            y: y,
          ),
          size: Size(radius, radius),
        )
    );
  }
}

class PathPainter extends CustomPainter{
  Color color;
  double weight, radius, x, y;

  PathPainter({this.color, this.weight, this.radius , this.x, this.y});

  @override
  void paint(Canvas canvas, Size size){
    double time = 0;
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = weight
      ..style = PaintingStyle.stroke;

    Path path = Path();

    for(var i = 0; i < 15000; i++) {
      time += 0.0015;
      var dx = (radius) * math.cos(x * time) - radius;
      var dy = (radius) * math.sin(y * time) + 0;
      path.lineTo( dx, dy );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}