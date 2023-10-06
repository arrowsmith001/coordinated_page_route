import 'package:flutter/animation.dart';

import '../../abstract/sliding_push_route.dart';

/// A [SlidingPushRoute] that appears to transition leftwards.
class BackwardPushRoute extends SlidingPushRoute {
  BackwardPushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(-1.0, 0.0);
}
