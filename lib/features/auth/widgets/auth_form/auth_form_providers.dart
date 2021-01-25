import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/features/auth/auth_type.dart';

import 'auth_form_viewmodel.dart';

/// Switch between [SignIn] and [SignUp]
///
final authTypeProvider = StateProvider<AuthType>((ref) => AuthType.signIn);

/// Provide a [GlobalKey<FormState>] used by the [AuthForm]
///
final authFormKeyProvider = Provider(
  (ref) => GlobalKey<FormState>(),
);

/// Provide a [AuthViewModel] to [AuthFormWidget]
///
final authViewModelProvider = StateNotifierProvider<AuthFormViewModel>(
  (ref) {
    return AuthFormViewModel(reference: ref);
  },
);
