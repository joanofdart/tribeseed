import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';

class EmailValidationViewModel extends StateNotifier<AsyncValue<bool>> {
  final AuthenticationService authenticationService;

  EmailValidationViewModel({
    this.authenticationService,
  }) : super(const AsyncLoading()) {
    _fetchEmailValidationState();
  }

  void _fetchEmailValidationState() {
    state = AsyncData(authenticationService.currentUser().emailVerified);
  }

  Future<void> validateEmail() async {
    state = const AsyncLoading();

    try {
      await authenticationService.validateEmail();
      state = AsyncData(authenticationService.currentUser().emailVerified);
    } catch (error) {
      state = AsyncError(error);
    }
  }
}
