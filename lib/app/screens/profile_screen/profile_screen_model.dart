import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/services/authentication/authentication_service_interface.dart';
import 'package:tribeseed/services/user/user_service_interface.dart';

class ProfileScreenModel extends StateNotifier<AsyncValue<bool>> {
  final IUserService userService;
  final IAuthenticationService authenticationService;

  ProfileScreenModel({
    this.userService,
    this.authenticationService,
  }) : super(AsyncValue.loading()) {
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
      state = const AsyncValue.data(true);
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
      state = const AsyncValue.data(true);
    } catch (error) {
      print('Error $error');
      state = AsyncValue.error('validateEmail() Error');
    }
  }

  Future<void> update({
    String aboutMe,
  }) async {
    state = const AsyncValue.loading();
    try {
      /// Mimic network request
      await Future.delayed(
        const Duration(
          seconds: 2,
        ),
      );
      await userService.update(aboutMe: aboutMe);
      state = const AsyncValue.data(true);
    } catch (error) {
      print('Error $error');
      state = AsyncValue.error('update() Error');
    }
  }
}
