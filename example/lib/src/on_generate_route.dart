import 'package:coordinated_page_route/coordinated_page_route.dart';
import 'package:example/src/my_page.dart';
import 'package:flutter/material.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'home':
      return PageRouteBuilder(pageBuilder: (context, _, __) {
        return const MyPage('Home', Colors.grey);
      });
    case 'forward':
      return ForwardPushRoute(
          (context) => const MyPage('Forward', Colors.blue));
    case 'back':
      return BackwardPushRoute((context) => const MyPage('Back', Colors.red));
    case 'up':
      return UpwardPushRoute((context) => const MyPage('Up', Colors.yellow));
    case 'down':
      return DownwardPushRoute((context) => const MyPage('Down', Colors.green));
    case 'forward (fade)':
      return ForwardFadePushRoute(
          (context) => const MyPage('Forward', Colors.blue));
    case 'back (fade)':
      return BackwardFadePushRoute(
          (context) => const MyPage('Back', Colors.red));
    case 'zoomfade':
      return CoordinatedZoomFadeRoute(
          (context) => const MyPage('Zoom Fade', Colors.orange));
    case 'material':
      return MaterialPageRoute(
          builder: (context) => const MyPage('Material', Colors.pink));
  }

  return null;
}
