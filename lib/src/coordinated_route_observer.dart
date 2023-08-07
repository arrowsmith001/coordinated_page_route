import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'coordinated_page_route.dart';

class CoordinatedRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _handleCoordinatedTransition(previousRoute, route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _handleCoordinatedTransition(oldRoute, newRoute);
  }

  void _handleCoordinatedTransition(Route? prevRoute, Route? newRoute) {
    if (newRoute == null || prevRoute == null) {
      return;
    }

    final NavigatorState? navigatorState = prevRoute.navigator;
    final OverlayState? overlayState = navigatorState?.overlay;
    if (navigatorState == null || overlayState == null) {
      return;
    }

    if (newRoute is CoordinatedPageRoute) {

      /// Get the overlay entry which corresponds to the page presented by the Navigator.
      ///
      /// Typically the Navigator installs, by default, two overlay entries with the corresponding child widgets:
      ///  - An IgnorePointer with a bunch of semantics-blocking children, presumably to act as a wall for any semantics containers lying underneath the Navigator
      ///  - A Semantics container with a whole bunch of other wrappers before it finally gets to the page built by the builder passed to PageRouteBuilder
      ///
      /// Therefore the second element should be what we want (unless someone inserts an OverlayEntry underneath it for whatever reason). Perhaps this could be more robust.
      final OverlayEntry prevRouteOverlayEntry =
          prevRoute.overlayEntries.toList()[1];

      /// Build a new copy of the previous route's page. There's a handy builder function exposed by the overlay entry.
      final Widget prevRoutePage =
          prevRouteOverlayEntry.builder(prevRoute.navigator!.context);

      /// Use the ExitableRoute's transition builder to build an animated wrapper to our page that will be coordinated with the route's own entry animation.
      final Widget animatedOldRouteScreen =
          newRoute.exitTransitionBuilder(navigatorState.context, prevRoutePage);


      /// This was the annoying part to figure out.
      ///
      /// The convenient builder that built our page above produces a widget with the same GlobalKey as the original page.
      /// When we try and insert it the proper way by calling Overlay.insert() the framework complains that there are duplicate keys, even if we call OverlayEntry.remove() on the entry beforehand.
      /// However, forcibly removing it from the overlayEntries list led to glitchy behaviour on Navigator.pop().
      ///
      /// In the end, removing and inserting the proper way AND forcibly updating the list was what got it to work.
      /// 
      /// The post-frame callback fixes a brief flicker where neither overlay entry seems to be visible. 

      final List<OverlayEntry> overlayEntries = prevRoute.overlayEntries;
      final OverlayEntry newOverlayEntry =
          OverlayEntry(builder: (context) => animatedOldRouteScreen);

      SchedulerBinding.instance.addPostFrameCallback((_) {

        prevRouteOverlayEntry
          ..remove()
          ..dispose();
        overlayState.insert(newOverlayEntry);

        overlayEntries.remove(prevRouteOverlayEntry);
        overlayEntries.insert(1, newOverlayEntry);
      });
    }
  }
}
