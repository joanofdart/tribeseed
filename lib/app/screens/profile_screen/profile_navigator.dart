import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/nav_routes.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'profile_screen.dart';

class ProfileNavigator extends HookWidget {
  const ProfileNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigationService = useProvider(navigationServiceProvider);

    return Navigator(
      key: _navigationService.getState(NavRoutes.profile.name),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
          default:
            return MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            );
        }
      },
    );
  }
}
