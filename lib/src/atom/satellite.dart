import 'package:flutter/material.dart';
import 'dart:math' as math;

class Satellite extends StatefulWidget {
  final int x;
  final int y;
  final double radius;
  final double orbital;

  Satellite(this.x, this.y, this.orbital, {this.radius : 5});

  _SatelliteState createState() => _SatelliteState();
}

class _SatelliteState extends State<Satellite> with TickerProviderStateMixin{
  Animation<double> dx, dy;
  AnimationController dxController, dyController;

  int x, y;
  double radius;

  @override
  void initState() {
    if(widget.x==0 && widget.y==0){x=y=1; radius = 0;}
    else if(widget.x==0) {x=y=widget.y; radius = widget.radius+2;}
    else if (widget.y==0) {x=y=widget.x; radius = widget.radius+2;}
    else {x=widget.x; y=widget.y; radius = widget.radius;}

    

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

    dxController.repeat();
    dyController.repeat();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: dx,
      builder: (context, child)=> Container(
        width: widget.orbital,
        height: widget.orbital,
        alignment: Alignment(math.cos(dx.value), math.sin(dy.value)),
        child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius)
          ),
        ),
      ),
    );
  }
}