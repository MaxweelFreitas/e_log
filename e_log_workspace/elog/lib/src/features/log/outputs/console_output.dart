import 'dart:io';
import '../../../core/contracts/elog_output.dart';
import '../../../core/models/elog_record.dart';

class ConsoleOutput extends ELogOutput {
  @override
  void emit(ELogRecord record) {
    // Para o console, queremos a versão renderizada (Box/Inline com cores)
    stdout.writeln(record.renderedMessage);
  }
}
