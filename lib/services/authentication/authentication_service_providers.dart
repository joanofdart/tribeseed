import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';

import 'authentication_service.dart';
import 'authentication_service_mock.dart';

const kLoggedInState = false;

final authenticationServiceProvider = Provider<AuthenticationService>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;
    final userRepository = ref.watch(userRepositoryProvider);

    if (useServiceMocks) {
      return AuthenticationServiceMock(
        userRepository: userRepository,
        reader: ref.read,
      );
    }
    return AuthenticationServiceImpl(
      userRepository: userRepository,
      reader: ref.read,
    );
  },
);

final currentUserProvider = StateProvider<UserModel>(
  (ref) {
    if (kLoggedInState) {
      return UserModel.initial();
    }
    return null;
  },
);
