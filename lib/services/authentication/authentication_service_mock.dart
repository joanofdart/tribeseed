import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/repositories/user_repository/user_repository_providers.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'authentication_service.dart';

class AuthenticationServiceMock implements AuthenticationService {
  final ProviderReference ref;

  AuthenticationServiceMock({
    @required this.ref,
  });

  @override
  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    final user = await ref.read(userRepositoryProvider).authenticate();
    ref.read(currentUserProvider).state = user;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> validateEmail() async {
    final user = await ref.read(userRepositoryProvider).validateEmail();
    ref.read(currentUserProvider).state = user;
  }
}
