import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class LissajousPath extends StatefulWidget {
  final double x;
  final double y;
  final double diameter;
  final Color color;
  final double weight;

  LissajousPath(this.x, this.y, this.color, {this.diameter : 44, this.weight: 2.0});

  _LissajousPathState createState() => _LissajousPathState();
}

class _LissajousPathState extends State<LissajousPath> with TickerProviderStateMixin{
  Animation<double> dx, dy, cycle;
  AnimationController dxController, dyController, cycleController;

  double x, y, radius;
  List<Offset> _points = <Offset>[];

  @override
  void initState() {
    if(widget.x==0 && widget.y==0){x=y=1; radius = 0;}
    else if(widget.x==0) {x=y=widget.y;}
    else if (widget.y==0) {x=y=widget.x;}
    else {x=widget.x; y=widget.y;}

    radius = widget.diameter/2;

    dxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/x).round())
    );
    
    dx = Tween(begin: 0.0, end: 2.0*math.pi).animate(
      CurvedAnimation(
        parent: dxController,
        curve: Curves.linear,
      )
    );

    dyController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/y).round())
    );
    
    dy = Tween(begin: 0.0, end: 2.0*math.pi).animate(
      CurvedAnimation(
        parent: dyController,
        curve: Curves.linear,
      )
    );

    cycleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10000),
    );
    
    cycle = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: cycleController,
        curve: Curves.linear,
      )
    );

    dxController.repeat();
    dyController.repeat();
    cycleController.forward();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cycle,
      builder: (context, child){
        if (cycleController.status==AnimationStatus.completed||_points.length>1200){
          _points.clear();
          cycleController.reset();
          cycleController.forward();
        }
        
         _points.add( Offset( 
          math.sin(dx.value)*radius+radius, 
          math.cos(dy.value)*radius+radius,
        ) );

        return 
        // RepaintBoundary(
        //   child: 
          CustomPaint(
            painter: PathPainter(
              color: widget.color, 
              weight: widget.weight, 
              points: _points,
            ),
            size: Size(radius, radius),
          // )
        );
      }
    );
  }

  @override
  void dispose() {
    dxController.dispose();
    dyController.dispose();
    cycleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LissajousPath oldWidget) {
    setState(() {
      if(widget.x==0 && widget.y==0){x=y=1; radius = 0;}
      else if(widget.x==0) {x=y=widget.y;}
      else if (widget.y==0) {x=y=widget.x;}
      else {x=widget.x; y=widget.y;}

      radius = widget.diameter/2;
      
      dxController.duration=Duration(milliseconds: (10000/x).round());
      dyController.duration=Duration(milliseconds: (10000/y).round());
      dxController.reset();
      dxController.repeat();
      dyController.reset();
      dyController.repeat();
      cycleController.forward();
    });
    super.didUpdateWidget(oldWidget);
  }
}

class PathPainter extends CustomPainter {
  List<Offset> points;
  Color color;
  double weight;

  PathPainter({this.points, this.color, this.weight});

  @override
  void paint(Canvas canvas, Size size) {
    // print('painting ${points.length}');
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = weight;

    // for (int i = 0; i < points.length - 1; i++) {
    //   canvas.drawLine(points[i], points[i + 1], paint);
    // }

    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => oldDelegate.points != points;
}