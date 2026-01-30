import '../../../core/contracts/elog_output.dart';
import '../elog_level.dart';
import '../outputs/console_output.dart';
import '../outputs/e_log_multiplexer.dart';

enum EDateType {
  iso('YYYY-MM-DD'), // 2024-01-25
  eu('DD-MM-YYYY'), // 25-01-2024
  us('MM-DD-YYYY'), // 01-25-2024
  ptBr('DD-MM-YYYY'); // 25-01-2024

  final String pattern;
  const EDateType(this.pattern);
}

class ELogConfig {
  // Singleton
  static final ELogConfig _instance = ELogConfig._internal();

  factory ELogConfig() => _instance;

  ELogConfig._internal();

  // --- Saída (Output) ---

  // Define ConsoleOutput como padrão para evitar erros se nada for configurado
  ELogOutput _output = ConsoleOutput();

  /// Define um ou múltiplos outputs (ex: Console + Arquivo + Sentry).
  void setOutputs(List<ELogOutput> outputs) {
    if (outputs.isEmpty) return;

    if (outputs.length == 1) {
      _output = outputs.first;
    } else {
      // Se houver mais de um, usa o Multiplexer para distribuir
      _output = ELogMultiplexer(outputs);
    }
  }

  /// Retorna o output ativo (pode ser único ou Multiplexer).
  ELogOutput get output => _output;

  // --- Opções de Data ---

  EDateType _dateType = EDateType.eu; // Default: 25-01-2024

  /// Configura o formato de data global.
  void setDateType(EDateType type) => _dateType = type;

  // --- Opções do Sentry e Erros ---

  /// Instância do Sentry (Object genérico para não acoplar a lib ao pacote Sentry)
  Object? sentry;

  /// Níveis que devem ser tratados como erro (ex: para enviar ao Sentry).
  /// Se null, a implementação do output decide (geralmente Error e Fatal).
  List<ELogLevel>? errorLevels;

  // --- Utilitário de Formatação ---

  /// Formata a data atual baseada na configuração [setDateType].
  String format(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');

    // HH:mm:ss
    final time = '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}:'
        '${date.second.toString().padLeft(2, '0')}';

    String datePart;
    switch (_dateType) {
      case EDateType.iso:
        datePart = '$y-$m-$d';
        break;
      case EDateType.us:
        datePart = '$m-$d-$y';
        break;
      case EDateType.eu:
      case EDateType.ptBr:
        datePart = '$d-$m-$y';
        break;
    }

    return '$datePart $time';
  }
}
