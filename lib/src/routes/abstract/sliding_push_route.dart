import 'package:flutter/widgets.dart';
import '../../coordinated_page_route.dart';

/// A [CoordinatedPageRoute] that pushes the old route out in the same direction that the new route comes in according to some [initialOffset].
abstract class SlidingPushRoute extends CoordinatedPageRoute {
  SlidingPushRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  @override
  Widget Function(BuildContext context, Widget child)
      get entryTransitionBuilder => (context, child) =>
          _getSlideTransition(child, initialOffset, Offset.zero);

  @override
  Widget Function(BuildContext context, Widget child)
      get exitTransitionBuilder => (context, child) =>
          _getSlideTransition(child, Offset.zero, -initialOffset);

  SlideTransition _getSlideTransition(Widget child, Offset from, Offset to) {
    return SlideTransition(
      position: _getCurvedOffsetAnimation(from, to),
      child: child,
    );
  }

  Animation<Offset> _getCurvedOffsetAnimation(Offset from, Offset to) {
    return CurvedAnimation(parent: animation, curve: curve)
        .drive(Tween(begin: from, end: to));
  }

  /// The offset at which the newRoute begins its entry.
  Offset get initialOffset;
}


