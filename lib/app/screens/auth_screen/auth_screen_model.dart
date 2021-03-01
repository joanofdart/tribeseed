import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';

class AuthScreenModel extends StateNotifier<AsyncValue<bool>> {
  final AuthenticationService authenticationService;

  AuthScreenModel(
    this.authenticationService,
  ) : super(AsyncValue.loading()) {
    _initState();
  }

  void _initState() {
    state = AsyncValue.data(false);
  }

  Future<void> authenticate({
    String displayName,
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    state = const AsyncValue.loading();
    try {
      /// Mimic network request
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      await authenticationService.authenticate(
        email,
        password,
        authType,
        displayName: displayName,
      );
      state = const AsyncValue.data(true);
    } catch (error) {
      print('Error $error');
      state = AsyncValue.error('authenticate() Error');
    }
  }
}
