import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:flutter/src/widgets/framework.dart';

abstract class MultiTransitionCoordinatedRoute extends CoordinatedPageRoute {
  MultiTransitionCoordinatedRoute(super.builder, {super.transitionDuration});

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return _executeBuilders(entryBuilders, animation, child);
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return _executeBuilders(exitBuilders, animation, child);
  }

  List<CoordinatedTransitionBuilder> get entryBuilders;
  List<CoordinatedTransitionBuilder> get exitBuilders;

  Widget _executeBuilders(List<CoordinatedTransitionBuilder> builders, Animation<double> animation,
      Widget child) {
    if (builders.isEmpty) return child;

    return builders.reduce((value, element) {
      final built = value(animation, child);
      return (animation, child) => element(animation, built);
    })(animation, child);
  }
}
