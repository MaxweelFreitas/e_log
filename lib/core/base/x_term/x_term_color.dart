library;
// ignore_for_file: unintended_html_in_doc_comment
///## XTermColor
///### Autor: Maxweel Freitas
///
///
/// ```dart
/// [XTermColor]
/// ```
/// The class provides a comprehensive set of named colors in the xterm-256color
/// palette and utility methods to convert RGB and HEX colors into ANSI escape
/// sequences for coloring text in terminals.
///
/// ### Usage
/// This is a sample how to use the class:
///
/// ```dart
/// print('${XTermColor.main}Hello World!${XTermColor.reset}')
/// ```

class XTermColor {
  /// ForegroundColors

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Default elegant foreground colors codes
  ///────────────────────────────────────────────────────────────────────────────────
  /// Represents the ANSI escape sequence for the foreground color  bright orang.
  static const main = '\x1B[38;2;255;165;0m';

  /// Represents the ANSI escape sequence for the foreground color orangeRed.
  static const orangeRed = '\x1B[38;2;255;135;0m';

  /// Represents the ANSI escape sequence for the foreground color limeGreen.
  static const limeGreen = '\x1B[38;2;50;205;50m';

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Default foreground colors codes
  ///────────────────────────────────────────────────────────────────────────────────
  /// Represents the ANSI escape sequence for the foreground color black.
  static const black = '\x1B[30m';

  /// Represents the ANSI escape sequence for the foreground color red.
  static const red = '\x1B[31m';

  /// Represents the ANSI escape sequence for the foreground color green.
  static const green = '\x1B[32m';

  /// Represents the ANSI escape sequence for the foreground color yellow.
  static const yellow = '\x1B[33m';

  /// Represents the ANSI escape sequence for the foreground color blue.
  static const blue = '\x1B[34m';

  /// Represents the ANSI escape sequence for the foreground color magenta.
  static const magenta = '\x1B[35m';

  /// Represents the ANSI escape sequence for the foreground color cyan.
  static const cyan = '\x1B[36m';

  /// Represents the ANSI escape sequence for the foreground color white.
  static const white = '\x1B[37m';

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Default Bright foreground colors codes
  ///────────────────────────────────────────────────────────────────────────────────
  /// Represents the ANSI escape sequence for the foreground color bright black.
  static const blackBright = '\x1B[90m';

  /// Represents the ANSI escape sequence for the foreground color bright red.
  static const redBright = '\x1B[91m';

  /// Represents the ANSI escape sequence for the foreground color bright green.
  static const greenBright = '\x1B[92m';

  /// Represents the ANSI escape sequence for the foreground color bright yellow.
  static const yellowBright = '\x1B[93m';

  /// Represents the ANSI escape sequence for the foreground color bright blue.
  static const blueBright = '\x1B[94m';

  /// Represents the ANSI escape sequence for the foreground color bright magenta.
  static const magentaBright = '\x1B[95m';

  /// Represents the ANSI escape sequence for the foreground color bright cyan. -> \x1B[38;2;0;255;255m
  static const cyanBright = '\x1B[96m';

  /// Represents the ANSI escape sequence for the foreground color bright white.
  static const whiteBright = '\x1B[97m';

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Default BackgroundColors colors codes
  ///────────────────────────────────────────────────────────────────────────────────
  /// Represents the ANSI escape sequence for the background color black.
  static const blackBg = '\x1B[40m';

  /// Represents the ANSI escape sequence for the background color red.
  static const redBg = '\x1B[41m';

  /// Represents the ANSI escape sequence for the background color green.
  static const greenBg = '\x1B[42m';

  /// Represents the ANSI escape sequence for the background color yellow.
  static const yellowBg = '\x1B[43m';

  /// Represents the ANSI escape sequence for the background color blue.
  static const blueBg = '\x1B[44m';

  /// Represents the ANSI escape sequence for the background color magenta.
  static const magentaBg = '\x1B[45m';

  /// Represents the ANSI escape sequence for the background color cyan.
  static const cyanBg = '\x1B[46m';

  /// Represents the ANSI escape sequence for the background color white.
  static const whiteBg = '\x1B[47m';

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Default Bright BackgroundColors colors codes
  ///────────────────────────────────────────────────────────────────────────────────
  /// Represents the ANSI escape sequence for the background color bright black.
  static const blackBrightBg = '\x1B[100m';

  /// Represents the ANSI escape sequence for the background color bright red.
  static const redBrightBg = '\x1B[101m';

  /// Represents the ANSI escape sequence for the background color bright green.
  static const greenBrightBg = '\x1B[102m';

  /// Represents the ANSI escape sequence for the background color bright yellow.
  static const yellowBrightBg = '\x1B[103m';

  /// Represents the ANSI escape sequence for the background color bright blue.
  static const blueBrightBg = '\x1B[104m';

  /// Represents the ANSI escape sequence for the background color bright magenta.
  static const magentaBrightBg = '\x1B[105m';

