class Converter {
  static int hexToDec(String hexColor) {
    if (!_isValidHexadecimal(hexColor)) {
      throw ArgumentError('Invalid hexadecimal string');
    }

    int len = hexColor.length;
    int base = 1;
    int decVal = 0;

    for (int i = len - 1; i >= 0; i--) {
      int charCode = hexColor.codeUnitAt(i);
      if (charCode >= 48 && charCode <= 57) {
        decVal += (charCode - 48) * base;
        base = base * 16;
        //UPPERCASE 'A'-'F'
      } else if (charCode >= 65 && charCode <= 70) {
        decVal += (charCode - 55) * base;
        base = base * 16;
        //lowercase 'a'-'f'
      } else if (charCode >= 97 && charCode <= 102) {
        decVal += (charCode - 87) * base;
        base = base * 16;
      }
    }
    return decVal;
  }
}

bool _isValidHexadecimal(String hexVal) {
  for (int i = 0; i < hexVal.length; i++) {
    int charCode = hexVal.codeUnitAt(i);
    if (!(charCode >= 48 && charCode <= 57) && // '0'-'9'
        !(charCode >= 65 && charCode <= 70) && // 'A'-'F'
        !(charCode >= 97 && charCode <= 102)) {
      // 'a'-'f'
      return false;
    }
  }
  return true;
}

String removeEscapedANSI(String input) {
  // Define regex patterns to match escape sequences of the forms \x1B[...m and \x1B]8;;...url...\x1B\...text...\x1B]8;;\x1B\
  final regexAnsi = RegExp(r'\x1B\[.*?m');
  final regexUrl = RegExp(r'\x1B]8;;.*?\x1B\\.*?\x1B]8;;\x1B\\');

  // Remove all escape sequences from the input
  String cleanedInput = input.replaceAll(regexAnsi, '');
  cleanedInput = cleanedInput.replaceAllMapped(regexUrl, (match) {
    String urlPart = match.group(0) ?? '';
    String linkText = '';
    final innerMatch = RegExp(r'\x1B\\(.*?)\x1B]8;;\x1B\\').firstMatch(urlPart);
    if (innerMatch != null) {
      linkText = innerMatch.group(1) ?? '';
    }
    return linkText;
  });

  // Return the cleaned input
  return cleanedInput;
}

String elapsedToHMS(Duration elapsed) {
  final hours = elapsed.inHours;
  final minutes = elapsed.inMinutes.remainder(60);
  final seconds = elapsed.inSeconds.remainder(60);
  final milliseconds = elapsed.inMilliseconds.remainder(1000);

  return '⏱️  Tempo decorrido: ${hours}h ${minutes}m ${seconds}s ${milliseconds}ms\n\n';
}
