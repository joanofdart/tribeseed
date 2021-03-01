import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_interface.dart';

class AuthenticationService {
  final IUserRepository userRepository;
  final Reader reader;

  AuthenticationService({
    @required this.userRepository,
    @required this.reader,
  });

  Future<void> authenticate(
    String email,
    String password,
    AuthType authType, {
    String displayName,
    AuthStatus authStatus = AuthStatus.pendingVerification,
  }) async {
    final _generatedUser = UserModel.generate(
      emailAddress: email,
      displayName: displayName,
      authStatus: authStatus,
    );

    switch (authType) {
      case AuthType.signUp:

        ///Authenticate user and retrieve data from DB
        ///
        try {
          await userRepository.create(_generatedUser);
          reader(currentUserProvider).state = _generatedUser;
        } catch (_) {
          rethrow;
        }
        break;

      case AuthType.signIn:
      default:

        ///Authenticate user
        ///
        reader(currentUserProvider).state = _generatedUser;

        /// TODO: Maybe add a last login => device => date ?
        break;
    }
  }

  void signOut() {
    reader(currentUserProvider).state = null;
  }

  Future<void> validateEmail() async {
    final user = reader(currentUserProvider).state;
    try {
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

  Future<void> invalidateEmail() async {
    final user = reader(currentUserProvider).state;
    try {
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

  Future<void> onboardUser() async {
    final user = reader(currentUserProvider).state;
    try {
      final modifiedUser = user.copyWith(
        authStatus: AuthStatus.complete.name,
      );
      await userRepository.update(modifiedUser);
      reader(currentUserProvider).state = modifiedUser;
    } catch (_) {
      rethrow;
    }
  }
}
