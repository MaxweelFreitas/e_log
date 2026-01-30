import '../../base/x_term/x_term_color.dart';

/// Níveis semânticos de log no Ascy.
///
/// Não é um enum por design:
/// - permite extensões customizadas via [ELogLevel.custom]
/// - evita lock-in
/// - carrega metadados visuais (cor, ícone) para o Builder
final class ELogLevel {
  /// Identificador único (ex: 'info', 'error'). Útil para Sentry/Crashlytics.
  final String id;

  /// Rótulo exibido no log (ex: 'INFO', 'ERRO').
  final String label;

  /// Emoji/Ícone do nível.
  final String icon;

  /// Cor do texto (ANSI).
  final String color;

  /// Cor do fundo (ANSI).
  final String bgColor;

  const ELogLevel._({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.bgColor,
  });

  // --- Níveis Padrão ---

  /// Logs informativos (Azul)
  static const info = ELogLevel._(
    id: 'info',
    label: 'INFO',
    icon: '📢',
    color: XTermColor.blue,
    bgColor: XTermColor.bgBlue,
  );

  /// Logs de depuração (Magenta)
  static const debug = ELogLevel._(
    id: 'debug',
    label: 'DEBUG',
    icon: '🐜',
    color: XTermColor.magenta,
    bgColor: XTermColor.bgMagenta,
  );

  /// Logs de sucesso (Verde)
  static const success = ELogLevel._(
    id: 'success',
    label: 'DONE',
    icon: '✅',
    color: XTermColor.green,
    bgColor: XTermColor.bgGreen,
  );

  /// Avisos importantes (Amarelo)
  static const warning = ELogLevel._(
    id: 'warning',
    label: 'WARN',
    icon: '🚧',
    color: XTermColor.yellow,
    bgColor: XTermColor.bgYellow,
  );

  /// Erros recuperáveis (Vermelho)
  static const error = ELogLevel._(
    id: 'error',
    label: 'ERROR',
    icon: '❌',
    color: XTermColor.red,
    bgColor: XTermColor.bgRed,
  );

  /// Erros críticos (Vermelho Intenso / Fundo Vermelho se desejar)
  static const fatal = ELogLevel._(
    id: 'fatal',
    label: 'FATAL',
    icon: '💀',
    color: XTermColor.magenta, // Pode usar XTermColor.brightRed se tiver
    bgColor: XTermColor.bgMagenta,
  );

  // --- Fábrica Customizada ---

  /// Cria um nível customizado com estilo visual.
  ///
  /// Exemplo:
  /// ```dart
  /// final netLog = ELogLevel.custom(
  ///   id: 'network',
  ///   label: 'NET',
  ///   icon: '📡',
  ///   color: XTermColor.cyan
  /// );
  /// ```
  factory ELogLevel.custom({
    required String id,
    String? label,
    String icon = '🔹',
    String color = XTermColor.white,
    String bgColor = XTermColor.bgBlack, // Ou reset/vazio
  }) {
    return ELogLevel._(
      id: id,
      label: label ?? id.toUpperCase(),
      icon: icon,
      color: color,
      bgColor: bgColor,
    );
  }

  @override
  String toString() => id;

  @override
  bool operator ==(Object other) => other is ELogLevel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
