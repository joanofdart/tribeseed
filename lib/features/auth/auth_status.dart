import 'package:flutter/foundation.dart';

enum AuthStatus {
  onboarding,
  pendingVerification,
  complete,
}

extension AuthStatusNames on AuthStatus {
  String get name => describeEnum(this);
}
