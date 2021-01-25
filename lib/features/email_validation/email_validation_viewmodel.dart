import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

abstract class EmailValidationState {
  const EmailValidationState();
}

class EmailValidationInitialState extends EmailValidationState {
  const EmailValidationInitialState();
}

class EmailValidationLoadingState extends EmailValidationState {
  const EmailValidationLoadingState();
}

class EmailValidationLoadedState extends EmailValidationState {
  const EmailValidationLoadedState();
}

class EmailValidationErrorState extends EmailValidationState {
  final String errorMessage;

  const EmailValidationErrorState(this.errorMessage);
}

class EmailValidationViewModel extends StateNotifier<EmailValidationState> {
  final ProviderReference reference;

  EmailValidationViewModel({
    EmailValidationState state,
    this.reference,
  }) : super(state);

  Future<void> validateEmail() async {
    state = const EmailValidationLoadingState();

    try {
      await reference.read(authenticationServiceProvider).validateEmail();
      state = const EmailValidationLoadedState();
    } catch (error) {
      state = const EmailValidationErrorState('Some Error');
    }
  }
}
