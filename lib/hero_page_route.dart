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

class PageRouteTransition extends AnimatedWidget {
  const PageRouteTransition({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key, listenable: animation);

  final Widget child;
  final Animation<double> animation;

  static final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  static final elevationTween = Tween<double>(begin: 6.0, end: 0.0);
  static final borderRadiusTween = BorderRadiusTween(
    begin: BorderRadius.circular(100.0),
    end: BorderRadius.zero,
  );

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Material(
      color: Colors.blue, // color must be the same as FloatingActionButton
      clipBehavior: Clip.antiAlias,
      elevation: elevationTween.evaluate(animation),
      borderRadius: borderRadiusTween.evaluate(animation),
      child: Opacity(
        opacity: opacityTween.evaluate(animation),
        child: child,
      ),
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
    transitionDuration: const Duration(milliseconds: 1000),
    reverseTransitionDuration: const Duration(milliseconds: 1000),
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
        child: PageRouteTransition(
          child: child,
          animation: animation,
        ),
      );
    },
  );
}
