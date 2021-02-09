import 'package:tribeseed/features/auth/auth_status.dart';

import 'model/user_model.dart';
import 'user_repository.dart';

class UserRepositoryMock implements UserRepository {
  const UserRepositoryMock();

  @override
  Future<UserModel> authenticate(String userId) async {
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
  Future<UserModel> validateEmail(UserModel userModel) async {
    final user = userModel.copyWith(
      authStatus: AuthStatus.onboarding.name,
      emailVerified: true,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => user,
    );
  }

  @override
  Future<UserModel> invalidateEmail(UserModel userModel) {
    final user = userModel.copyWith(
      authStatus: AuthStatus.pendingVerification.name,
      emailVerified: false,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => user,
    );
  }

  @override
  Future<UserModel> onboardUser(UserModel userModel) {
    final user = userModel.copyWith(
      authStatus: AuthStatus.complete.name,
    );
    return Future.delayed(
      const Duration(seconds: 2),
      () => user,
    );
  }
}
