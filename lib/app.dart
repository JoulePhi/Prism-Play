import 'package:flutter/material.dart';
import 'package:stream/shared/bottom_navbar.dart';
import 'package:stream/shared/routes.dart';
import 'package:stream/shared/utils.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        body: Navigator(
          key: AppRoute.mainRouteKey,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
        bottomNavigationBar: const BottomNavbar(),
      ),
    );
  }
}
