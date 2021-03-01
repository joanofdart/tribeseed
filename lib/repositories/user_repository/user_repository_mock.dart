import 'dart:math';

import 'package:tribeseed/repositories/utils.dart';

import 'model/user_model.dart';
import 'user_repository.dart';

class UserRepositoryMock implements UserRepository {
  final Random random;

  UserRepositoryMock() : random = Random();

  @override
  Future<void> create(UserModel userModel) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User creation failed';
    }
  }

  @override
  Future<void> update(UserModel userModel) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User update failed';
    }
  }

  @override
  Future<void> disable(String userId) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User disabling failed';
    }
  }
}