  /// Represents the ANSI escape sequence for the background color bright cyan.
  static const cyanBrightBg = '\x1B[106m';

  /// Represents the ANSI escape sequence for the background color bright white.
  static const whiteBrightBg = '\x1B[107m';

  /// Represents the ANSI escape sequence for reset colors.
  static const reset = '\x1B[0m';

  ///────────────────────────────────────────────────────────────────────────────────
  ///🔹  Converter colors functions
  ///────────────────────────────────────────────────────────────────────────────────
  /// Converts a color code from the xterm-256color palette to a foreground ANSI escape sequence.
  ///
  /// [codeColor] - The color code (0-255) from the xterm-256color palette.
  /// Returns a string representing the ANSI escape sequence for the specified foreground color.
  /// Like this:
  ///
  /// \x1B[38;5;<FG COLOR>m
  ///
  static String std256FG(int codeColor) {
    if (codeColor < 0) {
      return 'std256FG color is invalid! [needs to be Grater and then 0]';
    } else if (codeColor > 255) {
      return 'std256FG color is invalid![needs to be less than 256]';
    } else {
      return '\x1B[38;5;${codeColor}m';
    }
  }

  /// Converts a color code from the xterm-256color palette to a background ANSI escape sequence.
  ///
  /// [codeColor] - The color code (0-255) from the xterm-256color palette.
  /// Returns a string representing the ANSI escape sequence for the specified background color.
  ///
  /// \x1B[48;5;<BG COLOR>m
  ///
  static String std256BG(int codeColor) {
    if (codeColor < 0) {
      return 'std256BG color is invalid! [needs to be Grater and then 0]';
    } else if (codeColor > 255) {
      return 'std256BG color is invalid![needs to be less than 256]';
    } else {
      return '\x1B[48;5;${codeColor}m';
    }
  }

  static String? _validateRgb(String name, int value) {
    if (value < 0) {
      return '$name color is invalid! [needs to be greater than 0]';
    }
    if (value > 255) {
      return '$name color is invalid! [needs to be less than 256]';
    }
    return null;
  }

  /// Converts RGB values to a foreground ANSI escape sequence.
  ///
  /// [red]   - The red component of the color (0-255).
  /// [green] - The green component of the color (0-255).
  /// [blue]  - The blue component of the color (0-255).
  /// Returns a string representing the ANSI escape sequence for the specified RGB foreground color.
  ///
  /// '\x1B[38;2;<red>;<green>;<blue>m'
  ///
  static String rgbFg(int red, int green, int blue) {
    for (final entry in {'Red': red, 'Green': green, 'Blue': blue}.entries) {
      final error = _validateRgb(entry.key, entry.value);
      if (error != null) return error;
    }
    return '\x1B[38;2;$red;$green;${blue}m';
  }

  /// Converts RGB values to a background ANSI escape sequence.
  ///
  /// [red] - The red component of the color (0-255).
  /// [green] - The green component of the color (0-255).
  /// [blue] - The blue component of the color (0-255).
  /// Returns a string representing the ANSI escape sequence for the specified RGB background color.
  ///
  /// '\x1B[48;2;<red>;<green>;<blue>m'
  ///
  static String rgbBg(int red, int green, int blue) {
    for (final entry in {'Red': red, 'Green': green, 'Blue': blue}.entries) {
      final error = _validateRgb(entry.key, entry.value);
      if (error != null) return error;
    }
    return '\x1B[48;2;$red;$green;${blue}m';
  }

  /// Converts a HEX color code to a foreground ANSI escape sequence.
  ///
  /// [hexColor] - The HEX color code (e.g., '#FF5733', '0xFF5733', etc.).
  /// Returns a string representing the ANSI escape sequence for the specified HEX foreground color.
  /// from following formats
  /// #RRGGBB, 0xRRGGBB, &HRRGGBB, RRGGBBh, #RGB, 0xRGB, 0xAARRGGBB
  ///
  static String hexFg(String hexColor) {
    // Limpeza da string, removendo prefixos como '#', '0x', '&H' e sufixos 'h'
    final cleaned = hexColor
        .replaceAll(RegExp(r'^(#|0x|&H)', caseSensitive: false), '')
        .replaceAll(RegExp(r'h$', caseSensitive: false), '');

    // Verificação do tamanho da string e conversão para o formato adequado
    final hex = switch (cleaned.length) {
      // RGB (ex: #abc -> aabbcc)
      3 => cleaned.split('').map((c) => '$c$c').join(),
      // RGBA (ex: #abcd -> cd)
      4 => cleaned.split('').map((c) => '$c$c').join().substring(2),
      6 => cleaned, // RRGGBB (ex: #aabbcc -> aabbcc)
      // AARRGGBB (ex: #aarrggbb -> rrggbb)
      8 => cleaned.substring(2),
      _ => throw ArgumentError('Invalid hexColor format: $hexColor'),
    };

    // Verificação para garantir que o tamanho da string seja correto (6 ou 8 caracteres)
    if (hex.length != 6) {
      throw FormatException(
          'Hex color must be 6 characters long (RRGGBB). Invalid input: $hexColor');
    }

    // Parse dos valores RGB do formato hexadecimal
    final red = int.parse(hex.substring(0, 2), radix: 16);
    final green = int.parse(hex.substring(2, 4), radix: 16);
    final blue = int.parse(hex.substring(4, 6), radix: 16);

    // Retorna o código ANSI para a cor do texto
    return '\x1B[38;2;$red;$green;$blue m';
  }

