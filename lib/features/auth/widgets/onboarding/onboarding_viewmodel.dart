import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';

class OnboardingViewModel extends StateNotifier<AsyncValue<bool>> {
  final AuthenticationService authenticationService;

  OnboardingViewModel({
    this.authenticationService,
  }) : super(const AsyncData(false));

  Future<void> onboardUser() async {
    state = const AsyncLoading();

    try {
      await authenticationService.onboardUser();
      state = const AsyncData(true);
    } catch (error) {
      print('Onboarding error ${error.toString()}');
      state = AsyncError('Error while onboarding');
    }
  }

  Future<void> invalidateEmail() async {
    state = const AsyncLoading();

    try {
      await authenticationService.invalidateEmail();
      state = const AsyncData(true);
    } catch (error) {
      print('Onboarding - InvalidateEmail - Error $error');
      state = AsyncError(error);
    }
  }
}
