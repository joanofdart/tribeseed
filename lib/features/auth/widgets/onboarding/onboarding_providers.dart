import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'onboarding_viewmodel.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>(
  (ref) {
    final authService = ref.watch(authenticationServiceProvider);
    return OnboardingViewModel(authenticationService: authService);
  },
);
