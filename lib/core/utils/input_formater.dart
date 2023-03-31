import 'package:flutter/services.dart';

import '../../data/constants/enums.dart';

abstract class InputFormoter {
  static TextInputFormatter get cardNumberFormater => _CardNumberFormatter();
  static TextInputFormatter get cardDateFormater => _CardDateFormatter();
  static TextInputFormatter get upperCaseFormater => _UpperCaseTextFormatter();

  static String? nameValidation(String? name) {
    if ((name?.length ?? 0) < 3) {
      return "Invalid Name";
    }
  }

  static String? numberValidation(String? number) {
    number = number?.replaceAll(" ", "");

    CardType type = cardChecker(number ?? "");

    if (type == CardType.none) {
      return "Invalid Card Number";
    }

    if ((number?.length ?? 0) < 16) {
      return "Invalid Card Number";
    }
  }

  static String? dateValidation(String? date) {
    if (date == null) return null;

    String invalid = "Invalid Date";

    List<String> list = date.split("/");

    String month = list.first;
    String year = list.last;

    try {
      int _month = int.parse(month);
      int _year = int.parse(year);

      if (_month > 12) {
        return invalid;
      }

      if (_year < 23) {
        return invalid;
      }
    } catch (e) {
      return invalid;
    }
  }

  static CardType cardChecker(String value) {
    if (value.startsWith("50") ||
        value.startsWith("51") ||
        value.startsWith("52") ||
        value.startsWith("53") ||
        value.startsWith("54") ||
        value.startsWith("55")) {
      return CardType.mastercard;
    }

    if (value.startsWith("8600")) {
      return CardType.uzcard;
    }

    if (value.startsWith("9860")) {
      return CardType.xumo;
    }

    return CardType.none;
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class _CardDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue == 2 && nonZeroIndexValue != inputText.length) {
        bufferString.write('/');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
