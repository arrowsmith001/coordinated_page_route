
import 'package:flutter/animation.dart';

import '../abstract/sliding_push_route.dart';

class UpwardPushRoute extends SlidingPushRoute {
  UpwardPushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(0.0, 1.0);
}