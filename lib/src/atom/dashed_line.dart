import 'package:flutter/material.dart';
import 'dart:ui';

class DashedLine extends CustomPainter{
  List<Offset> points;

  @override
  void paint(Canvas canvas, Size size){
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

      canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)  => false;
}