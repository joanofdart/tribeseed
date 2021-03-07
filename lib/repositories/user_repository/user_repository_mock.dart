import 'dart:math';

import 'package:tribeseed/core/models/user_model.dart';
import 'package:tribeseed/repositories/utils.dart';

import 'user_repository_interface.dart';

class UserRepositoryMock implements IUserRepository {
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
  Future<void> disable(String id) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User disabling failed';
    }
  }
}
