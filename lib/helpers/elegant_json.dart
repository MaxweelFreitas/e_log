import 'dart:convert';

class ElegantJson {
  static String print({
    required String jsonString,
    required int lineLength,
    String divider = '|',
    String dividerColor = '\x1B[37m',
    String bracketColor = '\x1b[37m', // ANSI color code for blue
    String keyColor = '\x1b[37m', // ANSI color code for yellow
    String valueColor = '\x1b[37m', // ANSI color code for green
  }) {
    try {
      // Parse the JSON string into a Map
      Map<String, dynamic> json = jsonDecode(jsonString);

      // Convert the JSON map to a formatted string
      String formattedJson = const JsonEncoder.withIndent('  ').convert(json);

      // Split the formatted JSON string into individual lines
      List<String> jsonLines = formattedJson.split('\n');

      // Color the dividers
      String coloredDivider = '$dividerColor$divider';

      // Build the final output
      StringBuffer output = StringBuffer();
      for (String line in jsonLines) {
        output.writeln(_formatLine(
          _colorizeLine(line, bracketColor, keyColor, valueColor),
          coloredDivider,
          lineLength,
        ));
      }

      return output.toString();
    } on Exception catch (e) {
      return 'Invalid JSON: $e';
    }
  }

  // Helper method to colorize a line of JSON text
  static String _colorizeLine(
    String line,
    String bracketColor,
    String keyColor,
    String valueColor,
  ) {
    // Color brackets
    line = _replaceWithColor(line, r'[\[\]{}]', (match) {
      return '$bracketColor${match[0]}';
    });

    // Color keys and their surrounding quotes
    line = _replaceWithColor(line, r'\"(.*?)\"(?=\s*:)', (match) {
      return '$keyColor"${match[1]}"';
    });

    // Color colons (:) separately
    line = _replaceWithColor(line, r':', (match) {
      return '$bracketColor:';
    });

    // Color values (strings, numbers, booleans, null, arrays, and objects)
    line = _replaceWithColor(
        line, r'(?<=: )(?:"[^"]*"|\d+|true|false|null|\[[^\]]*\]|\{[^}]*\})',
        (match) {
      final value = match.group(0)?.trim() ?? '';
      return '$valueColor$value';
    });

    return line + reset;
  }

  // Helper method to replace parts of the line with colored segments
  static String _replaceWithColor(
    String line,
    String pattern,
    String Function(Match) replacer,
  ) {
    final regex = RegExp(pattern, multiLine: true);
    return line.replaceAllMapped(regex, replacer);
  }

  // Helper method to format a line with the dividers and padding
  static String _formatLine(String text, String divider, int lineLength) {
    // Subtract - 2 for the dividers - 2 for default spaces between dividers and content
    String paddedText = _padRight(text, lineLength - 4);
    return '$divider $paddedText $divider';
  }

  // Helper method to pad the right side of the line with spaces
  static String _padRight(String text, int width) {
    // Remove ANSI escape codes from the length calculation
    final cleanText = text.replaceAll(RegExp(r'\x1B\[[0-9;]*[mK]'), '');
    int padding = width - cleanText.length;
    return text + ' ' * padding;
  }

  // Reset color code for after the value
  static const String reset = '\x1B[0m';
}
