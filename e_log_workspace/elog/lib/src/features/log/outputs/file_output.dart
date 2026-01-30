import 'dart:io';
import '../../../core/contracts/elog_output.dart';
import '../../../core/models/elog_record.dart';
import '../../../utils/string_utils.dart'; // Assumindo que tenha um stripAnsi

class FileOutput extends ELogOutput {
  final File _file;
  final bool json;

  FileOutput({required String path, this.json = false}) : _file = File(path);

  @override
  void emit(ELogRecord record) {
    if (json) {
      // Implementar lógica de append JSON
      // _file.writeAsStringSync(jsonEncode(record.toMap()) + '\n', mode: FileMode.append);
    } else {
      // Log texto simples: [DATA] [LEVEL] Mensagem
      final cleanMsg = StringUtils.stripAnsi(record.renderedMessage);
      _file.writeAsStringSync('$cleanMsg\n', mode: FileMode.append);
    }
  }
}
