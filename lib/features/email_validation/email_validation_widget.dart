import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/base/base_widget.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'email_validation_providers.dart';
import 'email_validation_viewmodel.dart';

class EmailValidationWidget extends ConsumerWidget {
  final WidgetBuilder emailValidated;

  const EmailValidationWidget({Key key, this.emailValidated}) : super(key: key);

  Widget _buildWidget(BuildContext context, ScopedReader watch) {
    final emailValidationState = watch(emailViewModelProvider.state);
    final currentUser = watch(currentUserProvider).state;

    if (emailValidationState is EmailValidationLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (emailValidationState is EmailValidationErrorState) {
      return Center(
        child: Text(emailValidationState.errorMessage),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentUser.displayName),
            Text(currentUser.authStatus),
            RaisedButton(
              onPressed: () {
                context.read(emailViewModelProvider).validateEmail();
              },
              child: const Text('Validate Email'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },

      /// Switch to the [HomeWidget] if the user is `signedIn`
      /// Build the [AuthWidget] if the user is `signedOut`
      child: BaseWidget(
        child: _buildWidget(context, watch),
      ),
    );
  }
}
