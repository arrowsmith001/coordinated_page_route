import 'package:flutter/widgets.dart';
import 'package:coordinated_page_route/src/coordinated_route_observer.dart';

/// A [PageRouteBuilder] that works with [CoordinatedRouteObserver] to animate the previous page route's exit in co-ordination with the new route's entrance.
abstract class CoordinatedPageRoute extends PageRouteBuilder {
  
  CoordinatedPageRoute(Widget Function(BuildContext) builder,
      {Duration transitionDuration = const Duration(milliseconds: 300)})
      : super(
            transitionDuration: transitionDuration,
            pageBuilder: (context, _, __) => builder(context));

  /// I'm not sure why the animation could be null, so I've forced it to be non-null here for simplicity.
  @override
  Animation<double> get animation => super.animation!;

  @override
  RouteTransitionsBuilder get transitionsBuilder =>
      (context, _, __, child) => entryTransitionBuilder(context, child);

  Widget Function(BuildContext context, Widget child)
      get entryTransitionBuilder;

  Widget Function(BuildContext context, Widget exitingChild)
      get exitTransitionBuilder;
}
