import 'package:flutter/material.dart';
import 'package:stream/explore/views/explore_view.dart';
import 'package:stream/home/views/home_view.dart';

abstract class AppRoute {
  static final mainRouteKey = GlobalKey<NavigatorState>();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomeView(),
        );
      case 'explore':
        return MaterialPageRoute(
          builder: (context) => ExploreView(),
        );
    }
    return null;
  }
}
