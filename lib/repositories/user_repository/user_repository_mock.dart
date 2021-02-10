import 'model/user_model.dart';
import 'user_repository.dart';

class UserRepositoryMock implements UserRepository {
  const UserRepositoryMock();

  @override
  Future<bool> create(UserModel userModel) async {
    try {
      await Future.delayed(
        const Duration(seconds: 2),
        () => userModel,
      );
      return true;
    } catch (_) {
      print('Error while creating user $_');
      return false;
    }
  }

  @override
  Future<bool> update(UserModel userModel) async {
    try {
      await Future.delayed(
        const Duration(seconds: 2),
        () => userModel,
      );
      return true;
    } catch (_) {
      print('Error while updating user $_');
      return false;
    }
  }

  @override
  Future<bool> disable(String userId) {
    // TODO: implement disable
    throw UnimplementedError();
  }
}
