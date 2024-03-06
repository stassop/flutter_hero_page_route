import 'package:flutter/material.dart';
import 'package:flutter_hero_page_route/hero_page_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Page Route',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final initElevation = 6.0;
    final initShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    );
    final initBackgroundColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'hero',
        onPressed: () {
          Navigator.of(context).push(
            HeroPageRoute(
              tag: 'hero',
              child: const NextPage(),
              initElevation: initElevation,
              initShape: initShape,
              initBackgroundColor: initBackgroundColor,
            ),
          );
        },
        child: Text('Go!',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Next page'),
      ),
    );
  }
}
