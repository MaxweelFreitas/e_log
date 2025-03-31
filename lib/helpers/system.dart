import 'dart:io';

import '../core/base/e_log.dart';

class System {
  static String getFileName(StackTrace stackTrace) {
    final resultLinks = getStackTraceLinks(stackTrace);

    assert(resultLinks.isNotEmpty);

    return resultLinks.isNotEmpty ? resultLinks[0] : '';
  }

  static List<String> getStackTraceLinks(StackTrace stackTrace) {
    final pattern = RegExp(r'\(([^)]+)\)');
    final matches = pattern.allMatches(stackTrace.toString());

    List<String> links = matches.map((match) => match.group(1)!).toList();
    final packagePattern = RegExp(r'package:([^/]+)/(.+):(\d+):(\d+)');
    List<String> resultLinks = [];

    for (String link in links) {
      final match = packagePattern.firstMatch(link);

      if (match != null) {
        final restOfUrl = match.group(2)!;
        final lineNumber = match.group(3)!;
        final columnNumber = match.group(4)!;

        // Verificar se o link contém 'teste.dart'
        String updatedLink;
        if (restOfUrl.contains('teste.dart')) {
          updatedLink =
              'test/$restOfUrl:$lineNumber:$columnNumber'; // Substituir lib/ por test/
        } else {
          updatedLink = 'lib/$restOfUrl:$lineNumber:$columnNumber';
        }

        resultLinks.add(updatedLink);
      } else {
        // Substituir 'file:///' e 'Directory.current.path' por 'lib/' ou 'test/'
        final currentPath = Directory.current.path.replaceAll('\\', '/');
        var updatedLink = link.replaceFirst('file:///', '');
        if (updatedLink.contains('test.dart')) {
          // Substituir o caminho completo por test/
          updatedLink =
              updatedLink.replaceFirst(currentPath, '').replaceFirst('/', '');
        } else {
          updatedLink = updatedLink.replaceFirst(currentPath, 'lib');
        }
        resultLinks.add(updatedLink);
      }
    }
    return resultLinks;
  }
}

// Exemplo de uso
void main() {
  try {
    throw Exception('Exemplo de exceção');
  } on Exception catch (e, stackTrace) {
    final fileName = System.getFileName(stackTrace);
    eLog('Arquivo onde ocorreu a exceção: $fileName');
  }
}
