import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'email_validation_providers.dart';

class EmailValidationWidget extends ConsumerWidget {
  const EmailValidationWidget({
    Key key,
  }) : super(key: key);

  Future<void> _validateEmail({
    BuildContext context,
  }) async {
    final model = context.read(emailViewModelProvider);
    await model.validateEmail();
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(emailViewModelProvider.state);
    final currentUser = watch(currentUserProvider).state;
    final isLoading = model.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final errorMessage = model.maybeWhen(
      error: (error, stackTrace) {
        print('Error $error');
        print('Stacktrace $stackTrace');
        return 'Validation Error';
      },
      orElse: () => null,
    );

    return Center(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) const LoadingStateWidget(),
          Text(errorMessage ?? ''),
          Text(currentUser.displayName),
          Text(currentUser.authStatus),
          RaisedButton(
            onPressed:
                isLoading ? null : () => _validateEmail(context: context),
            child: const Text('Validate Email'),
          ),
        ],
      ),
    );
  }
}
