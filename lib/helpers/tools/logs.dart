import 'dart:io';

import 'package:path/path.dart' as path;

void writeLog(String message) {
  // Obtém o diretório
  String logsPath = path.join(
    Platform.environment['USERPROFILE'] ?? '',
    'Documents',
    'eLog',
  );

  // Caminho do arquivo de log
  String logFilePath = path.join(logsPath, 'logs.log');

  // Verifica se a pasta existe, se não, cria
  Directory logDir = Directory(logsPath);
  if (!logDir.existsSync()) {
    logDir.createSync(recursive: true);
  }

  // Verifica se o arquivo existe, se não, cria
  File logFile = File(logFilePath);
  if (!logFile.existsSync()) {
    logFile.createSync();
  }

  // Escreve a mensagem no final do arquivo
  logFile.writeAsStringSync('$message\n', mode: FileMode.append);
}

void main() {
  writeLog('Este é um log de teste.');
}
