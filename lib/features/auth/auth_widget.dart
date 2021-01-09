import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:tribeseed/core/base/base_widget.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/features/auth/auth_providers.dart';
import 'package:tribeseed/features/features_providers.dart';

class AuthWidget extends StatelessWidget with TextContants {
  final WidgetBuilder signedIn;

  AuthWidget({
    Key key,
    this.signedIn,
  }) : super(key: key);

  Widget _switchForms({
    BuildContext context,
    bool isSignInForm,
    String title,
  }) {
    return Column(
      children: [
        Switch(
          value: isSignInForm,
          onChanged: (_) {
            context.read(authFormSwitchProvider).state = !isSignInForm;
          },
        ),
        Text('$title instead', textAlign: TextAlign.center)
      ],
    );
  }

  Widget _buildInput({
    String labelText,
    String helperText,
    bool isPassword = false,
    bool showInput = true,
    String Function(String) validator,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: showInput
          ? TextFormField(
              decoration: InputDecoration(
                labelText: labelText,
                helperText: helperText,
              ),
              obscureText: isPassword,
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )
          : const SizedBox(),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final isSignInForm = watch(authFormSwitchProvider).state;
        final formKey = watch(authFormKeyProvider);
        final formTitle = isSignInForm
            ? TextContants.authSignInTitle
            : TextContants.authSignUpTitle;

        return Form(
          key: formKey,
          child: Column(
            children: [
              Text(formTitle),
              _buildInput(
                labelText: TextContants.authFullnameLabel,
                helperText: TextContants.authFullnameDescription,
                showInput: !isSignInForm,
              ),
              _buildInput(
                labelText: TextContants.authEmailLabel,
                helperText: TextContants.authEmailDescription,
                validator: (value) => FormValidation.validate(
                  fieldValidators: [
                    FieldValidators.required(),
                    FieldValidators.min(100),
                  ],
                  fieldValue: value,
                ),
              ),
              _buildInput(
                labelText: TextContants.authPasswordLabel,
                helperText: TextContants.authPasswordDescription,
                isPassword: true,
              ),
              RaisedButton(
                onPressed: () {
                  print(formKey.currentState.validate());
                  // context.read(authStateChangesProviderMock).state = true;
                },
                child: Text(formTitle),
              ),
              _switchForms(
                context: context,
                isSignInForm: isSignInForm,
                title: formTitle,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAuthWidget(BuildContext context) {
    return BaseWidget(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),

        /// TODO: Styling
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final authState = watch(authStateChangesProviderMock).state;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: authState ? signedIn(context) : _buildAuthWidget(context),
        );
      },
    );
  }
}
