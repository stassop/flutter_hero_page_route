import 'package:flutter/material.dart';
import 'package:flutter_hero_page_route/hero_page_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hero Page Route',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final _heroTag = 'Hero Page';

  void _gotoHeroPage(BuildContext context) {
    Navigator.of(context).push(
      HeroPageRoute(
        tag: _heroTag,
        child: HeroPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home page content'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: _heroTag,
        child: const Icon(Icons.add),
        onPressed: () => _gotoHeroPage(context),
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Back button will be added automatically
        title: Text('Hero Page'),
      ),
      body: Center(
        child: Text('Hero page content'),
      ),
    );
  }
}
