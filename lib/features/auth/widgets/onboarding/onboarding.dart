import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';

import 'onboarding_providers.dart';

class OnboardingWidget extends ConsumerWidget {
  const OnboardingWidget({
    Key key,
  }) : super(key: key);

  Future<void> _invalidateEmail({
    BuildContext context,
  }) async {
    final viewModel = context.read(onboardingViewModelProvider);
    await viewModel.invalidateEmail();
  }

  Future<void> _onboardUser({
    BuildContext context,
  }) async {
    final viewModel = context.read(onboardingViewModelProvider);
    await viewModel.onboardUser();
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final viewModel = watch(onboardingViewModelProvider.state);
    final isLoading = viewModel.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    viewModel.maybeWhen(
      error: (error, stackTrace) {
        print('Error $error');
        print('Stacktrace $stackTrace');

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Onboarding error ${timeStamp.inSeconds}'),
            ),
          );
        });
      },
      orElse: () => null,
    );

    if (isLoading) {
      return const LoadingStateWidget();
    }

    return Center(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Onboarding'),
          RaisedButton(
            onPressed: () => _invalidateEmail(context: context),
            child: const Text('Invalidate Email'),
          ),
          RaisedButton(
            onPressed: () => _onboardUser(context: context),
            child: const Text('Or complete profile'),
          )
        ],
      ),
    );
  }
}
