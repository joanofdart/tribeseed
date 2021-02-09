import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'email_validation_viewmodel.dart';

final emailViewModelProvider = StateNotifierProvider<EmailValidationViewModel>(
  (ref) {
    final authService = ref.watch(authenticationServiceProvider);
    return EmailValidationViewModel(authenticationService: authService);
  },
);
