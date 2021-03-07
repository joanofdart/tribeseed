import 'package:tribeseed/core/models/user_model.dart';

abstract class IUserRepository {
  Future<void> create(UserModel userModel);
  Future<void> update(UserModel userModel);
  Future<void> disable(String id);
}
