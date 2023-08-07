import 'dart:ui';

import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/abstract/sliding_push_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import 'multi_transition_coordinated_route.dart';

abstract class SlidingPushFadeInRoute extends MultiTransitionCoordinatedRoute {
  SlidingPushFadeInRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  @override
  List<CoordinatedTransitionBuilder> get entryBuilders => [
    CoordinatedTransitionBuilders.fadeTransitionBuilder(0, 1, interval: Interval(0.3, 1, curve: curve)),
    CoordinatedTransitionBuilders.slideTransitionBuilder(initialOffset, Offset.zero, curve: curve),
  ];
  
  @override
  List<CoordinatedTransitionBuilder> get exitBuilders => [
    CoordinatedTransitionBuilders.slideTransitionBuilder(Offset.zero, -initialOffset, curve: curve)
  ];

  /// The offset at which the newRoute begins its entry.
  Offset get initialOffset;

}
