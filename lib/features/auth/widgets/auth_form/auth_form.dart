import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribeseed/core/enums/auth_type.dart';
import 'package:tribeseed/core/widgets/loading_state.widget.dart';
import 'package:tribeseed/core/mixins/text_constants.dart';
import 'package:tribeseed/core/validation/form_validation.dart';
import 'package:tribeseed/core/widgets/form_input_widget.dart';

import 'auth_form_providers.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({Key key}) : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  AuthType _authType;
  GlobalKey<FormState> _formKey;

  TextEditingController _fullNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  String _title;
  String _btnText;

  @override
  void initState() {
    super.initState();
    _authType = AuthType.signIn;
    _formKey = GlobalKey<FormState>();

    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _title = TextContants.authSignInTitle;
    _btnText = TextContants.authSignUpTitle;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final viewModel = watch(authViewModelProvider.state);

        final isLoading = viewModel.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        /// TODO: Check if there's a better way to manage an error state.
        viewModel.maybeWhen(
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
          key: widget.key,
          bottomNavigationBar: kDebugMode
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    key: const ValueKey<String>('AuthFillDebugData'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    color: Colors.red[400],
                    onPressed: () {
                      /// TODO: Move this outside.
                      setState(() {
                        _fullNameController.text = 'John Doe';
                        _emailController.text = 'john@doe.com';
                        _passwordController.text = '!Mn34mk983sX';
                      });
                    },
                    child: const Text(
                      'Fill Debug Data',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                )
              : null,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// TODO: Replace this with the proper logo.
                const FlutterLogo(
                  size: 150,
                ),
                _buildForm(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Form _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(_title),
          FormInputWidget(
            key: const ValueKey<String>('AuthFullNameField'),
            labelText: TextContants.authFullnameLabel,
            helperText: TextContants.authFullnameDescription,
            controller: _fullNameController,
            showInput: _authType != AuthType.signIn,
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
            controller: _emailController,
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
            controller: _passwordController,
            isPassword: true,
            validator: (value) => FormValidation.validate(
              fieldValidators: [
                FieldValidators.password(),
              ],
              fieldValue: value,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RaisedButton(
            key: const ValueKey<String>('AuthActionButton'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                context.read(authViewModelProvider).authenticate(
                      displayName: _fullNameController.value.text,
                      email: _emailController.value.text,
                      password: _passwordController.value.text,
                      authType: _authType,
                    );
              }
            },
            child: Text(_btnText),
          ),
          RaisedButton(
            key: ValueKey<String>(_btnText),
            onPressed: () {
              if (_authType == AuthType.signIn) {
                setState(() {
                  _authType = AuthType.signUp;
                  _title = TextContants.authSignUpTitle;
                  _btnText = TextContants.authSignInTitle;
                });
              } else {
                setState(() {
                  _authType = AuthType.signIn;
                  _title = TextContants.authSignInTitle;
                  _btnText = TextContants.authSignUpTitle;
                });
              }
            },
            child: Text(
              '$_btnText instead!',
              key: const ValueKey<String>('AuthTypeText'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
