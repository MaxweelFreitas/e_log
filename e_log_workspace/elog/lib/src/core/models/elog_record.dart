import '../../features/log/elog_level.dart';

/// Representa um evento de log completo.
/// Carrega tanto os dados brutos (para APIs/Bancos) quanto a versão renderizada (para Terminal).
class ELogRecord {
  final DateTime time;
  final ELogLevel level;
  final String message;

  // Metadados opcionais
  final String? title;
  final String? source;
  final Object? error;
  final StackTrace? stackTrace;
  final String? linkUrl;

  // A string bonita já processada pelo Builder (com cores e bordas)
  final String renderedMessage;

  const ELogRecord({
    required this.time,
    required this.level,
    required this.message,
    required this.renderedMessage,
    this.title,
    this.source,
    this.error,
    this.stackTrace,
    this.linkUrl,
  });

  /// Converte para Map (Útil para salvar em JSON/Banco)
  Map<String, dynamic> toMap() {
    return {
      'timestamp': time.toIso8601String(),
      'level': level.id,
      'message': message,
      if (title != null) 'title': title,
      if (source != null) 'source': source,
      if (error != null) 'error': error.toString(),
      if (stackTrace != null) 'stackTrace': stackTrace.toString(),
    };
  }
}
