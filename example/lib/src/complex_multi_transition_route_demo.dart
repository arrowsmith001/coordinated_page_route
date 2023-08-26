import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/abstract/multi_transition_coordinated_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/widgets.dart';

/// A [CoordinatedPageRoute] whose previous route expands while fading out as the new route expands and fades in.
///
/// This should ideally be implemented with transparent pages who share a common background, since the transition is see-through.
class ComplexMultiTransitionRouteDemo extends MultiTransitionCoordinatedRoute {

  ComplexMultiTransitionRouteDemo(super.builder) : super(transitionDuration: const Duration(seconds: 2));

  final Offset left = Offset(-1, 0);
  final Offset right = Offset(1, 0);
  final Offset center = Offset(0, 0);

  final Offset leftHalf = Offset(-0.5, 0);
  final Offset rightHalf = Offset(0.5, 0);

  @override
  MultiTransitionBuilder entryBuilder(MultiTransitionBuilder builder) =>
      builder
        .addSlideFromTo(left, leftHalf)
        .addScale(1, 0.4)
        .curveAll(Curves.easeInOut)
        .until(0.25)

        .then()

        .addSlideTo(Offset(0.2, 0))
        .addScale(1, 1.0 / 0.4)
        .withCurve(Curves.easeInOut)
        .until(0.5)

        ;

  @override
  MultiTransitionBuilder exitBuilder(MultiTransitionBuilder builder) =>
    builder.addSlideTo(rightHalf)
        .addScale(1, 0.4)
        .curveAll(Curves.easeInOut)
        .until(0.25)

        .then()

        .addSlideTo(right)
        .withCurve(Curves.elasticIn)
        .addFade(1, 0)
        .until(0.5)
        
        ;
}
