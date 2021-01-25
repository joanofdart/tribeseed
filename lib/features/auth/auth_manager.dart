import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/base/base_widget.dart';
import 'package:tribeseed/features/auth/auth_status.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/repositories/user_repository/model/user_model.dart';
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
          ? Center(
              key: const ValueKey<String>('AuthEmailValidation'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('EmailValidation'),
                  RaisedButton(
                    onPressed: () => context.read(currentUserProvider).state =
                        context.read(currentUserProvider).state.copyWith(
                              authStatus: AuthStatus.onboarding.name,
                            ),
                    child: const Text('Validate Email'),
                  ),
                ],
              ),
            )
          : authStatus == AuthStatus.onboarding.name
              ? Center(
                  key: const ValueKey<String>('AuthOnboarding'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Onboarding'),
                      RaisedButton(
                        onPressed: () => context
                                .read(currentUserProvider)
                                .state =
                            context.read(currentUserProvider).state.copyWith(
                                  authStatus:
                                      AuthStatus.pendingVerification.name,
                                ),
                        child: const Text('Invalidate Email'),
                      ),
                      RaisedButton(
                        onPressed: () => context
                                .read(currentUserProvider)
                                .state =
                            context.read(currentUserProvider).state.copyWith(
                                  authStatus: AuthStatus.complete.name,
                                ),
                        child: const Text('Or complete profile'),
                      )
                    ],
                  ),
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
              child: AuthForm(),
            ),
    );
  }
}
