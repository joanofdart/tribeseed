import 'package:flutter_riverpod/all.dart';

import 'email_validation_viewmodel.dart';

/// Provide a [EmailValidationViewModel] to [EmailValidationWidget]
///
final emailViewModelProvider = StateNotifierProvider<EmailValidationViewModel>(
  (ref) {
    return EmailValidationViewModel(ref: ref);
  },
);
