import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FormInput extends HookWidget {
  final bool isPassword;
  final bool showInput;
  final Icon prefixIcon;
  final Icon suffix;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final InputBorder border;
  final FocusNode focusNode;
  final String labelText;
  final String helperText;
  final String Function(String) validator;
  final TextEditingController controller;

  const FormInput({
    Key key,
    this.showInput = true,
    this.isPassword = false,
    this.prefixIcon,
    this.suffix,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.focusNode,
    this.labelText,
    this.helperText,
    this.border,
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
              focusNode: focusNode,
              keyboardType: TextInputType.multiline,
              maxLength: maxLength,
              minLines: minLines,
              maxLines: isPassword ? 1 : maxLines,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffix: suffix,
                labelText: labelText,
                helperText: helperText,
                border: border,
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