  /// Converts a HEX color code to a background ANSI escape sequence.
  ///
  /// [hexColor] - The HEX color code (e.g., '#FF5733', '0xFF5733', etc.).
  /// Returns a string representing the ANSI escape sequence for the specified HEX background color.
  /// /// from following formats
  /// #RRGGBB, 0xRRGGBB, &HRRGGBB, RRGGBBh, #RGB, 0xRGB, 0xAARRGGBB
  ///
  static String hexBg(String hexColor) {
    // Limpeza da string, removendo prefixos como '#', '0x', '&H' e sufixos 'h'
    final cleaned = hexColor
        .replaceAll(RegExp(r'^(#|0x|&H)', caseSensitive: false), '')
        .replaceAll(RegExp(r'h$', caseSensitive: false), '');

    // Verificação do tamanho da string e conversão para o formato adequado
    final hex = switch (cleaned.length) {
      // RGB (ex: #abc -> aabbcc)
      3 => cleaned.split('').map((c) => '$c$c').join(),
      // RGBA (ex: #abcd -> cd)
      4 => cleaned.split('').map((c) => '$c$c').join().substring(2),
      6 => cleaned, // RRGGBB (ex: #aabbcc -> aabbcc)
      8 => cleaned.substring(2), // AARRGGBB (ex: #aarrggbb -> rrggbb)
      _ => throw ArgumentError(
          'Invalid hexColor format: $hexColor'), // Caso inválido
    };

    // Verificação para garantir que o tamanho da string seja correto (6 ou 8 caracteres)
    if (hex.length != 6) {
      throw FormatException(
          'Hex color must be 6 characters long (RRGGBB). Invalid input: $hexColor');
    }

    // Parse dos valores RGB do formato hexadecimal
    final red = int.parse(hex.substring(0, 2), radix: 16);
    final green = int.parse(hex.substring(2, 4), radix: 16);
    final blue = int.parse(hex.substring(4, 6), radix: 16);

    // Retorna o código ANSI para a cor de fundo
    return '\x1B[48;2;$red;$green;$blue m';
  }

  static String printColors() {
    var tableColor = StringBuffer();
    //Standard Colors
    tableColor.writeln(
        'Standard Colors                             High-intensity Colors');
    for (var i = 0; i <= 7; i++) {
      if (i < 10) {
        tableColor.write('${std256BG(i)}  ${std256FG(7)}$i  $reset');
      }
    }
    tableColor.write('    ');
    //High-intensity Colors
    for (var i = 8; i <= 15; i++) {
      if (i < 10) {
        tableColor.write('${std256BG(i)}  ${std256FG(7)}$i  $reset');
      } else {
        tableColor.write('${std256BG(i)}  ${std256FG(7)}$i  $reset');
      }
    }
    tableColor.write('\n\n');

    //
    tableColor.writeln('Left');
    List<List<int>> rangesFirstLoop = [
      [16, 33], [52, 69], [88, 105], [124, 141], [160, 177], [196, 213] //
    ];

    for (var range in rangesFirstLoop) {
      for (var j = range[0]; j <= range[1]; j++) {
        var formattedNumber = j.toString().padLeft(3, '0');
        tableColor
            .write('${std256BG(j)} ${std256FG(7)}$formattedNumber $reset');
      }
      tableColor.write('\n');
    }
    tableColor.write('\n');
    tableColor.writeln('Right');
    List<List<int>> rangesSecondLoop = [
      [34, 51], [70, 87], [106, 123], [142, 159], [178, 195], [214, 231] //
    ];

    for (var range in rangesSecondLoop) {
      for (var j = range[0]; j <= range[1]; j++) {
        var formattedNumber = j.toString().padLeft(3, '0');
        tableColor
            .write('${std256BG(j)} ${std256FG(0)}$formattedNumber $reset');
      }
      tableColor.write('\n');
    }
    tableColor.write('\n');
    //GrayScale
    tableColor.writeln('Gray Scale Color');
    for (var i = 232; i <= 243; i++) {
      tableColor.write('${std256BG(i)}  ${std256FG(7)}$i  $reset');
    }
    tableColor.write('\n');
    for (var i = 244; i <= 255; i++) {
      tableColor.write('${std256BG(i)}  ${std256FG(0)}$i  $reset');
    }
    tableColor.write('\n\n');
    return tableColor.toString();
  }
}
