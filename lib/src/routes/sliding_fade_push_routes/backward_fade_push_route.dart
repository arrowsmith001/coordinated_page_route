import 'package:coordinated_page_route/src/abstract/sliding_fade_push_route.dart';
import 'package:flutter/animation.dart';

/// A [SlidingFadePushRoute] that appears to transition leftwards.
class BackwardFadePushRoute extends SlidingFadePushRoute {
  BackwardFadePushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(-1.0, 0.0);
}
