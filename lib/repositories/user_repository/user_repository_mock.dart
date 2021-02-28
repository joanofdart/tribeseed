import 'dart:math';

import 'model/user_model.dart';
import 'user_repository.dart';

const errorTriggerPercentage = 0.5;

class UserRepositoryMock implements UserRepository {
  final Random random;

  UserRepositoryMock() : random = Random();

  @override
  Future<void> create(UserModel userModel) async {
    await _waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User creation failed';
    }
  }

  @override
  Future<void> update(UserModel userModel) async {
    await _waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User update failed';
    }
  }

  @override
  Future<void> disable(String userId) async {
    await _waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'User disabling failed';
    }
  }

  Future<void> _waitForRandomTime() async {
    await Future.delayed(
      Duration(
        seconds: random.nextInt(3),
      ),
      () {},
    );
  }
}
