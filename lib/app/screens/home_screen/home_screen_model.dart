import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service.dart';

class HomeScreenModel extends StateNotifier<AsyncValue<bool>> {
  final AuthenticationService authenticationService;

  HomeScreenModel(this.authenticationService) : super(AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = AsyncValue.data(true);
  }

  Future<void> validateEmail() async {
    state = const AsyncValue.loading();
    try {
      /// Mimic network request
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      await authenticationService.validateEmail();
      state = const AsyncData(true);
    } catch (error) {
      print('Error $error');
      state = AsyncValue.error('validateEmail() Error');
    }
  }

  Future<void> invalidateEmail() async {
    state = const AsyncValue.loading();
    try {
      /// Mimic network request
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      await authenticationService.invalidateEmail();
      state = const AsyncData(true);
    } catch (error) {
      print('Error $error');
      state = AsyncValue.error('validateEmail() Error');
    }
  }
}
