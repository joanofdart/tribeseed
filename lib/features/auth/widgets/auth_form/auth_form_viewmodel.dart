import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/auth/auth_type.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

abstract class AuthFormState {
  const AuthFormState();
}

class AuthFormLoadingState extends AuthFormState {
  const AuthFormLoadingState();
}

class AuthFormLoadedState extends AuthFormState {
  const AuthFormLoadedState();
}

class AuthFormErrorState extends AuthFormState {
  final String errorMessage;

  const AuthFormErrorState({
    this.errorMessage,
  });
}

class AuthFormViewModel extends StateNotifier<AuthFormState> {
  final ProviderReference reference;

  AuthFormViewModel({
    AuthFormState state,
    @required this.reference,
  }) : super(state);

  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    state = const AuthFormLoadingState();
    try {
      await reference.read(authenticationServiceProvider).authenticate(
            email: email,
            password: password,
            authType: authType,
          );
      state = const AuthFormLoadedState();
    } catch (error) {
      state = const AuthFormErrorState(
        errorMessage: 'Some error with Authenticate',
      );
    }
  }
}
