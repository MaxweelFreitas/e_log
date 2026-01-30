/// Estilos ANSI para terminal (XTerm).
///
/// - Stateless
/// - Independente de cores
/// - Base para toda a Ascy
final class XTermStyle {
  const XTermStyle._();

  // Reset
  static const String reset = '\x1B[0m';

  // Estilos de texto
  static const String bold = '\x1B[1m';
  static const String dim = '\x1B[2m';
  static const String italic = '\x1B[3m';
  static const String underline = '\x1B[4m';
  static const String blink = '\x1B[5m';
  static const String reverse = '\x1B[7m';
  static const String hidden = '\x1B[8m';
  static const String strike = '\x1B[9m';

  /// Desativa apenas o negrito (sem resetar tudo)
  static const String boldOff = '\x1B[22m';

  /// Desativa sublinhado
  static const String underlineOff = '\x1B[24m';

  /// Desativa reverso
  static const String reverseOff = '\x1B[27m';

  /// Gera um hyperlink clicável no terminal (OSC 8).
  ///
  /// [url] O destino do link (ex: https://google.com ou file:///c:/projeto/main.dart)
  /// [linkText] O texto que aparecerá no terminal.
  static String link({
    required String url,
    required String linkText,
  }) {
    // \x1B]8;;URL\x1B\TEXTO\x1B]8;;\x1B\
    return '\x1B]8;;$url\x1B\\$linkText\x1B]8;;\x1B\\';
  }
}
