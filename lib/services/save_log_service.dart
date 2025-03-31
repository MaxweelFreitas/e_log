import 'dart:convert';
import 'dart:io';

import '../core/base/e_log.dart';

abstract class SaveLogService {
  String saveLog(String log, {String filePath = ''});
}

class TxtSaveLogService implements SaveLogService {
  @override
  String saveLog(String log, {String filePath = ''}) {
    try {
      String path = filePath;

      if (filePath.isEmpty) {
        // Obtém o diretório de documentos
        final directoryRootPath = Directory.current.path;

        var pathRoot = Platform.isWindows
            ? '$directoryRootPath\\logs'
            : '$directoryRootPath/logs';
        final directoryLog = Directory(pathRoot);

        if (!directoryLog.existsSync()) {
          directoryLog.createSync();
        }

        final timeStamp = DateTime.now().toIso8601String().replaceAll(':', '-');

        path = Platform.isWindows
            ? '${directoryLog.path}\\logs_$timeStamp.txt'
            : '${directoryLog.path}/logs_$timeStamp.txt';
      }
      // Cria uma referência ao arquivo de log
      final file = File(path);

      // Adiciona o log ao arquivo
      file.writeAsStringSync('$log\n', mode: FileMode.append);

      return path;
    } on Exception catch (e) {
      eLog('Erro ao salvar log: $e');
      return '';
    }
  }
}

class JsonSaveLogService implements SaveLogService {
  @override
  String saveLog(String log, {String filePath = ''}) {
    try {
      String path = filePath;

      if (filePath.isEmpty) {
        final directoryRootPath = Directory.current.path;

        var pathRoot = Platform.isWindows
            ? '$directoryRootPath\\logs'
            : '$directoryRootPath/logs';
        final directoryLog = Directory(pathRoot);

        if (!directoryLog.existsSync()) {
          directoryLog.createSync();
        }

        final timeStamp = DateTime.now().toIso8601String().replaceAll(':', '-');

        path = Platform.isWindows
            ? '${directoryLog.path}\\logs_$timeStamp.json'
            : '${directoryLog.path}/logs_$timeStamp.json';
      }

      final file = File(path);

      Map<String, dynamic> logEntry = {
        'timestamp': DateTime.now().toIso8601String(),
        'log': log,
      };

      if (file.existsSync()) {
        final existingContent = file.readAsStringSync();
        List<dynamic> jsonContent;

        if (existingContent.isNotEmpty) {
          jsonContent = jsonDecode(existingContent);
        } else {
          jsonContent = [];
        }

        jsonContent.add(logEntry);

        file.writeAsStringSync(jsonEncode(jsonContent));
      } else {
        file.writeAsStringSync(jsonEncode([logEntry]));
      }

      return path;
    } on Exception catch (e) {
      eLog('Erro ao salvar log: $e');
      return '';
    }
  }
}
