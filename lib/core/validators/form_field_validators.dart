import 'validation_error_strings.dart';

abstract final class FormFieldValidators {
  static String? emailValidator(String? email) {
    if (email == null) return null;
    email = email.trim();
    if (email.isEmpty) {
      return ValidatorsErrorStrings.emptyError;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email)) {
      return ValidatorsErrorStrings.invalidEmail;
    }
    return null;
  }

  static String? numberValidator(String? number) {
    if (number == null) return null;
    number = number.trim();
    if (number.isEmpty) {
      return ValidatorsErrorStrings.emptyError;
    } else {
      try {
        int.parse(number);
      } on FormatException {
        return ValidatorsErrorStrings.invalidNumber;
      }
    }

    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null) return null;
    if (name.isEmpty) {
      return ValidatorsErrorStrings.emptyError;
    }
    return null;
  }

  static String? emptyValidator(String? name) {
    if (name == null) return null;
    if (name.isEmpty) {
      return ValidatorsErrorStrings.emptyError;
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null) return null;
    password = password.trim();
    if (password.isEmpty) {
      return ValidatorsErrorStrings.emptyError;
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$')
        .hasMatch(password)) {
      return ValidatorsErrorStrings.invalidPassword;
    }
    return null;
  }
}
