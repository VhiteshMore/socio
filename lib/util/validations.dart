
import 'package:socio/constant/app_string_constants.dart';

class ValidationError {
  final int? errorCode;
  final String? errorMessage;

  const ValidationError({this.errorCode, this.errorMessage});
}

typedef Validator = ValidationError? Function();

class Validation {
  List<Validator> _validators = [];

  Validation addValidator(Validator validator) {
    _validators.add(validator);
    return this;
  }

  ValidationError? doValidation() {
    ValidationError? error;
    for (Validator validator in _validators) {
      error = validator();
      if (error != null) {
        break;
      }
    }
    return error;
  }

  Validation isTextNotEmpty(
      String? text, {
        ValidationError error = const ValidationError(errorMessage: "Text must not be empty"),
      }) {
    return addValidator(() {
      if (text == null || text.isEmpty) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isTextOnlySpace(
      String? text, {
        ValidationError error = const ValidationError(errorMessage: "Text must not be empty"),
      }) {
    return addValidator(() {
      if (text == null || text.isEmpty) {
        return error;
      } else if (text.trim().isEmpty) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueNotEmpty(
      String? text, {
        ValidationError error = const ValidationError(errorMessage: "Text must not be empty"),
      }) {
    return addValidator(() {
      if (text == null || text.isEmpty) {
        return error;
      } else {
        try {
          num.parse(text);
          // etc.
          return null;
        } on FormatException {
          // etc.
          return error;
        }
      }
    });
  }

  Validation isValidEmail(
      String? email, {
        ValidationError error = const ValidationError(errorMessage: "Email must not be empty"),
      }) {
    return addValidator(() {
      if (email == null || email.isEmpty) {
        return error;
      } else if (!RegExp(AppStringConstants.emailPattern).hasMatch(email)) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValidDigit(
      String text, {
        ValidationError error = const ValidationError(errorMessage: "Not Valid Number"),
      }) {
    return addValidator(() {
      try {
        int.parse(text);
        // etc.
        return null;
      } on FormatException {
        // etc.
        return error;
      }
    });
  }

  Validation isValidNumber(
      String text, {
        ValidationError error = const ValidationError(errorMessage: "Not Valid Number"),
      }) {
    return addValidator(() {
      try {
        double.parse(text);
        // etc.
        return null;
      } on FormatException {
        // etc.
        return error;
      }
    });
  }

  Validation isTextLengthLessThan(
      String? text,
      int? length, {
        ValidationError error = const ValidationError(errorMessage: "Text length must be less than given length"),
      }) {
    return addValidator(() {
      if (length == null || length <= 0 || text == null) {
        return null;
      }

      if (text.length > length) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isTextLengthGreaterThan(
      String text,
      int? length, {
        ValidationError error = const ValidationError(errorMessage: "Text length must be greater than given length"),
      }) {
    return addValidator(() {
      if (length != null && text.length < length) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isTextLengthBetween(
      String text,
      int lowerLength,
      int upperLength, {
        ValidationError error = const ValidationError(errorMessage: "Text length must be between given length"),
      }) {
    return isTextLengthLessThan(text, upperLength, error: error).isTextLengthGreaterThan(text, lowerLength, error: error);
  }

  Validation isTextSame(
      String text,
      String text2, {
        ValidationError error = const ValidationError(errorMessage: "Text not match"),
      }) {
    return addValidator(() {
      if (text != text2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isBothTextSame(
      String text,
      String text2, {
        ValidationError error = const ValidationError(errorMessage: "Both text match"),
      }) {
    return addValidator(() {
      if (text == text2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isTextPresentInList(
      String selectedObject, List<String> objectList, {
        ValidationError error = const ValidationError(errorMessage: "Both options match"),
      }) {
    return addValidator(() {
      bool isPresent = false;
      for (var element in objectList) {
        isPresent = isPresent && (element == selectedObject);
      }
      if (isPresent) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueSame(
      int text,
      int text2, {
        ValidationError error = const ValidationError(errorMessage: "Value not match"),
      }) {
    return addValidator(() {
      if (text == text2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueGreaterThan(int value1, int value2, {ValidationError error = const ValidationError(errorMessage: "Value not must be greater than given value")}) {
    return addValidator(() {
      if (value1 > value2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueLessThan(int value1, int value2, {ValidationError error = const ValidationError(errorMessage: "Value not must be less than given value")}) {
    return addValidator(() {
      if (value1 < value2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isFloatingValueGreaterThan(double value1, double value2, {ValidationError error = const ValidationError(errorMessage: "Value not must be greater than given value")}) {
    return addValidator(() {
      if (value1 > value2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isFloatingValueLessThan(double value1, double value2, {ValidationError error = const ValidationError(errorMessage: "Value not must be less than given value")}) {
    return addValidator(() {
      if (value1 < value2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueLessThanOrEqual(int value1, int? value2, {ValidationError error = const ValidationError(errorMessage: "Value not must be less than given value")}) {
    return addValidator(() {
      if (value2 != null && value1 <= value2) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isEvenNumber(
      int number, {
        ValidationError error = const ValidationError(errorMessage: "Number is not even"),
      }) {
    return addValidator(() {
      if (number % 2 != 0) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isValueMultipleOf(
      int number,
      int multipleValue, {
        ValidationError error = const ValidationError(errorMessage: "Number is not multiple of value"),
      }) {
    return addValidator(() {
      if (number % multipleValue != 0) {
        return error;
      } else {
        return null;
      }
    });
  }

  Validation isNumberInRange(
      int? number,
      int lowerLimit,
      int upperLimit, {
        ValidationError error = const ValidationError(errorMessage: "Not Valid Number"),
      }) {
    return addValidator(() {
      if (number != null && number >= lowerLimit && number <= upperLimit) {
        return null;
      } else {
        return error;
      }
    });
  }

  static bool emailValidation(value) =>
      RegExp(AppStringConstants.emailPattern).hasMatch(value);
}
