import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/widgets.dart';

/// A [CoordinatedPageRoute] whose previous route expands while fading out as the new route expands and fades in.
///
/// This should ideally be implemented with transparent pages who share a common background, since the transition is see-through.
class CoordinatedZoomFadeRoute extends CoordinatedPageRoute {
  CoordinatedZoomFadeRoute(super.builder,
      {Duration transitionDuration = const Duration(seconds: 1),
      this.entryScaleFrom = 0.25,
      this.entryIntervalFrom = 0.3,
      this.exitScaleTo = 2.0,
      this.exitIntervalTo = 0.7,
      this.curve = Curves.easeInOutCubic})
      : super(transitionDuration: transitionDuration);

  final double entryScaleFrom;
  final double entryIntervalFrom;
  final double exitScaleTo;
  final double exitIntervalTo;

  final Curve curve;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {

    final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Interval(entryIntervalFrom, 1.0, curve: curve));

    final scaleAnimation = CurvedAnimation(
        parent: animation, curve: curve).drive(Tween(begin: entryScaleFrom, end: 1.0));

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {

        final fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Interval(0.0, exitIntervalTo, curve: curve))
        .drive(Tween(begin: 1.0, end: 0.0));

    final scaleAnimation = CurvedAnimation(
        parent: animation, curve: Interval(0.0, exitIntervalTo, curve: curve))
        .drive(Tween(begin: 1.0, end: exitScaleTo));

    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }
}
