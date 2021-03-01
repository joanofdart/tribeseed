import 'package:tribeseed/repositories/tribe_repository/model/tribe_model.dart';

abstract class TribeRepository {
  Future<void> create(TribeModel tribeModel);
  Future<void> update(TribeModel tribeModel);
  Future<void> delete(String id);
}

class TribeRepositoryImpl implements TribeRepository {
  @override
  Future<void> create(TribeModel tribeModel) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> update(TribeModel tribeModel) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
