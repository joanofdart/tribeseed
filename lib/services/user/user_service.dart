import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

import 'user_service_interface.dart';

class UserService implements IUserService {
  final UserRepository userRepository;
  final Reader reader;

  UserService({
    this.userRepository,
    this.reader,
  });

  @override
  Future<void> update({String aboutMe}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
