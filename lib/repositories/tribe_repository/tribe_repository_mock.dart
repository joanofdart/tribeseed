import 'dart:math';

import 'package:tribeseed/core/models/tribe_model.dart';
import 'package:tribeseed/repositories/utils.dart';

import 'tribe_repository_interface.dart';

class TribeRepositoryMock implements ITribeRepository {
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
