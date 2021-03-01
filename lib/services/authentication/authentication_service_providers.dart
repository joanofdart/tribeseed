import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recase/recase.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';
import 'package:tribeseed/services/authentication/authentication_service_interface.dart';

import 'authentication_service.dart';
import 'authentication_service_mock.dart';

const kLoggedInState = false;

final authenticationServiceProvider = Provider<IAuthenticationService>(
  (ref) {
    final useServiceMocks = ref.watch(useServiceMocksProvider).state;
    final userRepository = ref.watch(userRepositoryProvider);

    if (useServiceMocks) {
      return AuthenticationServiceMock(
        userRepository: userRepository,
        reader: ref.read,
      );
    }
    return AuthenticationService(
      userRepository: userRepository,
      reader: ref.read,
    );
  },
);

final currentUserProvider = StateProvider<UserModel>(
  (ref) {
    if (kLoggedInState) {
      return UserModel.generate();
    }
    return null;
  },
);

/// TODO: Make this a map that includes the text to be used.
/// e.g: Have a list that matches the key from the UserModel and return
/// a friendly field name with the text to warn the user
final pendingUserActionsProvider = StateProvider<List<String>>(
  (ref) {
    final currentUser = ref.watch(currentUserProvider).state;
    final currentUserAsMap = currentUser.toMap();
    final list = <String>[];

    for (final _mapEntry in currentUserAsMap.entries) {
      if (_mapEntry.value == null || _mapEntry.value == '') {
        final sentenceCase = ReCase(_mapEntry.key).sentenceCase.titleCase;
        list.add(sentenceCase);
      }
    }

    return list;
  },
);
