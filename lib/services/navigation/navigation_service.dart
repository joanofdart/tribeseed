import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final Map<String, GlobalKey<NavigatorState>> keys = {};

  GlobalKey<NavigatorState> get root => getState('root');

  NavigatorState get rootState => root.currentState;

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
