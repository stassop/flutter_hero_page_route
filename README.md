# Flutter Hero Page Route

This article will help you build a smooth Hero transition from a FloatingActionButton to another page while gaining full control of the page transition animation.

![Flutter Hero Page Route](flutter_hero_page_route.gif)

## Getting Started

This article assumes basic knowledge of [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/).

To run the project open the iPhone simulator and run terminal command `flutter run`.

## Route Transition Basics

To [switch to a new route](https://flutter.dev/docs/cookbook/navigation/navigation-basics), we use the `Navigator.push()` method passing either `MaterialPageRoute`, which uses a platform-specific animation, or `PageRouteBuilder` which allows more [refined control](https://flutter.dev/docs/cookbook/animation/page-route-animation) of how page transition takes place. 
