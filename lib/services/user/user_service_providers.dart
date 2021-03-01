import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';

import 'user_service.dart';

final userServiceProvider = Provider<UserService>(
  (ref) {
    final userRepository = ref.watch(userRepositoryProvider);

    return UserService(
      userRepository: userRepository,
      reader: ref.read,
    );
  },
);
