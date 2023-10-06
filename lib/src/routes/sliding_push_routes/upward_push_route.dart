import 'package:flutter/animation.dart';

import '../../abstract/sliding_push_route.dart';

/// A [SlidingPushRoute] that appears to transition upwards.
class UpwardPushRoute extends SlidingPushRoute {
  UpwardPushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(0.0, 1.0);
}
