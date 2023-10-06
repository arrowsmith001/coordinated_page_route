import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/animation.dart';

/// A [SlidingFadePushRoute] that appears to transition downwards.
class DownwardFadePushRoute extends SlidingFadePushRoute {
  DownwardFadePushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(0.0, -1.0);
}
