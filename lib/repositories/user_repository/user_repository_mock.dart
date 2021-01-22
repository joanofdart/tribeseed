import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'model/user_model.dart';
import 'user_repository.dart';

class UserRepositoryMock implements UserRepository {
  final ProviderReference ref;

  UserRepositoryMock({this.ref});

  @override
  Future<UserModel> authenticate({String userId = '12345678'}) async {
    final authenticatedUser = UserModel(
      id: userId,
      aboutMe: 'Test User',
      authStatus: AuthStatus.pendingVerification.name,
      displayName: 'Test User',
      emailAddress: 'test@user.com',
      emailVerified: false,
      locale: 'en',
    );

    final authenticated = await Future.delayed(
      const Duration(seconds: 2),
      () => authenticatedUser,
    );

    return authenticated;
  }

  @override
  Future<UserModel> validateEmail() async {
    final user = ref.read(currentUserProvider).state.copyWith(
          authStatus: AuthStatus.emailVerified.name,
          emailVerified: true,
        );
    return Future.delayed(
      const Duration(seconds: 2),
      () => user,
    );
  }
}
