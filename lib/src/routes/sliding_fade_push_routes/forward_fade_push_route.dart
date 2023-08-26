
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/animation.dart';

class ForwardFadePushRoute extends SlidingFadePushRoute {
  ForwardFadePushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(1.0, 0.0);
}