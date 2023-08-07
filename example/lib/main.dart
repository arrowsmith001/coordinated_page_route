import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:example/src/on_generate_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialAppExample(); 
    //return const NavigatorExample(); 
  }
}


class MaterialAppExample extends StatelessWidget {
  const MaterialAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: 
      [
        CoordinatedRouteObserver() // <--- This must go here!
      ], 
      initialRoute: 'home',
      onGenerateRoute: onGenerateRoute,
    );
  }
}



class NavigatorExample extends StatelessWidget {
  const NavigatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        observers: 
        [
          CoordinatedRouteObserver() // <--- This must go here!
        ],
        initialRoute: 'home',
        onGenerateRoute: onGenerateRoute,
      ));
  }
}

