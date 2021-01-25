import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/widgets/base_widget.dart';
import 'package:tribeseed/features/auth/auth_status.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/features/auth/widgets/email_validation/email_validation.dart';
import 'package:tribeseed/features/auth/widgets/onboarding/onboarding.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'widgets/auth_form/auth_form.dart';

class AuthManager extends ConsumerWidget with TextContants {
  final WidgetBuilder authComplete;

  AuthManager({
    Key key,
    this.authComplete,
  }) : super(key: key);

  Widget _buildAuthFlow({
    String authStatus,
    BuildContext context,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: authStatus == AuthStatus.pendingVerification.name
          ? const EmailValidationWidget(
              key: ValueKey<String>('AuthEmailValidation'),
            )
          : authStatus == AuthStatus.onboarding.name
              ? const OnboardingWidget(
                  key: ValueKey<String>('AuthOnboarding'),
                )
              : authComplete(context),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;

    print(
      'Current user ${currentUser?.displayName} -  ${currentUser?.emailVerified}',
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),

      /// Switch to the [HomeWidget] if the user is `signedIn`
      /// Build the [AuthWidget] if the user is `signedOut`
      child: currentUser != null
          ? BaseWidget(
              child: _buildAuthFlow(
                authStatus: currentUser.authStatus,
                context: context,
              ),
            )
          : BaseWidget(
              child: AuthFormWidget(),
            ),
    );
  }
}
