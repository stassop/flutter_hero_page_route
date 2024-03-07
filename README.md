# Flutter Hero Page Route (Updated)
### Create Hero-like Page Route Transitions in Flutter

## Update
This is an update of my previous article about page route transitions.

There's a few reasons for the update:

* My general knowledge of Flutter and Dart has improved
* The new code is simpler and more versatile
* The new version is using Material 3

## Hero Animations
If you’re unfamiliar with the [Hero class](https://api.flutter.dev/flutter/widgets/Hero-class.html), have a look at this article about [Hero animations](https://docs.flutter.dev/ui/animations/hero-animations). `Hero` is a powerful Flutter class that allows your to move a widget seamlessly between routes.

Another great thing about the `Hero` class is that it can be composed just like any other widget, making it possible to create cool route transition effects. For example, morph a `FloatingActionButton` into a new page.

![Flutter Hero Page Route](flutter_hero_page_route.gif)

## How It Works
The `Hero` widget does most of the heavy lifting here by creating a smooth transition between the the origin and destination widgets. But what if we want more control over the animation?

To switch routes, [Navigator.push()](https://docs.flutter.dev/cookbook/navigation/navigation-basics#2-navigate-to-the-second-route-using-navigatorpush) expects a descendant of the [Route](https://api.flutter.dev/flutter/widgets/Route-class.html) class, such as [MaterialPageRoute](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html). To create a custom route transition, you can use [PageRouteBuilder](https://api.flutter.dev/flutter/widgets/PageRouteBuilder-class.html) class, as described in this [recipe](https://docs.flutter.dev/cookbook/animation/page-route-animation).

To avoid wrapping each route in `PageRouteBuilder`, we extend it instead. We then call the superclass with `pageBuilder` and `transitionDuration` properties to gain control of the animation.

Here's what the code looks like:

```dart
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
```

## One Last Thing
If you paid attention, you might have noticed that the hero `createRectTween` parameter is passed a custom class. This parameter allows for using [RectTween](https://api.flutter.dev/flutter/animation/RectTween-class.html) to customize the hero transition path.

Normally, `createRectTween` utilises [MaterialRectArcTween](https://api.flutter.dev/flutter/material/MaterialRectArcTween-class.html) or [MaterialRectCenterArcTween](https://api.flutter.dev/flutter/material/MaterialRectCenterArcTween-class.html). But we want to control the timing of the tween, all other things being equal.

In order to achieve that, we need to extend the tween class, override its `lerp` method, pass its clock value to the `transform` method of a [Curve](https://api.flutter.dev/flutter/animation/Curves-class.html) constant, and return the result.

The `pageBuilder` callback receives the `animation` argument which can be used to control the route transition. Since most widgets have shape, background color and elevation, we can pass their initial values.

Here's the code:

```dart
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
```

## Conclusion
While Flutter generally favors composition over inheritance, understanding a class's inner workings and extending it can be valuable for achieving more refined behaviour and granular control.