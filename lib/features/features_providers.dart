import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';

///
/// Mocked Firebase Functions
///
final authStateChangesProviderMock = StateProvider<bool>(
  (ref) => false,
);

///
/// Mocked Repositories Providers
///

/// [FakeUserRepository] specific functionality and providers.
final userRepositoryProviderFake = Provider<UserRepository>(
  (ref) => FakeUserRepository(),
);

/// [fetchUser()] future provider from the [FakeUserRepository] provider.
final userFutureProviderFake = FutureProvider<UserModel>(
  (ref) async => ref.watch(userRepositoryProviderFake).fetchUser(),
);
