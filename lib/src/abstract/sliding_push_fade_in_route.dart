import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/widgets.dart';

import 'multi_transition_coordinated_route.dart';

abstract class SlidingPushFadeInRoute extends MultiTransitionCoordinatedRoute {
  
  SlidingPushFadeInRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  Offset get initialOffset;

  @override
  MultiTransitionBuilder entryBuilder(MultiTransitionBuilder builder) => builder
    .addSlideFromTo(initialOffset, Offset.zero).withCurve(curve);
  

  @override
  MultiTransitionBuilder exitBuilder(MultiTransitionBuilder builder) => builder
  .addSlideTo(-initialOffset).withCurve(curve);
}
