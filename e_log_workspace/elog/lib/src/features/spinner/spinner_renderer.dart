/// Renderiza frames de spinner no terminal
///
/// NÃO controla tempo.
/// NÃO conhece Spinner.
/// Apenas desenha texto.
class SpinnerRenderer {
  final bool overwrite;
  final String suffix;
  final String prefix;

  int _lastLength = 0;

  SpinnerRenderer({this.overwrite = true, this.prefix = '', this.suffix = ''});

  /// Renderiza um frame
  String render(String frame) {
    final content = '$prefix$frame$suffix';

    if (!overwrite) {
      _lastLength = content.length;
      return content;
    }

    final cleared = _clearLine(content.length);
    _lastLength = content.length;

    return '$cleared$content';
  }

  /// Limpa resíduos da linha anterior
  String _clearLine(int newLength) {
    if (_lastLength == 0) return '\r';

    final diff = _lastLength - newLength;
    if (diff <= 0) return '\r';

    return '\r${' ' * diff}\r';
  }

  /// Finaliza o spinner (ex: após sucesso)
  String finish({String? finalText}) {
    if (!overwrite) return finalText ?? '';

    final clear = '\r${' ' * _lastLength}\r';
    _lastLength = 0;

    return finalText != null ? '$clear$finalText' : clear;
  }
}
