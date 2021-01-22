import 'package:flutter/foundation.dart';

enum AuthType {
  signIn,
  signUp,
}

extension AuthTypeExtension on AuthType {
  String get name => describeEnum(this);
}
