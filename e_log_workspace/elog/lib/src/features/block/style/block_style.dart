import '../../../base/x_term/x_term_color.dart';

/// Define o estilo visual de um bloco de texto (Bloquete).
class BlockStyle {
  /// O caractere usado na barra lateral. Ex: '█', '║', '│'
  final String borderChar;

  /// Cor da barra lateral.
  final String borderColor;

  /// Cor do texto.
  final String textColor;

  /// Se true, adiciona uma linha com a barra (mas sem texto)
  /// no início e no fim do bloco.
  final bool showPaddingLines;

  /// Espaçamento entre a barra e o texto. Ex: '  ' (2 espaços).
  final String paddingLeft;

  const BlockStyle({
    required this.borderChar,
    this.borderColor = XTermColor.white,
    this.textColor = XTermColor.reset,
    this.showPaddingLines = true,
    this.paddingLeft = '  ',
  });

  /// Copia o estilo alterando propriedades específicas.
  BlockStyle copyWith({
    String? borderChar,
    String? borderColor,
    String? textColor,
    bool? showPaddingLines,
    String? paddingLeft,
  }) {
    return BlockStyle(
      borderChar: borderChar ?? this.borderChar,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      showPaddingLines: showPaddingLines ?? this.showPaddingLines,
      paddingLeft: paddingLeft ?? this.paddingLeft,
    );
  }
}
