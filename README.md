# Flutter Hero Page Route

This article will help you build a smooth Hero transition from a `FloatingActionButton` to another page while gaining full control of the page transition animation.

![Flutter Hero Page Route](flutter_hero_page_route.gif)

## Getting Started

To run the project open the iPhone simulator and run terminal command `flutter run`.

This article assumes basic knowledge of [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/).

You can find the complete project [here](https://github.com/stassop/flutter_hero_page_route).

## Route Transition Basics

To [switch to a new route](https://flutter.dev/docs/cookbook/navigation/navigation-basics), we'd normally use `Navigator.push()` passing either `MaterialPageRoute`, which uses a platform-specific animation, or `PageRouteBuilder` which allows more [refined control](https://flutter.dev/docs/cookbook/animation/page-route-animation) of how page transition takes place.

In this case, however, we want to leverage [Hero animations](https://flutter.dev/docs/cookbook/navigation/hero-animations) to create a page transition from `FloatingActionButton` while retaining full control of the animation easing curve and timing. We also want the button to morph into the new page instead of the page just popping up on screen.

Furthermore, we want to encapsulate all that logic in a separate [Widget](https://flutter.dev/docs/development/ui/widgets-intro) so that when a new route is pushed onto the navigation stack the code looks as concise as possible.

## Hero Page Route Widget

At the top level our home page code looks like this:

```
final _heroTag = 'Hero Page';

Navigator.of(context).push(
  HeroPageRoute(
    tag: _heroTag,
    child: HeroPage(),
  )
);

@override
Widget build(BuildContext context) {
  return Scaffold(
    floatingActionButton: FloatingActionButton(
      heroTag: _heroTag,
      child: const Icon(Icons.add),
      onPressed: () => _gotoHeroPage(context),
    ),
  );
}
```
