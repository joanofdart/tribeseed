import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

/// Switch between [SignIn] and [SignUp]
final authFormSwitchProvider = StateProvider<bool>((ref) => true);

/// Provide a [GlobalKey<FormState>] used by the [AuthForm]
final authFormKeyProvider = Provider(
  (ref) => GlobalKey<FormState>(),
);
