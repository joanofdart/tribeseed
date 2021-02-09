import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> authenticate(String userId);
  Future<UserModel> validateEmail(UserModel userModel);
  Future<UserModel> invalidateEmail(UserModel userModel);
  Future<UserModel> onboardUser(UserModel userModel);
}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl();

  @override
  Future<UserModel> authenticate(String userId) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<UserModel> validateEmail(UserModel userModel) {
    // TODO: implement validateEmail
    throw UnimplementedError();
  }

  @override
  Future<UserModel> onboardUser(UserModel userModel) {
    // TODO: implement onboardUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> invalidateEmail(UserModel userModel) {
    // TODO: implement invalidateEmail
    throw UnimplementedError();
  }
}
