import 'package:tribeseed/core/enums/auth_status.dart';
import 'package:tribeseed/core/enums/auth_type.dart';

abstract class IAuthenticationService {
  Future<void> authenticate(
    String email,
    String password,
    AuthType authType, {
    String displayName,
    AuthStatus authStatus,
  });
  Future<void> validateEmail();
  Future<void> invalidateEmail();
  void signOut();
}
