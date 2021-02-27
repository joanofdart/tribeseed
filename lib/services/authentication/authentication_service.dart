import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

abstract class AuthenticationService {
  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
    String displayName,
    AuthStatus authStatus,
  });
  Future<void> validateEmail();
  Future<void> invalidateEmail();
  Future<void> onboardUser();
  void signOut();
}

class AuthenticationServiceImpl implements AuthenticationService {
  final UserRepository userRepository;
  final Reader reader;

  AuthenticationServiceImpl({
    @required this.userRepository,
    @required this.reader,
  });

  @override
  Future<void> authenticate({
    String email,
    String password,
    String displayName,
    AuthType authType,
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
