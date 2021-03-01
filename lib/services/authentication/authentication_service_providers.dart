import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recase/recase.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';

import 'authentication_service.dart';

final authenticationServiceProvider = Provider<AuthenticationService>(
  (ref) {
    final userRepository = ref.watch(userRepositoryProvider);

    return AuthenticationService(
      userRepository: userRepository,
      reader: ref.read,
    );
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
