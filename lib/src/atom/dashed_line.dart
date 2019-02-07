import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class DashedLine extends StatefulWidget {
  final double value, constraint;
  final bool isVertical;
  final TickerProvider ticker;

  DashedLine(this.value, this.isVertical, this.constraint, this.ticker);

  _DashedLineState createState() => _DashedLineState();
}

class _DashedLineState extends State<DashedLine> 
  with TickerProviderStateMixin{
  Animation lineAnimation;
  AnimationController lineController;

  List<Offset> points =[];

  @override
  void initState() {
    for(var i=0; i<100; i++){
      if(!widget.isVertical)points.add( Offset(i*10.0, 0) );
      else points.add( Offset(0, i*10.0) );
    }

    lineController = AnimationController(
      vsync: widget.ticker,
      duration: Duration(milliseconds: (10000/widget.value).round())
    );
    
    lineAnimation = Tween(begin: 0, end: 2*math.pi).animate(
      CurvedAnimation(
        parent: lineController,
        curve: Curves.linear,
      )
    );

    lineController.repeat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: lineAnimation,
      child: CustomPaint(
        painter: DashedLinePainter(points),
      ),
      builder: (context, child){
        return Container(
          height: widget.isVertical? MediaQuery.of(context).size.width : widget.constraint,
          width: widget.isVertical? widget.constraint : MediaQuery.of(context).size.height,
          alignment: Alignment( 
            widget.isVertical? math.cos(lineAnimation.value) : -1.0,
            widget.isVertical? -1.0 : math.sin(lineAnimation.value),
          ),
          child: child
        );
      },
    );
  }

  @override
  void didUpdateWidget(DashedLine oldWidget) {
    setState(() {
      lineController.duration=Duration(milliseconds: (10000/widget.value).round());
      lineController.reset();
      lineController.repeat();
    });
    super.didUpdateWidget(oldWidget);
  }
}
class DashedLinePainter extends CustomPainter{
  List<Offset> points;

  DashedLinePainter(this.points);

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