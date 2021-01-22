import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';
import 'package:tribeseed/services/authentication/authentication_service_mock.dart';

final authenticationServiceProvider = Provider<AuthenticationService>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;

    if (useServiceMocks) {
      return AuthenticationServiceMock(
        ref: ref,
      );
    }
    return AuthenticationServiceImpl(ref: ref);
  },
);

final currentUserProvider = StateProvider<UserModel>(
  (ref) => null,
);
