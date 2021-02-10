import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/core/widgets/form_input_widget.dart';

import 'auth_form_providers.dart';

class AuthFormWidget extends ConsumerWidget {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthFormWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final model = watch(authViewModelProvider.state);
    final authType = watch(authTypeProvider).state;
    final formKey = watch(authFormKeyProvider);
    final formTitle = authType == AuthType.signIn
        ? TextContants.authSignInTitle
        : TextContants.authSignUpTitle;
    final buttonText = authType == AuthType.signIn
        ? TextContants.authSignUpTitle
        : TextContants.authSignInTitle;

    final isLoading = model.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    /// TODO: Check if there's a better way to manage an error state.
    model.maybeWhen(
      error: (error, stackTrace) {
        print('Error $error');
        print('Stacktrace $stackTrace');

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Auth form Error ${timeStamp.inSeconds}'),
            ),
          );
        });
      },
      orElse: () => null,
    );

    if (isLoading) {
      return const LoadingStateWidget();
    }

    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// TODO: Replace this with the proper logo.
            const FlutterLogo(
              size: 150,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Text(formTitle),
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
                      if (!formKey.currentState.validate()) {}

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
                  const SizedBox(
                    height: 25,
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
                        context.read(authTypeProvider).state = AuthType.signIn;
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
}
