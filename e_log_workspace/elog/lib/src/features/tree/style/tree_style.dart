import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';

/// Define a aparência visual da árvore (Tree).
class TreeStyle {
  /// O conjunto de bordas usado para desenhar os galhos e conexões.
  /// Mapeamento:
  /// - border.vertical (│) -> Guia vertical
  /// - border.midLeft (├)  -> Conector de item intermediário
  /// - border.bottomLeft (└) -> Conector do último item
  /// - border.middle (─) -> Linha do galho
  final BorderSet border;

  /// Cor da estrutura da árvore (galhos).
  final String structureColor;

  /// Cor das chaves (Keys) do Map.
  final String keyColor;

  /// Cor dos valores (Values) do Map ou itens da List.
  final String valueColor;

  /// Cor dos dois pontos (:) ou separadores.
  final String separatorColor;

  /// Cor da raiz (se exibida).
  final String rootColor;

  const TreeStyle({
    required this.border,
    this.structureColor = XTermColor.brightBlack, // Cinza escuro padrão
    this.keyColor = XTermColor.blue,
    this.valueColor = XTermColor.green,
    this.separatorColor = XTermColor.white,
    this.rootColor = XTermColor.magenta,
  });

  /// Cria uma cópia com alterações.
  TreeStyle copyWith({
    BorderSet? border,
    String? structureColor,
    String? keyColor,
    String? valueColor,
    String? separatorColor,
    String? rootColor,
  }) {
    return TreeStyle(
      border: border ?? this.border,
      structureColor: structureColor ?? this.structureColor,
      keyColor: keyColor ?? this.keyColor,
      valueColor: valueColor ?? this.valueColor,
      separatorColor: separatorColor ?? this.separatorColor,
      rootColor: rootColor ?? this.rootColor,
    );
  }
}
