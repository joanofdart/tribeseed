import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'user_service_interface.dart';

class UserServiceMock implements IUserService {
  final UserRepository userRepository;
  final Reader reader;

  UserServiceMock({
    this.userRepository,
    this.reader,
  });

  @override
  Future<void> update({
    String aboutMe,
  }) async {
    final user = reader(currentUserProvider).state;
    try {
      final modifiedUser = user.copyWith(
        aboutMe: aboutMe,
      );
      await userRepository.update(modifiedUser);
      reader(currentUserProvider).state = modifiedUser;
    } catch (_) {
      rethrow;
    }
  }
}
