import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/app/screens/auth_screen/auth_screen.dart';
import 'package:tribeseed/main_providers.dart';

class AuthState extends HookWidget {
  final WidgetBuilder onLoggedIn;

  const AuthState({
    Key key,
    this.onLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = useProvider(currentUserProvider).state;

    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 500,
      ),
      child: _currentUser == null ? AuthScreen() : onLoggedIn(context),
    );
  }
}
