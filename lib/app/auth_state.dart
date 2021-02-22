import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/app/screens/auth_screen/auth_screen.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

class AuthState extends ConsumerWidget {
  final WidgetBuilder onLoggedIn;

  const AuthState({
    Key key,
    this.onLoggedIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;

    return AnimatedSwitcher(
      duration: const Duration(
        milliseconds: 500,
      ),
      child: currentUser == null ? AuthScreen() : onLoggedIn(context),
    );
  }
}
