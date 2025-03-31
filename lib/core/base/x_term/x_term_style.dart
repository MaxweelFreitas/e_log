class XTermStyle {
  static const reset = '\x1B[0m';

  static const bold = '\x1B[1m';
  static const faint = '\x1B[2m';
  static const italic = '\x1B[3m';
  static const underlined = '\x1B[4m';
  static const inverse = '\x1B[7m';
  static const strikethrough = '\x1B[9m';
  static const clearTerminal = '\x1B[2J\x1B[H';

  static String link({
    String url = 'https://www.google.com',
    String linkText = 'Click here',
  }) {
    final link = '\x1B]8;;$url\x1B\\$linkText\x1B]8;;\x1B\\';
    return link;
  }
}
