import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/widgets/error_state_widget.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/core/widgets/state_switcher_widget.dart';
import 'package:tribeseed/features/auth/auth_type.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/core/widgets/form_input_widget.dart';
import 'package:tribeseed/features/auth/widgets/auth_form/auth_form_providers.dart';
import 'package:tribeseed/features/auth/widgets/auth_form/auth_form_viewmodel.dart';

class AuthFormWidget extends ConsumerWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authState = watch(authViewModelProvider.state);
    final authType = watch(authTypeProvider).state;
    final formKey = watch(authFormKeyProvider);
    final formTitle = authType == AuthType.signIn
        ? TextContants.authSignInTitle
        : TextContants.authSignUpTitle;
    final buttonText = authType == AuthType.signIn
        ? TextContants.authSignUpTitle
        : TextContants.authSignInTitle;

    return StateSwitcherWidget(
      builder: (context) {
        if (authState is AuthFormLoadingState) {
          return const LoadingStateWidget();
        } else if (authState is AuthFormErrorState) {
          return ErrorStateWidget(
            errorMessage: authState.errorMessage,
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      /// TODO: Replace this with the proper logo.
                      const FlutterLogo(
                        size: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(formTitle),
                    ],
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormInputWidget(
                          key: const ValueKey<String>('AuthFullNameField'),
                          labelText: TextContants.authFullnameLabel,
                          helperText: TextContants.authFullnameDescription,
                          showInput: authType != AuthType.signIn,
                          validator: (value) => FormValidation.validate(
                            fieldValidators: [
                              FieldValidators.required(),
                            ],
                            fieldValue: value,
                          ),
                        ),
                        FormInputWidget(
                          key: const ValueKey<String>('AuthEmailField'),
                          labelText: TextContants.authEmailLabel,
                          helperText: TextContants.authEmailDescription,
                          validator: (value) => FormValidation.validate(
                            fieldValidators: [
                              FieldValidators.required(),
                              FieldValidators.email(),
                            ],
                            fieldValue: value,
                          ),
                        ),
                        FormInputWidget(
                          key: const ValueKey<String>('AuthPasswordField'),
                          labelText: TextContants.authPasswordLabel,
                          helperText: TextContants.authPasswordDescription,
                          isPassword: true,
                          validator: (value) => FormValidation.validate(
                            fieldValidators: [
                              FieldValidators.password(),
                            ],
                            fieldValue: value,
                          ),
                        ),
                        RaisedButton(
                          key: const ValueKey<String>('AuthActionButton'),
                          onPressed: () {
                            print(
                              'Form Validity ${formKey.currentState.validate()}',
                            );
                            context.read(authViewModelProvider).authenticate(
                                  email: emailController.value.text,
                                  password: passwordController.value.text,
                                  authType: authType,
                                );
                          },
                          child: Text(formTitle),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: RaisedButton(
                            key: ValueKey<String>(buttonText),
                            onPressed: () {
                              if (authType == AuthType.signIn) {
                                context.read(authTypeProvider).state =
                                    AuthType.signUp;
                                return;
                              }
                              context.read(authTypeProvider).state =
                                  AuthType.signIn;
                            },
                            child: Text(
                              '$buttonText instead',
                              key: const ValueKey<String>('AuthTypeText'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
