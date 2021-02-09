import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/features/auth/widgets/auth_form/auth_type.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
import 'package:tribeseed/repositories/user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

import 'authentication_service.dart';
import 'authentication_service_providers.dart';

class AuthenticationServiceMock implements AuthenticationService {
  final UserRepository userRepository;
  final Reader reader;

  AuthenticationServiceMock({
    @required this.userRepository,
    @required this.reader,
  });

  @override
  UserModel currentUser() {
    return reader(currentUserProvider).state;
  }

  @override
  Future<void> authenticate({
    @required String email,
    @required String password,
    @required AuthType authType,
  }) async {
    final generatedId = Uuid().v4();
    final user = await userRepository.authenticate(generatedId);
    reader(currentUserProvider).state = user;
  }

  @override
  void signOut() {
    reader(currentUserProvider).state = null;
  }

  @override
  Future<void> validateEmail() async {
    final user = await userRepository.validateEmail(currentUser());
    reader(currentUserProvider).state = user;
  }

  @override
  Future<void> invalidateEmail() async {
    final user = await userRepository.invalidateEmail(currentUser());
    reader(currentUserProvider).state = user;
  }

  @override
  Future<void> onboardUser() async {
    final user = await userRepository.onboardUser(currentUser());
    reader(currentUserProvider).state = user;
  }
}
