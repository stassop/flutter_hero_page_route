import 'package:flutter/material.dart';

class CurveRectTween extends MaterialRectArcTween {
  CurveRectTween({
    super.begin,
    super.end,
    required this.curve,
  });

  final Curve curve;

  @override
  Rect lerp(double t) {
    return super.lerp(curve.transform(t));
  }
}

class HeroPageRoute extends PageRouteBuilder {
  final String tag;
  final Widget child;
  final double? initElevation;
  final ShapeBorder? initShape;
  final Color? initBackgroundColor;
  final Curve curve;
  final Duration duration;

  HeroPageRoute({
    required this.tag,
    required this.child,
    this.initElevation,
    this.initShape,
    this.initBackgroundColor,
    this.curve = Curves.ease,
    this.duration = const Duration(seconds: 1),
  }) : super(
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      final elevationTween = Tween<double>(begin: initElevation ?? 0.0, end: 0.0);
      final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
      final shapeTween = ShapeBorderTween(
        begin: initShape ?? const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        end: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
      );
      final backgroundColorTween = ColorTween(
        begin: initBackgroundColor ?? Colors.transparent,
        end: Colors.transparent,
      );

      return Hero(
        tag: tag,
        createRectTween: (Rect? begin, Rect? end) {
          return CurveRectTween(begin: begin, end: end, curve: curve);
        },
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Material(
              shape: shapeTween.evaluate(animation),
              elevation: elevationTween.evaluate(animation),
              color: backgroundColorTween.evaluate(animation),
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
