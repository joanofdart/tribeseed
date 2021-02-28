import 'package:flutter/foundation.dart';

enum NavRoutes {
  home,
  profile,
}

extension NavRoutesExtension on NavRoutes {
  String get name => describeEnum(this);
}
