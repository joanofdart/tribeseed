import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final authFormSwitchProvider = StateProvider<bool>((ref) => true);
final authFormKeyProvider = Provider(
  (ref) => GlobalKey<FormState>(),
);
