import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final Map<String, GlobalKey<NavigatorState>> keys = {};

  GlobalKey<NavigatorState> get rootKey => getState('root');

  NavigatorState get rootState => rootKey.currentState;

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
