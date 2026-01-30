import 'dart:io';

/// Utilitário para obter informações do ambiente do terminal.
///
/// Funciona em Windows, Linux e macOS.
class TerminalInfo {
  TerminalInfo._(); // Construtor privado para impedir instanciação.

  /// Retorna a largura atual do terminal (número de colunas).
  ///
  /// Retorna [null] se:
  /// - Não for possível determinar a largura.
  /// - O código não estiver rodando em um terminal interativo (ex: logs em arquivo).
  static int? get width {
    try {
      // stdout.hasTerminal verifica se há um TTY (terminal real) anexado.
      if (stdout.hasTerminal) {
        return stdout.terminalColumns;
      }
    } on Exception catch (_) {
      // Ignora erros de StdoutException que podem ocorrer em ambientes restritos
    }

    // Fallback: Tenta ler variáveis de ambiente (comum em Linux/Mac/CI)
    // O Windows raramente usa a var COLUMNS, mas não faz mal verificar.
    final envColumns = Platform.environment['COLUMNS'];
    if (envColumns != null) {
      return int.tryParse(envColumns);
    }

    return null;
  }

  /// Retorna a altura atual do terminal (número de linhas).
  static int? get height {
    try {
      if (stdout.hasTerminal) {
        return stdout.terminalLines;
      }
    } on Exception catch (_) {
      // Ignora erros
    }

    final envLines = Platform.environment['LINES'];
    if (envLines != null) {
      return int.tryParse(envLines);
    }

    return null;
  }

  /// Verifica se o suporte a cores ANSI está disponível.
  static bool get supportsAnsi {
    return stdout.supportsAnsiEscapes;
  }
}
