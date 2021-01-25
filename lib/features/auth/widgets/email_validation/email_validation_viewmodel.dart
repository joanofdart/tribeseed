import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

abstract class EmailValidationState {
  const EmailValidationState();
}

class EmailValidationLoadingState extends EmailValidationState {
  const EmailValidationLoadingState();
}

class EmailValidationLoadedState extends EmailValidationState {
  const EmailValidationLoadedState();
}

class EmailValidationErrorState extends EmailValidationState {
  final String errorMessage;

  const EmailValidationErrorState({
    this.errorMessage,
  });
}

class EmailValidationViewModel extends StateNotifier<EmailValidationState> {
  final ProviderReference ref;

  EmailValidationViewModel({
    EmailValidationState state,
    this.ref,
  }) : super(state);

  Future<void> validateEmail() async {
    state = const EmailValidationLoadingState();

    try {
      await ref.read(authenticationServiceProvider).validateEmail();
      state = const EmailValidationLoadedState();
    } catch (error) {
      /// TODO: Make the error messages dynamic.
      state = const EmailValidationErrorState(errorMessage: 'Some Error');
    }
  }
}
