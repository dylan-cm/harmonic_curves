import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

class Satellite extends StatefulWidget {
  final double x;
  final double y;
  final double radius;
  final double orbital;

  Satellite(this.x, this.y, this.orbital, {this.radius : 5});

  _SatelliteState createState() => _SatelliteState();
}

class _SatelliteState extends State<Satellite> with TickerProviderStateMixin{
  Animation<double> dx, dy;
  AnimationController dxController, dyController;

  double x, y;
  double radius;

  List<Offset> dashes =[];

  @override
  void initState() {
    if(x==0||y==0)for(var i=0; i<100; i++){
      if(x==0)dashes.add( Offset(i*10.0, 0) );
      else dashes.add( Offset(0, i*10.0) );
    }

    if(widget.x==0 && widget.y==0){x=y=1; radius = 0;}
    else if(widget.x==0) {x=y=widget.y; radius = widget.radius+2;}
    else if (widget.y==0) {x=y=widget.x; radius = widget.radius+2;}
    else {x=widget.x; y=widget.y; radius = widget.radius;}

    dxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/x).round())
    );
    
    dx = Tween(begin: 0.0, end: 2.0*math.pi*x).animate(
      CurvedAnimation(
        parent: dxController,
        curve: Curves.linear,
      )
    );

    dyController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (10000/y).round())
    );
    
    dy = Tween(begin: 0.0, end: 2.0*math.pi*y).animate(
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
      builder: (context, child){
        if(dxController.status==AnimationStatus.completed) dxController.forward(from: 0);
        if(dyController.status==AnimationStatus.completed) dyController.forward(from: 0);
        
        return Container(
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
        );
      }
    );
  }

  @override
  void didUpdateWidget(Satellite oldWidget) {
    setState(() {
      if(widget.x==0 && widget.y==0){x=y=1; radius = 0;}
      else if(widget.x==0) {x=y=widget.y; radius = widget.radius+2;}
      else if (widget.y==0) {x=y=widget.x; radius = widget.radius+2;}
      else {x=widget.x; y=widget.y; radius = widget.radius;}
      
      dxController.duration=Duration(milliseconds: (10000/x).round());
      dyController.duration=Duration(milliseconds: (10000/y).round());
      dxController.reset();
      dxController.forward();
      dyController.reset();
      dyController.forward();
    });
    super.didUpdateWidget(oldWidget);
  }
}