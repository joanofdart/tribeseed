import 'dart:math';

import 'package:tribeseed/repositories/tribe_repository/tribe_repository.dart';
import 'package:tribeseed/repositories/utils.dart';

import 'model/tribe_model.dart';

class TribeRepositoryMock implements TribeRepository {
  final Random random;

  TribeRepositoryMock() : random = Random();

  @override
  Future<void> create(TribeModel tribeModel) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'Tribe creation failed';
    }
  }

  @override
  Future<void> update(TribeModel tribeModel) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'Tribe update failed';
    }
  }

  @override
  Future<void> delete(String id) async {
    await waitForRandomTime();
    if (random.nextDouble() < errorTriggerPercentage) {
      throw 'Tribe deletion failed';
    }
  }
}
