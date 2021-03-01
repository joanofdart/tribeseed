import 'model/tribe_model.dart';

abstract class ITribeRepository {
  Future<void> create(TribeModel tribeModel);
  Future<void> update(TribeModel tribeModel);
  Future<void> delete(String id);
}
