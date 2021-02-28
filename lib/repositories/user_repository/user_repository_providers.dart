import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/main_providers.dart';

import 'user_repository.dart';
import 'user_repository_mock.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;

    if (useServiceMocks) {
      return UserRepositoryMock();
    }

    return const UserRepositoryImpl();
  },
);
