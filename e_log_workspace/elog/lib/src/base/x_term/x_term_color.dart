/// Utilitário de cores ANSI compatível com XTerm.
///
/// - Stateless
/// - Reutilizável
/// - Base para toda a Ascy
final class XTermColor {
  const XTermColor._();

  // Reset geral
  static const String reset = '\x1B[0m';

  // ---------------------------------------------------------------------------
  // CORES CUSTOMIZADAS (BRANDING)
  // ---------------------------------------------------------------------------
  /// bright orange.
  static String orange = rgb(255, 165, 0);

  /// orangeRed.
  static String orangeRed = rgb(255, 135, 0);

  /// limeGreen.
  static String limeGreen = rgb(50, 205, 50);

  // ---------------------------------------------------------------------------
  // FOREGROUND (TEXTO) - STANDARD
  // ---------------------------------------------------------------------------
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  // ---------------------------------------------------------------------------
  // FOREGROUND (TEXTO) - BRIGHT
  // ---------------------------------------------------------------------------
  static const String brightBlack = '\x1B[90m';
  static const String brightRed = '\x1B[91m';
  static const String brightGreen = '\x1B[92m';
  static const String brightYellow = '\x1B[93m';
  static const String brightBlue = '\x1B[94m';
  static const String brightMagenta = '\x1B[95m';
  static const String brightCyan = '\x1B[96m';
  static const String brightWhite = '\x1B[97m';

  // ---------------------------------------------------------------------------
  // BACKGROUND (FUNDO) - STANDARD
  // ---------------------------------------------------------------------------
  static const String bgBlack = '\x1B[40m';
  static const String bgRed = '\x1B[41m';
  static const String bgGreen = '\x1B[42m';
  static const String bgYellow = '\x1B[43m';
  static const String bgBlue = '\x1B[44m';
  static const String bgMagenta = '\x1B[45m';
  static const String bgCyan = '\x1B[46m';
  static const String bgWhite = '\x1B[47m';

  // ---------------------------------------------------------------------------
  // BACKGROUND (FUNDO) - BRIGHT
  // ---------------------------------------------------------------------------
  static const String bgBrightBlack = '\x1B[100m';
  static const String bgBrightRed = '\x1B[101m';
  static const String bgBrightGreen = '\x1B[102m';
  static const String bgBrightYellow = '\x1B[103m';
  static const String bgBrightBlue = '\x1B[104m';
  static const String bgBrightMagenta = '\x1B[105m';
  static const String bgBrightCyan = '\x1B[106m';
  static const String bgBrightWhite = '\x1B[107m';

  // ---------------------------------------------------------------------------
  // UTILITÁRIOS (RGB & HEX)
  // ---------------------------------------------------------------------------

  /// Cor ANSI 24-bit (foreground)
  ///
  /// Exemplo:
  /// ```dart
  /// XTermColor.rgb(255, 120, 0)
  /// ```
  static String rgb(int r, int g, int b) {
    return '\x1B[38;2;$r;$g;${b}m';
  }

  /// Cor ANSI 24-bit (background)
  static String rgbBg(int r, int g, int b) {
    return '\x1B[48;2;$r;$g;${b}m';
  }

  /// Converte HEX (#RRGGBB ou RRGGBB) para ANSI foreground
  static String hexFg(String hex) {
    final clean = hex.replaceAll('#', '');
    if (clean.length != 6) return reset; // Fallback simples

    final r = int.parse(clean.substring(0, 2), radix: 16);
    final g = int.parse(clean.substring(2, 4), radix: 16);
    final b = int.parse(clean.substring(4, 6), radix: 16);
    return rgb(r, g, b);
  }

  /// Converte HEX (#RRGGBB ou RRGGBB) para ANSI background
  static String hexBg(String hex) {
    final clean = hex.replaceAll('#', '');
    if (clean.length != 6) return reset; // Fallback simples

    final r = int.parse(clean.substring(0, 2), radix: 16);
    final g = int.parse(clean.substring(2, 4), radix: 16);
    final b = int.parse(clean.substring(4, 6), radix: 16);
    return rgbBg(r, g, b);
  }

  /// Gera a cor APENAS para o sublinhado (Underline Color).
  /// Suportado em terminais modernos (VS Code, Windows Terminal, iTerm2).
  static String underlineRgb(int r, int g, int b) {
    return '\x1b[58;2;$r;$g;${b}m';
  }

  /// Reseta a cor do sublinhado para o padrão
  static const String underlineReset = '\x1b[59m';
}
