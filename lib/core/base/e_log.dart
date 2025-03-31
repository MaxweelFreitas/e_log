import 'x_term/x_term_color.dart';

/// Writes a message to the console using `print` in debug mode.
/// If no ANSI color is detected in the message, a default color is applied.
///
/// - [message]: The message to be printed.
/// - [defaultColor]: The default ANSI color code to use if no color is detected.
///
/// Example usage:
/// ```dart
/// eLog('Erro: Algo deu errado.', defaultColor: '\x1B[31m'); // Vermelho
/// eLog('\x1B[32mSucesso:\x1B[0m Operação concluída.'); // Já tem cor, então mantém
/// ```
void eLog(String? message,
    {String color = XTermColor.main, String reset = XTermColor.reset}) {
  if (message == null || message.isEmpty) {
    return;
  }

  // Verifica se a mensagem já contém algum código ANSI (começa com "\x1B[")
  final regexAnsi = RegExp(r'\x1B\[\d+m');
  bool hasColor = regexAnsi.hasMatch(message);

  // Se não houver cor na string, aplica a cor padrão
  String formattedMessage = hasColor ? message : (color + message);

  assert(() {
    // ignore: avoid_print
    print(formattedMessage + reset);

    return true;
  }());
}
