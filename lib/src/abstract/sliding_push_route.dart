import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/widgets.dart';
import '../coordinated_page_route.dart';


/// A [CoordinatedPageRoute] that pushes the old route out in the same direction that the new route comes in according to some [initialOffset].
abstract class SlidingPushRoute extends CoordinatedPageRoute {
  SlidingPushRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  @override
  Widget getEntryTransition(BuildContext context, Animation<double> animation, Widget child) {
    return CoordinatedTransitionBuilders.slideTransitionBuilder(initialOffset, Offset.zero, curve: curve)(animation, child);
  }

  @override
  Widget getExitTransition(BuildContext context, Animation<double> animation, Widget child) {
    return CoordinatedTransitionBuilders.slideTransitionBuilder(Offset.zero, -initialOffset, curve: curve)(animation, child);
  }

  /// The offset at which the newRoute begins its entry.
  Offset get initialOffset;
}
