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
    // if(widget.x==0) {y=widget.y+1; x=y; radius = widget.radius+2;}
    // else if (widget.y==0) {x=widget.x+1; y=x; radius = widget.radius+2;}

    if(widget.x==0 || widget.y==0){x=y=1; radius = widget.radius+2;}

    dxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/10).round())
    );
    
    dx = Tween(begin: 0.0, end: 2.0*math.pi).animate(
      CurvedAnimation(
        parent: dxController,
        curve: Curves.linear,
      )
    );

    dyController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/10).round())
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
          width: widget.radius,
          height: widget.radius,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(widget.radius)
          ),
        ),
      ),
    );
  }
}