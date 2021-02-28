import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

abstract class UserService {
  Future<void> update({
    String aboutMe,
  });
}

class UserServiceImpl implements UserService {
  final UserRepository userRepository;
  final Reader reader;

  UserServiceImpl({
    this.userRepository,
    this.reader,
  });

  @override
  Future<void> update({String aboutMe}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
