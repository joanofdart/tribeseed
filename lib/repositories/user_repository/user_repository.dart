import 'model/user_model.dart';

abstract class UserRepository {
  Future<bool> create(UserModel userModel);
  Future<bool> update(UserModel userModel);
  Future<bool> disable(String userId);
}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl();

  @override
  Future<bool> create(UserModel userModel) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> disable(String userId) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<bool> update(UserModel userModel) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
