import '../models/elog_record.dart';

/// Contrato para destinos de log.
abstract class ELogOutput {
  const ELogOutput();

  /// Recebe o registro completo e decide como persistir.
  void emit(ELogRecord record);

  Future<void> flush() async {}
  Future<void> close() async {}
}
