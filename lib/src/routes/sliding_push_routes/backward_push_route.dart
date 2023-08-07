
import 'package:flutter/animation.dart';

import '../abstract/sliding_push_route.dart';



class BackwardPushRoute extends SlidingPushRoute {
  BackwardPushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(-1.0, 0.0);
}