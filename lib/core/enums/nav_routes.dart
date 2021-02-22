import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum NavRoutes {
  home,
  profile,
}

extension NavRoutesExtension on NavRoutes {
  String get name => describeEnum(this);
}
