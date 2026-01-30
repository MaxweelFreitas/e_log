import 'dart:io';

/// Utilitários relacionados ao sistema e StackTrace.
///
/// - Sem dependência de logs
/// - Sem ANSI
/// - Stateless
final class SystemUtils {
  const SystemUtils._();

  /// Retorna o primeiro arquivo relevante do StackTrace.
  static String getFileName(StackTrace stackTrace) {
    final links = getStackTraceLinks(stackTrace);
    return links.isNotEmpty ? links.first : '';
  }

  /// Extrai e normaliza os links do StackTrace.
  ///
  /// Exemplo de retorno:
  /// lib/src/my_file.dart:10:5
  static List<String> getStackTraceLinks(StackTrace stackTrace) {
    final raw = stackTrace.toString();
    final matches = RegExp(r'\(([^)]+)\)').allMatches(raw);

    final currentPath = Directory.current.path.replaceAll('\\', '/');

    final results = <String>[];

    for (final match in matches) {
      final link = match.group(1)!;

      // package:my_pkg/src/file.dart:10:2
      final pkg = RegExp(r'package:([^/]+)/(.+):(\d+):(\d+)').firstMatch(link);

      if (pkg != null) {
        final pathPart = pkg.group(2)!;
        final line = pkg.group(3)!;
        final column = pkg.group(4)!;

        results.add('lib/$pathPart:$line:$column');
        continue;
      }

      // file:///.../lib/file.dart:10:2
      var cleaned = link.replaceFirst('file:///', '');
      cleaned = cleaned.replaceAll('\\', '/');

      if (cleaned.contains(currentPath)) {
        cleaned = cleaned.replaceFirst(currentPath, '');
        if (cleaned.startsWith('/')) {
          cleaned = cleaned.substring(1);
        }
      }

      results.add(cleaned);
    }

    return results;
  }
}
