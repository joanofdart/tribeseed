import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tribeseed/app/widgets/auth_button.dart';
import 'package:tribeseed/app/widgets/form_input.dart';
import 'package:tribeseed/app/widgets/text_logo.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'auth_screen_model.dart';
import 'widgets/or_divider.dart';
import 'widgets/social_auth_button.dart';

final _authScreenModelProvider = StateNotifierProvider<AuthScreenModel>(
  (ref) {
    final authenticationService = ref.watch(authenticationServiceProvider);
    return AuthScreenModel(authenticationService);
  },
);

class AuthScreen extends HookWidget {
  AuthScreen({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _fullNameController = useTextEditingController();
    final _emailController = useTextEditingController();
    final _passwordController = useTextEditingController();

    final _isSignIn = useState(true);
    final _isBusy = useState(false);

    return Scaffold(
      /// Set up loading state and error feedback
      ///
      body: ProviderListener<AsyncValue<bool>>(
        provider: _authScreenModelProvider.state,
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
            data: (value) => _isBusy.value = false,
          );
        },

        /// View body
        ///
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextLogo(),
                  ),
                  if (kDebugMode)
                    RaisedButton(
                      onPressed: () {
                        _fullNameController.text = 'John Doe';
                        _emailController.text = 'some.mail@mail.com';
                        _passwordController.text = '12345678';
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      color: Colors.indigo,
                      child: Text(
                        'Fill',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    onPressed: () {
                      _isSignIn.value = !_isSignIn.value;
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    color: Colors.grey[900],
                    splashColor: Colors.blue,
                    textColor: Colors.blue,
                    child: Text(
                      _isSignIn.value ? 'sign up' : 'sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFeatures: const [
                          FontFeature.enable('smcp'),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _isSignIn.value ? 'Sign in' : 'Sign up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormInput(
                      labelText: 'Full name',
                      controller: _fullNameController,
                      showInput: !_isSignIn.value,
                      validator: (value) => FormValidation.validate(
                        fieldValidators: [
                          FieldValidators.required(),
                          FieldValidators.min(3)
                        ],
                        fieldValue: value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInput(
                      key: const ValueKey<String>('AuthEmailField'),
                      labelText: 'Email',
                      controller: _emailController,
                      validator: (value) => FormValidation.validate(
                        fieldValidators: [
                          FieldValidators.required(),
                          FieldValidators.email(),
                        ],
                        fieldValue: value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormInput(
                      key: const ValueKey<String>('AuthPasswordField'),
                      labelText: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) => FormValidation.validate(
                        fieldValidators: [
                          FieldValidators.required(),
                        ],
                        fieldValue: value,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        key: const ValueKey<String>('ContinueButton'),
                        buttonText: 'Continue',
                        showLoading: _isBusy.value,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context.read(_authScreenModelProvider).authenticate(
                                  displayName: _fullNameController.value.text,
                                  email: _emailController.value.text,
                                  password: _passwordController.value.text,
                                  authType: _isSignIn.value
                                      ? AuthType.signIn
                                      : AuthType.signUp,
                                );
                          }
                        },
                      ),
                    ),
                    OrDivider(),
                    SizedBox(
                      width: double.infinity,
                      child: SocialAuthButton(
                        assetImagePath: 'assets/branding/google.png',
                        semanticLabel: 'Google Auth Button',
                        buttonText: 'sign in with google',
                        showLoading: _isBusy.value,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
