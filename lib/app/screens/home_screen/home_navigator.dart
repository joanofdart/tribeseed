import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/nav_routes.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'home_screen.dart';
import 'test_screen/test_screen.dart';

class HomeNavigator extends HookWidget {
  const HomeNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = useProvider(navigationServiceProvider);

    return Navigator(
      key: _navigationService.getState(NavRoutes.home.name),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/test':
            return MaterialPageRoute(
              builder: (context) => TestScreen(),
            );

          case '/':
          default:
            return MaterialPageRoute(
              builder: (context) => HomeScreen(),
            );
        }
      },
    );
  }
}
