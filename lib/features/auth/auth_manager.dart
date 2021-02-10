import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/widgets/base_widget.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'auth_status.dart';
import 'widgets/widgets.dart';

class AuthManager extends ConsumerWidget {
  final WidgetBuilder authComplete;

  const AuthManager({
    Key key,
    this.authComplete,
  }) : super(key: key);

  Widget _buildAuthFlow({
    String authStatus,
    BuildContext context,
  }) {
    if (authStatus == AuthStatus.pendingVerification.name) {
      return const EmailValidationWidget(
        key: ValueKey<String>('AuthEmailValidation'),
      );
    } else if (authStatus == AuthStatus.onboarding.name) {
      return const OnboardingWidget(
        key: ValueKey<String>('AuthOnboarding'),
      );
    } else {
      return authComplete(context);
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;

    print(
      'Current user ${currentUser?.displayName} -  ${currentUser?.emailVerified}',
    );

    return BaseWidget(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),

        /// Switch to the [HomeWidget] if the user is `signedIn`
        /// Build the [AuthWidget] if the user is `signedOut`
        child: currentUser != null
            ? _buildAuthFlow(
                authStatus: currentUser.authStatus,
                context: context,
              )
            : const AuthFormWidget(
                key: ValueKey<String>('AuthForm'),
              ),
      ),
    );
  }
}
