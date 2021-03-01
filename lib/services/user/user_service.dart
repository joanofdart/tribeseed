import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_interface.dart';

class UserService {
  final IUserRepository userRepository;
  final Reader reader;

  UserService({
    this.userRepository,
    this.reader,
  });

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
