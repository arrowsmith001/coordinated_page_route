import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:flutter/widgets.dart';


abstract class SlidingFadePushRoute extends CoordinatedPageRoute {
  
  SlidingFadePushRoute(super.builder, {this.curve = Curves.easeInOut});

  final Curve curve;

  @override
  Widget getEntryTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
          position: CurvedAnimation(parent: animation, curve: curve)
              .drive(Tween(begin: initialOffset, end: Offset.zero)),
              child: child,),
    );
  }

  @override
  Widget getExitTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation.drive(Tween(begin: 1.0, end: 0)),
      child: SlideTransition(
          position: CurvedAnimation(parent: animation, curve: curve)
              .drive(Tween(begin: Offset.zero, end: -initialOffset)),
              child: child,),
    );
  }


  Offset get initialOffset;

}
