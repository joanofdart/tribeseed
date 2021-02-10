import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'auth_form_viewmodel.dart';
import '../../../../core/enums/auth_type.dart';

final authTypeProvider = StateProvider<AuthType>((ref) => AuthType.signIn);

final authFormKeyProvider = Provider(
  (ref) => GlobalKey<FormState>(),
);

final authViewModelProvider = StateNotifierProvider<AuthFormViewModel>(
  (ref) {
    final authService = ref.watch(authenticationServiceProvider);
    return AuthFormViewModel(authenticationService: authService);
  },
);
