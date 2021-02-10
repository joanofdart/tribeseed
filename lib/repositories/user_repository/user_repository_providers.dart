import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/main_providers.dart';

import 'user_repository.dart';
import 'user_repository_mock.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;

    if (useServiceMocks) {
      return const UserRepositoryMock();
    }

    return const UserRepositoryImpl();
  },
);
