import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/features/auth/widgets/auth_form/auth_type.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

abstract class AuthenticationService {
  UserModel currentUser();
  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
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
  UserModel currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

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
