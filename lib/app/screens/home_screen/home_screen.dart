import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = useProvider(currentUserProvider).state;

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).pushNamed('/test'),
          child: Text('Go to Tesaaat - ${_currentUser.displayName}'),
        ),
      ),
    );
  }
}
