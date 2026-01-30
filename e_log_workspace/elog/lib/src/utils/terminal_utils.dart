import 'dart:io';

/// Utilitário estático para gerenciar o estado do terminal.
/// Usado internamente pelo EWizard para garantir limpeza.
class Terminal {
  const Terminal._();

  /// Esconde o cursor e desativa o echo (prepara para TUI).
  static void init() {
    stdout.write('\x1B[?25l'); // Esconde cursor
    try {
      stdin.echoMode = false;
      stdin.lineMode = false;
    } on Exception catch (_) {}
  }

  /// Restaura o terminal para o estado padrão (seguro).
  /// Pode ser chamado manualmente pelo usuário em caso de crash.
  static void restore() {
    // 1. Tenta restaurar via Dart
    try {
      if (!stdin.echoMode) stdin.echoMode = true;
      if (!stdin.lineMode) stdin.lineMode = true;
    } on Exception catch (_) {}

    // 2. Fail-safe para Unix (caso o Dart falhe em restaurar o echo)
    if (!Platform.isWindows) {
      try {
        Process.runSync('stty', ['echo']);
      } on Exception catch (_) {}
    }

    // 3. Reseta visual (Mostra Cursor, Reseta Cores)
    stdout.write('\x1B[?25h\x1B[0m');
  }
}
