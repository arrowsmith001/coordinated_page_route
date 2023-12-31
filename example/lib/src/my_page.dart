import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage(this.title, this.backgroundColor, {super.key});

  final String title;
  final Color backgroundColor;
  final List<String> routeNames = const [
    'home',
    'forward',
    'back',
    'up',
    'down',
    'forward (fade)',
    'back (fade)',
    'zoomfade',
    'material',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              //color: Colors.transparent),
              gradient:
                  RadialGradient(colors: [Colors.white, backgroundColor])),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
