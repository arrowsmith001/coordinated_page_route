import 'package:flutter/widgets.dart';

typedef CoordinatedTransitionBuilder = Widget Function(
    Animation<double> animation, Widget child);


/// Some convenient builders which return an animated widget given an animation and child
class CoordinatedTransitionBuilders {

  static CoordinatedTransitionBuilder slideTransitionBuilder(Offset begin, Offset end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => SlideTransition(
          position: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);

  static CoordinatedTransitionBuilder fadeTransitionBuilder(double begin, double end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => FadeTransition(
          opacity: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);

  static CoordinatedTransitionBuilder scaleTransitionBuilder(double begin, double end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => ScaleTransition(
          scale: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);


  static Animation<double> _getCurvedAnimation(
      Animation<double> animation, Curve? curve, Interval interval) {
    return CurvedAnimation(
        parent: animation,
        curve: curve == null
            ? interval
            : Interval(interval.begin, interval.end, curve: curve));
  }
}
