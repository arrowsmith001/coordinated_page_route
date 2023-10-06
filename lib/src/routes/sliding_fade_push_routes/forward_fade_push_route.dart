import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/animation.dart';

/// A [SlidingFadePushRoute] that appears to transition rightwards.
class ForwardFadePushRoute extends SlidingFadePushRoute {
  ForwardFadePushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(1.0, 0.0);
}
