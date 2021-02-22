import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

import 'authentication_service.dart';
import 'authentication_service_providers.dart';

class AuthenticationServiceMock implements AuthenticationService {
  final UserRepository userRepository;
  final Reader reader;

  AuthenticationServiceMock({
    @required this.userRepository,
    @required this.reader,
  });

  @override
  UserModel currentUser() {
    return reader(currentUserProvider).state;
  }

  @override
  Future<void> authenticate({
    String displayName,
    @required String email,
    @required String password,
    @required AuthType authType,
    AuthStatus authStatus = AuthStatus.pendingVerification,
  }) async {
    switch (authType) {
      case AuthType.signUp:

        ///Authenticate user and retrieve data from DB
        ///
        try {
          final authenticatedUser = _generateUser(
            authStatus,
            email: email,
            displayName: displayName,
          );
          await userRepository.create(authenticatedUser);
          reader(currentUserProvider).state = authenticatedUser;
        } catch (_) {
          rethrow;
        }
        break;

      case AuthType.signIn:
      default:

        ///Authenticate user
        ///
        final authenticatedUser = _generateUser(
          authStatus,
          email: email,
          displayName: displayName,
        );
        reader(currentUserProvider).state = authenticatedUser;
        break;
    }
  }

  @override
  void signOut() {
    reader(currentUserProvider).state = null;
  }

  @override
  Future<void> validateEmail() async {
    try {
      final user = currentUser();
      final modifiedUser = user.copyWith(
        emailVerified: true,
        authStatus: AuthStatus.onboarding.name,
      );
      await userRepository.update(modifiedUser);
      reader(currentUserProvider).state = modifiedUser;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> invalidateEmail() async {
    try {
      final user = currentUser();
      final modifiedUser = user.copyWith(
        emailVerified: false,
        authStatus: AuthStatus.pendingVerification.name,
      );
      await userRepository.update(modifiedUser);
      reader(currentUserProvider).state = modifiedUser;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> onboardUser() async {
    try {
      final user = currentUser();
      final modifiedUser = user.copyWith(
        authStatus: AuthStatus.complete.name,
      );
      await userRepository.update(modifiedUser);
      reader(currentUserProvider).state = modifiedUser;
    } catch (_) {
      rethrow;
    }
  }

  UserModel _generateUser(
    AuthStatus authStatus, {
    String email,
    String displayName,
  }) {
    final uuid = Uuid().v4();
    final generatedUser = UserModel(
      id: uuid,
      aboutMe: 'Lorem ipsum dolore',
      authStatus: authStatus.name,
      displayName: displayName ?? 'Test User',
      emailAddress: email ?? 'test@user.com',
      emailVerified: authStatus.name == AuthStatus.onboarding.name ||
          authStatus.name == AuthStatus.complete.name,
      locale: 'en',
    );
    return generatedUser;
  }
}
