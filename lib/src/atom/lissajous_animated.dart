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

  double x, y;
  double radius;

  List<Offset> _points = <Offset>[];

  Path path = new Path();

  // List<CustomPaint> rendered = [CustomPaint()];

  @override
  void initState() {
    // for(int i; i <= x; i++){
    //   rendered.add(
    //     CustomPaint(
    //       painter: PathPainter(
    //         color: widget.color, 
    //         weight: widget.weight, 
    //         points: [],
    //       ),
    //       size: Size(radius, radius),
    //     )
    //   );
    // }


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
        // if(_points.length > 10){
        //   rendered.add(
        //     CustomPaint(
        //       painter: PathPainter(
        //         color: widget.color, 
        //         weight: widget.weight, 
        //         points: List<Offset>.from(_points),
        //       ),
        //       size: Size(radius, radius),
        //     )
        //   );
        //   _points.clear();
        // }


        if (cycleController.status==AnimationStatus.completed){
          _points.clear();
          // rendered = [CustomPaint()];
          cycleController.reset();
          cycleController.forward();
        }
        
        // if(dx.value.round()%4 <= 3) { //Optimize performance
          _points.add( Offset( 
            math.cos(dx.value)*radius+radius, 
            math.sin(dy.value)*radius+radius,
          ) );
        // }

        // rendered[0] = 
        return
        CustomPaint(
              painter: PathPainter(
                color: widget.color, 
                weight: widget.weight, 
                points: _points,
              ),
              size: Size(radius, radius),
            );
        // print(rendered.length);

        // return Stack(
        //   children: rendered,
        // );
        
      
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
      // dxController.fling();
      dxController.forward();
      // dyController.fling();
      dyController.forward();
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
    Paint paint = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = weight;

    // for (int i = 0; i < points.length - 1; i++) {
    //   canvas.drawLine(points[i], points[i + 1], paint);
    // }

    canvas.drawPoints(PointMode.polygon, points, paint);

    // canvas.drawCircle(Offset(0,0), 2.5, Paint()..color=Colors.white..style=PaintingStyle.fill..strokeWidth=0);
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => oldDelegate.points != points;
}