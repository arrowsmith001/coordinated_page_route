import 'dart:ui';

import 'package:coordinated_page_route/src/abstract/sliding_push_fade_in_route.dart';

class ForwardPushFadeInRoute extends SlidingPushFadeInRoute {
  
  ForwardPushFadeInRoute(super.builder);

  @override
  Offset get initialOffset => const Offset(1.0, 0);

}