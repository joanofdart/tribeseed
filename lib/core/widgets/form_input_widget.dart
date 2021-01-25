import 'package:flutter/material.dart';

class FormInputWidget extends StatelessWidget {
  final String labelText;
  final String helperText;
  final bool isPassword;
  final bool showInput;
  final String Function(String) validator;
  final TextEditingController controller;

  const FormInputWidget({
    Key key,
    this.showInput = true,
    this.labelText,
    this.helperText,
    this.isPassword = false,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
