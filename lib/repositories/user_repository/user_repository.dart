import 'model/user_model.dart';

abstract class UserRepository {
  Future<void> create(UserModel userModel);
  Future<void> update(UserModel userModel);
  Future<void> disable(String userId);
}

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl();

  @override
  Future<void> create(UserModel userModel) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> disable(String userId) {
    // TODO: implement disable
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserModel userModel) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
