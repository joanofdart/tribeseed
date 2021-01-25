import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

class OnboardingState {
  const OnboardingState();
}

class OnboardingLoadingState extends OnboardingState {
  const OnboardingLoadingState();
}

class OnboardingLoadedState extends OnboardingState {
  const OnboardingLoadedState();
}

class OnboardingErrorState extends OnboardingState {
  final String errorMessage;

  const OnboardingErrorState({
    this.errorMessage,
  });
}

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  final ProviderReference ref;
  OnboardingViewModel({
    OnboardingState state,
    this.ref,
  }) : super(state);

  Future<void> onboardUser() async {
    state = const OnboardingLoadingState();

    try {
      await ref.read(authenticationServiceProvider).onboardUser();
      state = const OnboardingLoadedState();
    } catch (error) {
      /// TODO: Make the error messages dynamic.
      state = const OnboardingErrorState(
        errorMessage: 'Some error with Onboarding',
      );
    }
  }

  Future<void> invalidateEmail() async {
    state = const OnboardingLoadingState();

    try {
      await ref.read(authenticationServiceProvider).invalidateEmail();
      state = const OnboardingLoadedState();
    } catch (error) {
      /// TODO: Make the error messages dynamic.
      state = const OnboardingErrorState(
        errorMessage: 'Some error with InvalidateEmail',
      );
    }
  }
}
