import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';

class AuthFormViewModel extends StateNotifier<AsyncValue<bool>> {
  final AuthenticationService authenticationService;

  AuthFormViewModel({
    @required this.authenticationService,
  }) : super(const AsyncData(false));

  Future<void> authenticate({
    String displayName,
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    state = const AsyncLoading();
    try {
      await authenticationService.authenticate(
        displayName: displayName,
        email: email,
        password: password,
        authType: authType,
      );
      state = const AsyncData(true);
    } catch (error) {
      print('Error $error');
      state = AsyncError(error);
    }
  }
}
