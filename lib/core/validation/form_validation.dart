import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

class FieldValidators {
  FieldValidators._();

  static String Function(String, BuildContext) required() {
    return (fieldValue, context) {
      if (fieldValue == null ||
          ((fieldValue is Iterable ||
                  fieldValue is Map ||
                  fieldValue is String) &&
              fieldValue.isEmpty)) {
        return 'Required.';
      }
      return null;
    };
  }

  static String Function(String, BuildContext) email() {
    return (fieldValue, context) {
      if (!fieldValue.isEmail()) {
        return 'Email badly formatted.';
      }
      return null;
    };
  }

  static String Function(String, BuildContext) max(int amount) {
    return (fieldValue, context) {
      if (fieldValue.length > amount) {
        return 'Max value of $amount characters exceeded.';
      }
      return null;
    };
  }

  static String Function(String, BuildContext) min(int amount) {
    return (fieldValue, context) {
      if (fieldValue.length < amount) {
        return 'Min value of $amount characters expected.';
      }
      return null;
    };
  }

  static String Function(String, BuildContext) password() {
    return (fieldValue, context) {
      if (!fieldValue.isPasswordNormal3()) {
        return 'Complex password required.';
      }
      return null;
    };
  }
}

class FormValidation {
  FormValidation._();

  static String validate({
    BuildContext context,
    String fieldValue,
    List<String Function(String, BuildContext)> fieldValidators,
  }) {
    for (final validator in fieldValidators) {
      final validationResult = validator(fieldValue, context);
      if (validationResult != null) {
        return validationResult;
      }
    }
    return null;
  }
}
