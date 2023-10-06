import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/widgets.dart';

/// Use this to declare your builder functions directly in the constructor
class CoordinatedPageRouteImpl extends CoordinatedPageRoute {
  CoordinatedPageRouteImpl(super.builder,
      {required this.entryBuilder, required this.exitBuilder});

  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) entryBuilder;
  final Widget Function(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) exitBuilder;

  @override
  Widget getEntryTransition(
          BuildContext context, Animation<double> animation, Widget child) =>
      entryBuilder(context, animation, child);

  @override
  Widget getExitTransition(
          BuildContext context, Animation<double> animation, Widget child) =>
      exitBuilder(context, animation, child);
}
