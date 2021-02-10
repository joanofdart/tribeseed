import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'auth_form_viewmodel.dart';

final authViewModelProvider = StateNotifierProvider<AuthFormViewModel>(
  (ref) {
    final authService = ref.watch(authenticationServiceProvider);
    return AuthFormViewModel(authenticationService: authService);
  },
);
