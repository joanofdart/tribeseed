import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/app/app_providers.dart';
import 'package:tribeseed/app/screens/home_screen/widgets/actions_popup_card.dart';
import 'package:tribeseed/app/widgets/animated_background_avatar.dart';
import 'package:tribeseed/app/widgets/hero_popup_card.dart';
import 'package:tribeseed/app/widgets/text_logo.dart';
import 'package:tribeseed/core/enums/nav_routes.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';
import 'package:tribeseed/services/navigation/navigation_service_providers.dart';

import 'home_screen_model.dart';

final _homeScreenProvider = StateNotifierProvider<HomeScreenModel>(
  (ref) {
    return HomeScreenModel();
  },
);

class HomeScreen extends HookWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = useProvider(currentUserProvider).state;
    final _pendingActions = useProvider(pendingUserActionsProvider).state;
    final _appViewIndex = useProvider(appViewIndexProvider);
    final _navigationService = useProvider(navigationServiceProvider);

    final _isBusy = useState(false);
    final _userIsVerified = _currentUser.emailVerified;

    return ProviderListener<AsyncValue<bool>>(
      provider: _homeScreenProvider.state,
      onChange: (context, state) {
        state.when(
          loading: () {
            _isBusy.value = true;
          },
          error: (error, stackTrace) {
            _isBusy.value = false;
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Error ${error.toString()}'),
              ),
            );
          },
          data: (value) {
            _isBusy.value = false;

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Success'),
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: HeroPopUpCard(
                heroTag: 'avatar-hero-popup',
                popupChild: ActionsPopupCard(
                  actionIcon: Icons.warning,
                  actions: _pendingActions,
                  goTo: () {
                    /// First, the HeroPopupCard needs to be closed
                    _navigationService.rootState.pop();

                    /// Switch stack index
                    _appViewIndex.state = NavRoutes.profile.index;
                  },
                ),
                child: AnimatedBackgroundAvatar(
                  animate: _isBusy.value,
                  backgroundColor:
                      _userIsVerified ? Colors.green[300] : Colors.red[800],
                  avatar: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/avatars/default.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: TextLogo(),
          elevation: 20,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_currentUser.emailVerified.toString()),
              Text(_currentUser.authStatus),
              Text(_currentUser.emailAddress),
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed('/test'),
                child: Text('Go to Tesaaat - ${_currentUser.displayName}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
