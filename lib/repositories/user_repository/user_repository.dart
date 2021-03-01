import 'model/user_model.dart';
import 'user_repository_interface.dart';

class UserRepositoryImpl implements IUserRepository {
  const UserRepositoryImpl();

  @override
  Future<bool> create(UserModel userModel) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> update(UserModel userModel) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> disable(String userId) {
    // TODO: implement disable
    throw UnimplementedError();
  }
}
