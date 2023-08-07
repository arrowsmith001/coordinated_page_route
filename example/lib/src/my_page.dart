
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage(this.title, this.backgroundColor, {super.key});

  final String title;
  final Color backgroundColor;
  final List<String> routeNames = const [
    'home',
    'up',
    'back',
    'forward',
    'down',
    'zoomfade',
    'material'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [Colors.white, backgroundColor])),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title),
          ...routeNames.map((routeName) => TextButton(
              onPressed: () => Navigator.of(context).pushNamed(routeName),
              child: Text('Navigate $routeName'))),
          TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Pop!'))
        ]),
      ),
    ));
  }
}