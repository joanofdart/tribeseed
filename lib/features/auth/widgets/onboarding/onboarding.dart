import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/widgets/error_state_widget.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/core/widgets/state_switcher_widget.dart';
import 'package:tribeseed/features/auth/widgets/onboarding/onboarding_viewmodel.dart';

import 'onboarding_providers.dart';

class OnboardingWidget extends ConsumerWidget {
  const OnboardingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final onboardingState = watch(onboardingViewModelProvider.state);
    final onboardingViewModel = watch(onboardingViewModelProvider);

    return StateSwitcherWidget(
      builder: (context) {
        if (onboardingState is OnboardingLoadingState) {
          return const LoadingStateWidget();
        } else if (onboardingState is OnboardingErrorState) {
          return ErrorStateWidget(
            errorMessage: onboardingState.errorMessage,
          );
        } else {
          return Center(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Onboarding'),
                RaisedButton(
                  onPressed: () {
                    onboardingViewModel.invalidateEmail();
                  },
                  child: const Text('Invalidate Email'),
                ),
                RaisedButton(
                  onPressed: () {
                    onboardingViewModel.onboardUser();
                  },
                  child: const Text('Or complete profile'),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
