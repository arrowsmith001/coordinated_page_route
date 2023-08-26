import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/widgets.dart';
import '../coordinated_page_route.dart';

/// A [CoordinatedPageRoute] that pushes the old route out in the same direction that the new route comes in according to some [initialOffset].
abstract class SlidingPushRoute extends CoordinatedPageRoute {
  SlidingPushRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
        position: CurvedAnimation(parent: animation, curve: curve)
            .drive(Tween(begin: initialOffset, end: Offset.zero)),
            child: child,);
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return SlideTransition(
        position: CurvedAnimation(parent: animation, curve: curve)
            .drive(Tween(begin: Offset.zero, end: -initialOffset)),
            child: child);
  }

  /// The offset at which the newRoute begins its entry.
  Offset get initialOffset;
}
