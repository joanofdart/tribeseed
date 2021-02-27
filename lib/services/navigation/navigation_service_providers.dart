import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/services/navigation/navigation_service.dart';

final navigationServiceProvider = Provider<NavigationService>(
  (ref) => NavigationService(),
);
