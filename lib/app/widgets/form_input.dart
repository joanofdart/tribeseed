import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormInput extends HookWidget {
  final String labelText;
  final String helperText;
  final bool isPassword;
  final bool showInput;
  final String Function(String) validator;
  final TextEditingController controller;

  const FormInput({
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
    final _obfuscate = useState(isPassword);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: showInput
          ? TextFormField(
              key: key,
              decoration: InputDecoration(
                labelText: labelText,
                helperText: helperText,
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _obfuscate.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          _obfuscate.value = !_obfuscate.value;
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
              ),
              obscureText: _obfuscate.value,
              validator: validator,
              controller: controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )
          : const SizedBox(),
    );
  }
}
