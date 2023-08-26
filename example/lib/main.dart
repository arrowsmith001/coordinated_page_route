
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
    return MaterialApp(home: 

    //Center(child: SizedBox(width: MediaQuery.of(context).size.width/3, height: MediaQuery.of(context).size.height/3, child: SlideTransitionTest()))

    Center(child: SizedBox(width: MediaQuery.of(context).size.width/3, height: MediaQuery.of(context).size.height/3, child: MaterialAppExample()))

    //return const MaterialAppExample();
    //return const NavigatorExample();
    );
  }
}

class SlideTransitionTest extends StatefulWidget {
  const SlideTransitionTest({super.key});

  @override
  State<SlideTransitionTest> createState() => _SlideTransitionTestState();
}

class _SlideTransitionTestState extends State<SlideTransitionTest>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> anim1;
  late Animation<double> anim2;
  late Animation<double> anim3;
  late Animation<double> anim4;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    anim1 = CurvedAnimation(parent: controller, curve: Interval(0, 0.25));
    anim2 = CurvedAnimation(parent: controller, curve: Interval(0.25, 0.5));
    anim3 = CurvedAnimation(parent: controller, curve: Interval(0.5, 0.75));
    anim4 = CurvedAnimation(parent: controller, curve: Interval(0.75, 1));
  }

  @override
  Widget build(BuildContext context) {
    Tween<Offset> offsetTween = Tween(begin: Offset.zero, end: Offset(1.0, 0));
    Tween<Offset> offsetTween2 = Tween(begin: Offset.zero, end: Offset(0, 1.0));
    Tween<Offset> offsetTween3 = Tween(begin: Offset.zero, end: Offset(-1.0, 0.0));
    Tween<Offset> offsetTween4 = Tween(begin: Offset.zero, end: Offset(0, -1.0));

    return SlideTransition(
        position: anim4.drive(offsetTween4),
      child: SlideTransition(
        position: anim3.drive(offsetTween3),
        child: SlideTransition(
          position: anim2.drive(offsetTween2),
          child: SlideTransition(
            position: anim1.drive(offsetTween),
            child: Container(color: Colors.red, child: TextButton(child: Text("1"), onPressed: () => controller.forward(),),),),
        ),
      ),
    );
  }
}

class MaterialAppExample extends StatelessWidget {
  const MaterialAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [Colors.white, Colors.orange])),
      child: MaterialApp(
        navigatorObservers: [
          CoordinatedRouteObserver() // <--- This must go here!
        ],
        initialRoute: 'home',
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}

class NavigatorExample extends StatelessWidget {
  const NavigatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Navigator(
      observers: [
        CoordinatedRouteObserver() // <--- This must go here!
      ],
      initialRoute: 'home',
      onGenerateRoute: onGenerateRoute,
    ));
  }
}
