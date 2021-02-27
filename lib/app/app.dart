import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/nav_routes.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'app_providers.dart';
import 'screens/home_screen/home_navigator.dart';
import 'screens/profile_screen/profile_navigator.dart';

final _bottomItemsProvider = Provider<Map<String, BottomNavyBarItem>>(
  (ref) {
    return {
      NavRoutes.home.name: BottomNavyBarItem(
        title: Text('Home'),
        icon: Icon(
          Icons.home_rounded,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
      NavRoutes.profile.name: BottomNavyBarItem(
        title: Text('Profile'),
        icon: Icon(
          Icons.account_circle,
          color: Colors.blue,
        ),
        textAlign: TextAlign.center,
      ),
    };
  },
);

final _screensProvider = Provider<List<Widget>>(
  (ref) {
    return [
      HomeNavigator(),
      ProfileNavigator(),
    ];
  },
);

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _appViewIndex = useProvider(appViewIndexProvider);
    final _navigationService = useProvider(navigationServiceProvider);
    final _bottomItems = useProvider(_bottomItemsProvider);
    final _screens = useProvider(_screensProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        items: _bottomItems.values.toList(),
        onItemSelected: (value) {
          _appViewIndex.state = value;
        },
        selectedIndex: _appViewIndex.state,
      ),
      body: WillPopScope(
        onWillPop: () async {
          final navigatorName = NavRoutes.values[_appViewIndex.state].name;
          final navigatorState = _navigationService.getState(navigatorName);
          final isFirstRoute = !await navigatorState.currentState.maybePop();
          if (isFirstRoute) {
            if (_appViewIndex.state != NavRoutes.home.index) {
              _appViewIndex.state = NavRoutes.home.index;
              return false;
            }
          }
          return isFirstRoute;
        },
        child: IndexedStack(
          index: _appViewIndex.state,
          children: _screens,
        ),
      ),
    );
  }
}
