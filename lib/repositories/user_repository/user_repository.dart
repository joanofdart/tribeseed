import 'package:flutter_riverpod/all.dart';

import 'model/user_model.dart';

abstract class UserRepository {
  Future<UserModel> authenticate({String userId});
  Future<UserModel> validateEmail();
  Future<UserModel> invalidateEmail();
  Future<UserModel> onboardUser();
}

class UserRepositoryImpl implements UserRepository {
  final ProviderReference ref;

  const UserRepositoryImpl({this.ref});

  @override
  Future<UserModel> authenticate({String userId}) {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  Future<UserModel> validateEmail({UserModel userModel}) {
    // TODO: implement validateEmail
    throw UnimplementedError();
  }

  @override
  Future<UserModel> onboardUser() {
    // TODO: implement onboardUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> invalidateEmail() {
    // TODO: implement invalidateEmail
    throw UnimplementedError();
  }
}
