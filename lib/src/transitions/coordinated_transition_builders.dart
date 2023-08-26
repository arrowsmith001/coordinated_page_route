
import 'package:flutter/widgets.dart';

typedef TransitionFromAnimation = Widget Function(
    Animation<double> animation, Widget child);




/// Some convenient builders which return an animated widget given an animation and child
class TransitionCatalogue {

  static TransitionFromAnimation slideTransitionBuilder(Offset begin, Offset end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => SlideTransition(
          position: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);

  static TransitionFromAnimation fadeTransitionBuilder(double begin, double end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => FadeTransition(
          opacity: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);

  static TransitionFromAnimation scaleTransitionBuilder(double begin, double end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => ScaleTransition(
          scale: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
          child: child);

  static TransitionFromAnimation rotationTransitionBuilder(double begin, double end,
          {Curve? curve,
          Interval interval = const Interval(0, 1, curve: Curves.linear)}) =>
      (animation, child) => RotationTransition(
          turns: _getCurvedAnimation(animation, curve, interval).drive(Tween(begin: begin, end: end)),
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
