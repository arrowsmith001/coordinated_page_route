import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/widgets.dart';

/// A [CoordinatedPageRoute] whose previous route expands while fading out as the new route expands and fades in.
/// 
/// This should ideally be implemented with transparent pages who share a common background, since the transition is see-through.
class CoordinatedZoomFadeRoute extends CoordinatedPageRoute {
  CoordinatedZoomFadeRoute(super.builder,
  {
    Duration transitionDuration = const Duration(seconds: 1),
    this.entryScaleFrom = 0.25, 
    this.entryIntervalFrom = 0.3, 
    this.exitScaleTo = 2.0, 
    this.exitIntervalTo = 0.7, 
    this.curve = Curves.easeInOut
  }) :super(transitionDuration: transitionDuration);


  final double entryScaleFrom;
  final double entryIntervalFrom;
  final double exitScaleTo;
  final double exitIntervalTo;

  final Curve curve;

  @override
  Widget Function(BuildContext context, Widget child)
      get entryTransitionBuilder =>
          (context, child) => _getZoomFadeTransition(child,
              opacityFrom: 0.0, opacityTo: 1.0, scaleFrom: entryScaleFrom, scaleTo: 1.0, intervalFrom: entryIntervalFrom, intervalTo: 1.0);

  @override
  Widget Function(BuildContext context, Widget exitingChild)
      get exitTransitionBuilder =>
          (context, child) => _getZoomFadeTransition(child, 
              opacityFrom: 1.0, opacityTo: 0.0, scaleFrom: 1.0, scaleTo: exitScaleTo, intervalFrom: 0.0, intervalTo: exitIntervalTo);


  Widget _getZoomFadeTransition(Widget child,
      {required double opacityFrom,
      required double opacityTo,
      required double scaleFrom,
      required double scaleTo,
      required double intervalFrom,
      required double intervalTo}) {
    return FadeTransition(
      opacity: _getCurvedDoubleAnimation(opacityFrom, opacityTo, intervalFrom: intervalFrom, intervalTo: intervalTo),
      child: ScaleTransition(
        scale: _getCurvedDoubleAnimation(scaleFrom, scaleTo, intervalFrom: intervalFrom, intervalTo: intervalTo),
        child: child,
      ),
    );
  }

  Animation<double> _getCurvedDoubleAnimation(double from, double to, {double intervalFrom = 0.0, double intervalTo = 1.0}) {
    return CurvedAnimation(parent: animation, curve: Interval(intervalFrom, intervalTo, curve: curve))
        .drive(Tween(begin: from, end: to));
  }
}
