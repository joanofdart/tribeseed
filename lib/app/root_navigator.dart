import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/nav_routes.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'screens/home_screen/home_navigator.dart';
import 'screens/profile_screen/profile_navigator.dart';

final _bottomItems = <String, BottomNavigationBarItem>{
  NavRoutes.home.name: BottomNavigationBarItem(
    icon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  NavRoutes.profile.name: BottomNavigationBarItem(
    label: 'Profile',
    icon: Image.asset(
      'assets/branding/google.png',
      height: 20,
      width: 20,
    ),
  ),
};

const _screens = [
  HomeNavigator(),
  ProfileNavigator(),
];

class RootNavigator extends HookWidget {
  const RootNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentIndex = useState(0);
    final _navigationService = useProvider(navigationServiceProvider);
    final _currentUser = useProvider(currentUserProvider).state;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItems.values.toList(),
        onTap: (value) {
          _currentIndex.value = value;
        },
        currentIndex: _currentIndex.value,
      ),
      floatingActionButton: FloatingActionButton(
        /// TODO: Show modal with pending actions.
        onPressed: () {},
        backgroundColor:
            _currentUser.emailVerified ? Colors.blue : Colors.red[300],
        mini: true,
        child: Icon(
          _currentUser.emailVerified
              ? Icons.info_outline
              : Icons.error_outline_outlined,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: WillPopScope(
        onWillPop: () async {
          final navigatorName = NavRoutes.values[_currentIndex.value].name;
          final navigatorState = _navigationService.getState(navigatorName);
          final isFirstRoute = !await navigatorState.currentState.maybePop();
          if (isFirstRoute) {
            if (_currentIndex.value != NavRoutes.home.index) {
              _currentIndex.value = NavRoutes.home.index;
              return false;
            }
          }
          return isFirstRoute;
        },
        child: IndexedStack(
          index: _currentIndex.value,
          children: _screens,
        ),
      ),
    );
  }
}
