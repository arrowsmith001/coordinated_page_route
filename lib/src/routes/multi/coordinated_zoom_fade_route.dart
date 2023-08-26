import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/abstract/multi_transition_coordinated_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/widgets.dart';

/// A [CoordinatedPageRoute] whose previous route expands while fading out as the new route expands and fades in.
///
/// This should ideally be implemented with transparent pages who share a common background, since the transition is see-through.
class CoordinatedZoomFadeRoute extends MultiTransitionCoordinatedRoute {
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
  MultiTransitionBuilder entryBuilder(MultiTransitionBuilder builder) => builder
      .at(entryIntervalFrom)
      .addFade(0, 1)
      .addScale(entryScaleFrom, 1)
      .curveAll(curve);

  @override
  MultiTransitionBuilder exitBuilder(MultiTransitionBuilder builder) => builder
      .addFade(1, 0)
      .addScale(1, exitScaleTo)
      .curveAll(curve)
      .until(exitIntervalTo);
}
