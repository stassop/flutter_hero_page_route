import 'package:flutter/material.dart';

class CurvedRectTween extends MaterialRectArcTween {
  CurvedRectTween({
    required super.begin,
    required super.end,
    required this.curve,
  });

  final Curve curve;

  @override
  Rect lerp(double t) {
    return super.lerp(curve.transform(t));
  }
}

class HeroPageRoute extends PageRouteBuilder {
  final Color? color;
  final Curve curve;
  final double? elevation;
  final Duration duration;
  final ShapeBorder? shape;
  final String tag;
  final Widget child;

  HeroPageRoute({
    required this.child,
    required this.tag,
    this.color,
    this.curve = Curves.easeInOut,
    this.elevation,
    this.shape,
    this.duration = const Duration(milliseconds: 500),
  }) : super(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      final elevationTween = Tween<double>(
            begin: elevation ?? 0.0, 
            end: 0.0,
          ).chain(CurveTween(curve: curve));
      final opacityTween = Tween<double>(
            begin: 0.0, 
            end: 1.0,
          ).chain(CurveTween(curve: curve));
      final shapeTween = ShapeBorderTween(
            begin: shape ?? const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            end: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ).chain(CurveTween(curve: curve));
      final colorTween = ColorTween(
            begin: color ?? Colors.transparent,
            end: Colors.transparent,
          );

      return Hero(
        tag: tag,
        createRectTween: (Rect? begin, Rect? end) {
          return CurvedRectTween(begin: begin, end: end, curve: curve);
        },
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Material(
              elevation: elevationTween.evaluate(animation),
              shape: shapeTween.evaluate(animation),
              color: colorTween.evaluate(animation),
              clipBehavior: Clip.hardEdge,
              child: Opacity(
                opacity: opacityTween.evaluate(animation),
                child: child,
              ),
            );
          },
          child: child,
        ),
      );
    },
  );
}
