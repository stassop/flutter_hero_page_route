import 'package:flutter/material.dart';
import 'package:flutter_hero_page_route/hero_page_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Page Route',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Home page'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'my_hero_route',
        onPressed: () {
          Navigator.of(context).push(
            HeroPageRoute(
              tag: 'my_hero_route',
              child: const NextPage(),
              curve: Curves.linear,
              duration: const Duration(milliseconds: 5000),
              elevation: Theme.of(context).floatingActionButtonTheme.elevation ?? 6.0,
              shape: Theme.of(context).floatingActionButtonTheme.shape ??
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
              color: Theme.of(context).floatingActionButtonTheme.backgroundColor ??
                      Theme.of(context).colorScheme.primaryContainer,
            ),
          );
        },
        label: const Text('Next Page'),
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
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Next page'),
      ),
    );
  }
}
