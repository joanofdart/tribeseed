import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/auth/auth_type.dart';

abstract class AuthenticationService {
  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
  });
  Future<void> signOut();
  Future<void> validateEmail();
  Future<void> invalidateEmail();
  Future<void> onboardUser();
}

class AuthenticationServiceImpl implements AuthenticationService {
  final ProviderReference ref;

  const AuthenticationServiceImpl({
    this.ref,
  });

  @override
  Future<void> authenticate({
    String email,
    String password,
    AuthType authType,
  }) {
    // TODO: implement authenticateUser
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
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
