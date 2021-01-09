import 'package:tribeseed/core/enums/auth_status.dart';

import 'model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> fetchUser({String userId});
}

class FakeUserRepository implements UserRepository {
  FakeUserRepository();

  @override
  Future<UserModel> fetchUser({String userId = '12345678'}) async {
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
}
