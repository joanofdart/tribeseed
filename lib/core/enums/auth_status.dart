import 'package:flutter/foundation.dart';

enum AuthStatus {
  guest,
  signedIn,
  signedUp,
  onboarding,
  pendingVerification,
  emailVerified,
  unknown,
}

extension AuthStatusNames on AuthStatus {
  String get name => describeEnum(this);
}
