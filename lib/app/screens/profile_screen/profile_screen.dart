import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/app/widgets/action_button.dart';
import 'package:tribeseed/app/widgets/form_input.dart';
import 'package:tribeseed/main_providers.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';
import 'package:tribeseed/services/user/user_service_providers.dart';

import 'profile_screen_model.dart';

final _profileScreenProvider = StateNotifierProvider<ProfileScreenModel>(
  (ref) {
    final userService = ref.watch(userServiceProvider);
    final authenticationService = ref.watch(authenticationServiceProvider);

    return ProfileScreenModel(
      userService: userService,
      authenticationService: authenticationService,
    );
  },
);

class ProfileScreen extends HookWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentUser = useProvider(currentUserProvider).state;

    final _isBusy = useState(false);
    final _focusNode = useFocusNode();
    final _aboutMeController = useTextEditingController(
      text: _currentUser.aboutMe,
    );

    final _emailVerified = _currentUser.emailVerified;

    return ProviderListener<AsyncValue<bool>>(
      provider: _profileScreenProvider.state,
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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 95,
                    backgroundImage: AssetImage('assets/avatars/default.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _currentUser.displayName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _currentUser.emailVerified
                        ? Colors.green[400]
                        : Colors.red[400],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        child: _emailVerified
                            ? Icon(
                                Icons.verified,
                                color: Colors.white70,
                              )
                            : Icon(
                                Icons.error,
                                color: Colors.white70,
                              ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _emailVerified
                            ? 'Email verified'
                            : 'Pending email verification',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FormInput(
                  labelText: 'About Me',
                  focusNode: _focusNode,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 140,
                  controller: _aboutMeController,
                  prefixIcon: Icon(
                    Icons.badge,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (!_emailVerified)
                  ActionButton(
                    buttonText: 'Validate Test',
                    showLoading: _isBusy.value,
                    onPressed: () =>
                        context.read(_profileScreenProvider).validateEmail(),
                  )
                else
                  ActionButton(
                    buttonText: 'Invalidate Test',
                    showLoading: _isBusy.value,
                    onPressed: () =>
                        context.read(_profileScreenProvider).invalidateEmail(),
                  ),
                ActionButton(
                  buttonText: 'Update profile',
                  showLoading: _isBusy.value,
                  onPressed: () async {
                    _focusNode.unfocus();
                    if (_aboutMeController.text != _currentUser.aboutMe) {
                      await context.read(_profileScreenProvider).update(
                            aboutMe: _aboutMeController.text,
                          );
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nothing to update'),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
