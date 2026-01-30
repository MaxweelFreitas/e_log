import '../../../core/contracts/elog_output.dart';
import '../../../core/models/elog_record.dart';

class ELogMultiplexer extends ELogOutput {
  final List<ELogOutput> _outputs;

  ELogMultiplexer(List<ELogOutput> outputs) : _outputs = outputs;

  @override
  void emit(ELogRecord record) {
    for (final output in _outputs) {
      try {
        output.emit(record);
      } on Exception catch (e) {
        // Falha em um output não deve travar a app
        print('Erro no ELog output: $e');
      }
    }
  }
}
