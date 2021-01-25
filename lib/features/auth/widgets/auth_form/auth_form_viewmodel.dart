import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/auth/auth_type.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

abstract class AuthState {
  const AuthState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthLoadedState extends AuthState {
  const AuthLoadedState();
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({
    this.message,
  });
}

class AuthFormViewModel extends StateNotifier<AuthState> {
  final ProviderReference reference;

  AuthFormViewModel({
    AuthState state,
    @required this.reference,
  }) : super(state);

  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    state = const AuthLoadingState();
    try {
      await reference.read(authenticationServiceProvider).authenticate(
            email: email,
            password: password,
            authType: authType,
          );
      state = const AuthLoadedState();
    } catch (error) {
      state = const AuthErrorState(message: 'Unknown error');
    }
  }
}
