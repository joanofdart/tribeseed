import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/home/email_validation/email_validation_viewmodel.dart';

/// Provide a [AuthViewModel] to [AuthWidget]
///
final emailViewModelProvider = StateNotifierProvider<EmailValidationViewModel>(
  (ref) {
    return EmailValidationViewModel(reference: ref);
  },
);
