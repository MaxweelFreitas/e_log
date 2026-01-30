import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import '../../box/style/shadow_style.dart';

/// Define a aparência visual de um Log (Bordas e Cores).
class ELogStyle {
  /// O conjunto de bordas a ser usado (apenas para layout Boxed).
  final BorderSet border;

  /// Cor da borda.
  /// Se null, usa a cor definida pelo [ELogLevel] (ex: Vermelho para Erro).
  final String? borderColor;

  /// Cor do timestamp [12:00:00].
  final String timestampColor;

  /// Cor da tag/rótulo [INFO].
  /// Se null, usa a cor do [ELogLevel].
  final String? labelColor;

  /// Cor da mensagem principal.
  final String messageColor;

  /// Cor dos colchetes [] e pontuações secundárias.
  final String bracketColor;

  /// Define se deve mostrar a sombra (apenas para layout Boxed).
  final ShadowStyle? shadow;

  const ELogStyle({
    required this.border,
    this.borderColor,
    this.timestampColor = XTermColor.brightBlack, // Cinza escuro (Dim)
    this.labelColor,
    this.messageColor = XTermColor.reset,
    this.bracketColor = XTermColor.brightBlack,
    this.shadow,
  });

  /// Copia o estilo com alterações.
  ELogStyle copyWith({
    BorderSet? border,
    String? borderColor,
    String? timestampColor,
    String? labelColor,
    String? messageColor,
    String? bracketColor,
    ShadowStyle? shadow,
  }) {
    return ELogStyle(
      border: border ?? this.border,
      borderColor: borderColor ?? this.borderColor,
      timestampColor: timestampColor ?? this.timestampColor,
      labelColor: labelColor ?? this.labelColor,
      messageColor: messageColor ?? this.messageColor,
      bracketColor: bracketColor ?? this.bracketColor,
      shadow: shadow ?? this.shadow,
    );
  }
}
