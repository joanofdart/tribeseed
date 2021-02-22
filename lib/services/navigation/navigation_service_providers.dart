import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/services/navigation/navigation_service.dart';

final navigationServiceProvider = Provider<NavigationService>(
  (ref) => NavigationService(),
);
