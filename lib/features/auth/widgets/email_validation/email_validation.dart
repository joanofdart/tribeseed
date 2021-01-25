import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/widgets/error_state_widget.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/core/widgets/state_switcher_widget.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'email_validation_providers.dart';
import 'email_validation_viewmodel.dart';

class EmailValidationWidget extends ConsumerWidget {
  const EmailValidationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;
    final emailValidationState = watch(emailViewModelProvider.state);
    final emailValidationModel = watch(emailViewModelProvider);

    return StateSwitcherWidget(
      builder: (context) {
        if (emailValidationState is EmailValidationLoadingState) {
          return const LoadingStateWidget();
        } else if (emailValidationState is EmailValidationErrorState) {
          return ErrorStateWidget(
            errorMessage: emailValidationState.errorMessage,
          );
        } else {
          return Center(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currentUser.displayName),
                Text(currentUser.authStatus),
                RaisedButton(
                  onPressed: () {
                    emailValidationModel.validateEmail();
                  },
                  child: const Text('Validate Email'),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
