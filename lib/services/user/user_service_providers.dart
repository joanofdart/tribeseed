import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';
import 'package:tribeseed/services/user/user_service_interface.dart';
import 'package:tribeseed/services/user/user_service_mock.dart';

import 'user_service.dart';

final userServiceProvider = Provider<IUserService>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;
    final userRepository = ref.watch(userRepositoryProvider);

    if (useServiceMocks) {
      return UserServiceMock(
        userRepository: userRepository,
        reader: ref.read,
      );
    }
    return UserService(
      userRepository: userRepository,
      reader: ref.read,
    );
  },
);
