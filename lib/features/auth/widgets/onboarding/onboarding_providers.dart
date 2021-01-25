import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/auth/widgets/onboarding/onboarding_viewmodel.dart';

/// Provide a [EmailValidationViewModel] to [EmailValidationWidget]
///
final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>(
  (ref) {
    return OnboardingViewModel(ref: ref);
  },
);
