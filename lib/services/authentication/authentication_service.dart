import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

import 'authentication_service_interface.dart';

class AuthenticationService implements IAuthenticationService {
  final UserRepository userRepository;
  final Reader reader;

  AuthenticationService({
    @required this.userRepository,
    @required this.reader,
  });

  @override
  Future<void> authenticate(
    String email,
    String password,
    AuthType authType, {
    String displayName,
    AuthStatus authStatus,
  }) {
    // TODO: implement authenticateUser
    throw UnimplementedError();
  }

  @override
  void signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> validateEmail() {
    // TODO: implement validateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> onboardUser() {
    // TODO: implement onboardUser
    throw UnimplementedError();
  }

  @override
  Future<void> invalidateEmail() {
    // TODO: implement invalidateEmail
    throw UnimplementedError();
  }
}
