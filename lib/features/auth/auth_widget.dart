import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/base/base_widget.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/features/auth/auth_providers.dart';
import 'package:tribeseed/services/authentication/authentication_service_providers.dart';

import 'auth_viewmodel.dart';

class AuthWidget extends ConsumerWidget with TextContants {
  final WidgetBuilder signedIn;

  AuthWidget({
    Key key,
    this.signedIn,
  }) : super(key: key);

  Widget _switchForms({
    BuildContext context,
    AuthType authType,
    String buttonText,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: RaisedButton(
        key: ValueKey<String>(buttonText),
        onPressed: () {
          if (authType == AuthType.signIn) {
            context.read(authTypeProvider).state = AuthType.signUp;
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
    );
  }

  Widget _buildInput({
    String labelText,
    String helperText,
    Key key,
    bool isPassword = false,
    bool showInput = true,
    TextEditingController controller,
    String Function(String) validator,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: showInput
          ? TextFormField(
              key: key,
              decoration: InputDecoration(
                labelText: labelText,
                helperText: helperText,
              ),
              obscureText: isPassword,
              validator: validator,
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )
          : const SizedBox(),
    );
  }

  Widget _buildHeader({
    String formTitle,
  }) {
    return Column(
      children: [
        const FlutterLogo(
          size: 150,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(formTitle),
      ],
    );
  }

  Widget _buildForm({
    BuildContext context,
    GlobalKey<FormState> formKey,
    String formTitle,
    AuthType authType,
    String buttonText,
    TextEditingController fullNameController,
    TextEditingController emailController,
    TextEditingController passwordController,
  }) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _buildInput(
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
          _buildInput(
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
          _buildInput(
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
              print(formKey.currentState.validate());
              context.read(authViewModelProvider).authenticate(
                    email: emailController.value.text,
                    password: passwordController.value.text,
                    authType: authType,
                  );
            },
            child: Text(formTitle),
          ),
          _switchForms(
            context: context,
            authType: authType,
            buttonText: buttonText,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthWidget(
    BuildContext context,
    ScopedReader watch,
  ) {
    final authState = watch(authViewModelProvider.state);
    final authType = watch(authTypeProvider).state;
    final formKey = watch(authFormKeyProvider);
    final formTitle = authType == AuthType.signIn
        ? TextContants.authSignInTitle
        : TextContants.authSignUpTitle;
    final buttonText = authType == AuthType.signIn
        ? TextContants.authSignUpTitle
        : TextContants.authSignInTitle;

    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    if (authState is AuthLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (authState is AuthErrorState) {
      return Center(
        child: Text(authState.message),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildHeader(
                formTitle: formTitle,
              ),
              _buildForm(
                context: context,
                formKey: formKey,
                formTitle: formTitle,
                authType: authType,
                buttonText: buttonText,
                fullNameController: fullNameController,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(currentUserProvider).state;

    print(
      'Current user ${currentUser?.displayName} -  ${currentUser?.emailVerified}',
    );

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
      child: currentUser != null
          ? signedIn(context)
          : BaseWidget(
              child: _buildAuthWidget(context, watch),
            ),
    );
  }
}
