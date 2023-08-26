
import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/animation.dart';

class UpwardFadePushRoute extends SlidingFadePushRoute {
  UpwardFadePushRoute(super.child);

  @override
  Offset get initialOffset => const Offset(0.0, 1.0);
}