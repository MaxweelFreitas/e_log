import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';

/// Define a aparência visual da tabela.
class TableStyle {
  /// O conjunto de caracteres para desenhar a grade da tabela.
  final BorderSet border;

  /// Cor das linhas da grade/borda.
  final String borderColor;

  /// Cor do texto do cabeçalho.
  final String headerColor;

  /// Cor do texto das células de dados.
  final String contentColor;

  // --- BACKGROUNDS (NOVO) ---

  /// Cor de fundo do cabeçalho.
  final String headerBackground;

  /// Cor de fundo das células de dados.
  final String contentBackground;

  const TableStyle({
    required this.border,
    this.borderColor = XTermColor.reset,
    this.headerColor = XTermColor.reset,
    this.contentColor = XTermColor.reset,
    this.headerBackground = '',
    this.contentBackground = '',
  });

  /// Cria uma cópia com alterações.
  TableStyle copyWith({
    BorderSet? border,
    String? borderColor,
    String? headerColor,
    String? contentColor,
  }) {
    return TableStyle(
      border: border ?? this.border,
      borderColor: borderColor ?? this.borderColor,
      headerColor: headerColor ?? this.headerColor,
      contentColor: contentColor ?? this.contentColor,
      headerBackground: headerBackground,
      contentBackground: contentBackground,
    );
  }
}
