import 'package:flutter/cupertino.dart';

class NavigationService {
  final Map<String, GlobalKey<NavigatorState>> keys = {};

  GlobalKey<NavigatorState> getState(
    String navigatorName,
  ) {
    keys.putIfAbsent(
      navigatorName,
      () => GlobalKey<NavigatorState>(),
    );
    return keys[navigatorName];
  }
}
