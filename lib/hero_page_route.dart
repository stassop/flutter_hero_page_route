import 'dart:math' as math;
import 'package:flutter/material.dart';

class CurvedRectArcTween extends MaterialRectArcTween {
  CurvedRectArcTween({
    Rect? begin,
    Rect? end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    Cubic easeInOut = Cubic(0.42, 0.0, 0.58, 1.0); // Curves.easeInOut
    double curvedT = easeInOut.transform(t);
    return super.lerp(curvedT);
  }
}

class PageRouteAnimation extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Animation<double> opacityAnimation;
  final Animation<double> elevationAnimation;
  final Animation<BorderRadius?> borderRadiusAnimation;

  PageRouteAnimation({
    Key? key,
    required this.child,
    required this.animation,
  }) :
    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animation),

    elevationAnimation = Tween<double>(
      begin: 6.0, // FloatingActionButton default resting elevation
      end: 0.0,
    ).animate(animation),

    borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.zero,
    ).animate(animation),

    super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? animatedWidget) {
        return Material(
          color: Colors.blue, // must be the same color as FloatingActionButton
          clipBehavior: Clip.antiAlias,
          elevation: elevationAnimation.value,
          borderRadius: borderRadiusAnimation.value,
          child: Opacity(
            opacity: opacityAnimation.value,
            child: child,
          )
        );
      },
    );
  }
}

class HeroPageRoute extends PageRouteBuilder {
  final String tag;
  final Widget child;

  HeroPageRoute({
    required this.tag,
    required this.child,
  }) : super(
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return Hero(
        tag: tag,
        createRectTween: (Rect? begin, Rect? end) {
          return CurvedRectArcTween(begin: begin, end: end);
        },
        child: PageRouteAnimation(
          child: child,
          animation: animation,
        ),
      );
    },
  );
}
