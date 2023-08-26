import 'dart:math';

import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:coordinated_page_route/src/transitions/coordinated_transition_builders.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

// TODO: Fix animation chaining

abstract class MultiTransitionCoordinatedRoute extends CoordinatedPageRoute {
  MultiTransitionCoordinatedRoute(super.builder, {super.transitionDuration});

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    //return _executeBuilders(entryBuilders, animation, child);
    return entryBuilder(MultiTransitionBuilder()).build(animation, child);
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return exitBuilder(MultiTransitionBuilder()).build(animation, child);
    //return _executeBuilders(exitBuilders, animation, child);
  }

  MultiTransitionBuilder entryBuilder(MultiTransitionBuilder builder);
  MultiTransitionBuilder exitBuilder(MultiTransitionBuilder builder);

/*   Widget _executeBuilders(List<CoordinatedTransitionBuilder> builders,
      Animation<double> animation, Widget child) {
    if (builders.isEmpty) return child;

    return builders.reduce((value, element) {
      final built = value(animation, child);
      return (animation, child) => element(animation, built);
    })(animation, child);
  } */
}

class MultiTransitionBuilderData {
  MultiTransitionBuilderData(
      {required this.builder,
      this.intervalStart = 0.0,
      this.intervalEnd = 1.0});

  final TransitionFromAnimation Function(Interval, Curve) builder;

  double intervalStart;
  double intervalEnd;
  Curve curve = Curves.linear;

  TransitionFromAnimation buildBuilder() {
    final out = builder(Interval(intervalStart, intervalEnd), curve);
    return out;
  }
}

class MultiTransitionBuilder {

  final List<MultiTransitionBuilderData> _builders = [];

  Widget build(Animation<double> animation, Widget child) {
    if (_builders.isEmpty) return child;

    final finalizedBuilders = _builders.map((e) => e.buildBuilder());

    return finalizedBuilders.reduce((value, element) {
      final built = value(animation, child);
      return (a, c) => element(animation, built);
    })(animation, child);
  }

  int currentIndex = 0;
  double currentIntervalStart = 0.0;
  double currentIntervalEnd = 1.0;

  /// [at] specifies a starting point for an animation. It can range from 0.0 to 1.0.
  ///
  /// All animations added between [at] and [until] will take place inside that interval.
  MultiTransitionBuilder at(double start) {
    currentIntervalStart = start;
    return this;
  }

  /// [then] should come immediately after an [until] to start a new interval from where until ended.
  ///
  /// i.e. instead of writing `until(intervalEnd).at(intervalEnd)` you may write `until(intervalEnd).then()`
  MultiTransitionBuilder then() {
    currentIntervalStart = currentIntervalEnd;
    return this;
  }

  /// [until] specifies the ending point for an animation. It can range from 0.0 to 1.0.
  ///
  /// [until] is like a full stop - calling it will cement all animations and curves specified since the last [and] or [then].
  ///
  /// All animations added between [at]/[then] and [until] will take place inside that interval.
  MultiTransitionBuilder until(double end) {
    for (var transition in _builders.sublist(currentIndex)) {
      transition.intervalStart = currentIntervalStart;
      transition.intervalEnd = end;
    }

    currentIndex = _builders.length;
    currentIntervalEnd = end;

    return this;
  }

  /// Adds a [Curve] to the last specified animation
  MultiTransitionBuilder withCurve(Curve curve) {
    _builders.last.curve = curve;
    return this;
  }

  MultiTransitionBuilder addSlideFromTo(Offset startOffset, Offset endOffset) {
    final newBuilder = MultiTransitionBuilderData(
        builder: (interval, curve) =>
            TransitionCatalogue.slideTransitionBuilder(startOffset, endOffset,
                interval: interval, curve: curve),
        intervalStart: currentIntervalStart);

    _builders.add(newBuilder);
    return this;
  }

  MultiTransitionBuilder addSlideTo(Offset offset) {
    final newBuilder = MultiTransitionBuilderData(
        builder: (interval, curve) =>
            TransitionCatalogue.slideTransitionBuilder(Offset.zero, offset,
                interval: interval, curve: curve),
        intervalStart: currentIntervalStart);

    _builders.add(newBuilder);
    return this;
  }

  MultiTransitionBuilder addFade(double start, double end) {
    final newBuilder = MultiTransitionBuilderData(
        builder: (interval, curve) => TransitionCatalogue.fadeTransitionBuilder(
            start, end,
            interval: interval, curve: curve));

    _builders.add(newBuilder);
    return this;
  }

  MultiTransitionBuilder addRotation(double start, double end) {
    final newBuilder = MultiTransitionBuilderData(
        builder: (interval, curve) => TransitionCatalogue.rotationTransitionBuilder(
            start, end,
            interval: interval, curve: curve));

    _builders.add(newBuilder);
    return this;
  }

  MultiTransitionBuilder addScale(double start, double end) {
    final newBuilder = MultiTransitionBuilderData(
        builder: (interval, curve) =>
            TransitionCatalogue.scaleTransitionBuilder(start, end,
                interval: interval, curve: curve));

    _builders.add(newBuilder);
    return this;
  }

  /// Adds a [Curve] to all transitions specified in this interval.
  MultiTransitionBuilder curveAll(Curve curve) {
    _builders.sublist(currentIndex).forEach((element) {
      element.curve = curve;
    });
    return this;
  }
}
