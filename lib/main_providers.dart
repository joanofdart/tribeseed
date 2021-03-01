import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repositories/user_repository/model/user_model.dart';

const kLoggedInState = false;

final useServiceMocksProvider = StateProvider<bool>(
  (ref) => true,
);

final currentUserProvider = StateProvider<UserModel>(
  (ref) {
    if (kLoggedInState) {
      return UserModel.generate();
    }
    return null;
  },
);
