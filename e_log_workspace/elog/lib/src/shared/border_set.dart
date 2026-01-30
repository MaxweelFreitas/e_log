/// Define conjuntos de caracteres para desenhar bordas em Tabelas, Boxes e Wizards.
class BorderSet {
  // --- Cantos Externos ---
  final String topLeft; // ┌
  final String top; // ─
  final String topRight; // ┐
  final String right; // │
  final String bottomRight; // ┘
  final String bottom; // ─
  final String bottomLeft; // └
  final String left; // │

  // --- Interseções Internas (Usadas em Tabelas) ---
  final String topMid; // ┬
  final String bottomMid; // ┴
  final String midLeft; // ├  (Usado como treeConnector no Wizard)
  final String midRight; // ┤
  final String center; // ┼
  final String middle; // ─ (Linha horizontal interna)
  final String vertical; // │ (Linha vertical interna)

  // --- Títulos (Opcionais) ---
  final String titleLeft; // ┤
  final String titleRight; // ├

  const BorderSet({
    required this.topLeft,
    required this.top,
    required this.topRight,
    required this.right,
    required this.left,
    required this.bottomLeft,
    required this.bottom,
    required this.bottomRight,
    required this.topMid,
    required this.bottomMid,
    required this.midLeft,
    required this.midRight,
    required this.center,
    required this.middle,
    required this.vertical,
    this.titleLeft = '┤',
    this.titleRight = '├',
  });

  // ===========================================================================
  // PRESETS (PREDEFINIÇÕES)
  // ===========================================================================

  /// 1. SINGLE (Padrão)
  /// ┌─┬─┐
  /// │ │ │
  /// ├─┼─┤ (Connector: ├)
  /// └─┴─┘
  static const single = BorderSet(
    topLeft: '┌', top: '─', topRight: '┐',
    right: '│', left: '│',
    bottomLeft: '└', bottom: '─', bottomRight: '┘',
    topMid: '┬', bottomMid: '┴',
    midLeft: '├', midRight: '┤', // Wizard usa midLeft como conector
    center: '┼', middle: '─', vertical: '│',
  );

  /// 2. ROUNDED (Arredondado)
  /// ╭─┬─╮
  /// │ │ │
  /// ├─┼─┤
  /// ╰─┴─╯
  static const rounded = BorderSet(
    topLeft: '╭',
    top: '─',
    topRight: '╮',
    right: '│',
    left: '│',
    bottomLeft: '╰',
    bottom: '─',
    bottomRight: '╯',
    topMid: '┬',
    bottomMid: '┴',
    midLeft: '├',
    midRight: '┤',
    center: '┼',
    middle: '─',
    vertical: '│',
  );

  /// 3. HEAVY (Pesado / Negrito)
  /// ┏━┳━┓
  /// ┃ ┃ ┃
  /// ┣━╋━┫
  /// ┗━┻━┛
  static const heavy = BorderSet(
    topLeft: '┏',
    top: '━',
    topRight: '┓',
    right: '┃',
    left: '┃',
    bottomLeft: '┗',
    bottom: '━',
    bottomRight: '┛',
    topMid: '┳',
    bottomMid: '┻',
    midLeft: '┣',
    midRight: '┫',
    center: '╋',
    middle: '━',
    vertical: '┃',
    titleLeft: '┫',
    titleRight: '┣',
  );

  /// 4. DOUBLE (Duplo)
  /// ╔═╦═╗
  /// ║ ║ ║
  /// ╠═╬═╣
  /// ╚═╩═╝
  static const double = BorderSet(
    topLeft: '╔',
    top: '═',
    topRight: '╗',
    right: '║',
    left: '║',
    bottomLeft: '╚',
    bottom: '═',
    bottomRight: '╝',
    topMid: '╦',
    bottomMid: '╩',
    midLeft: '╠',
    midRight: '╣',
    center: '╬',
    middle: '═',
    vertical: '║',
    titleLeft: '╣',
    titleRight: '╠',
  );

  /// 5. LIGHT DOUBLE (Vertical Duplo, Horizontal Simples)
  /// ╓─╥─╖
  /// ║ ║ ║
  /// ╟─╫─╢
  /// ╙─╨─╜
  static const lightDouble = BorderSet(
    topLeft: '╓',
    top: '─',
    topRight: '╖',
    right: '║',
    left: '║',
    bottomLeft: '╙',
    bottom: '─',
    bottomRight: '╜',
    topMid: '╥',
    bottomMid: '╨',
    midLeft: '╟',
    midRight: '╢',
    center: '╫',
    middle: '─',
    vertical: '║',
    titleLeft: '╢',
    titleRight: '╟',
  );

  /// 6. MIXED (Horizontal Duplo, Vertical Simples)
  /// ╒═╤═╕
  /// │ │ │
  /// ╞═╪═╡
  /// ╘═╧═╛
  static const mixed = BorderSet(
    topLeft: '╒',
    top: '═',
    topRight: '╕',
    right: '│',
    left: '│',
    bottomLeft: '╘',
    bottom: '═',
    bottomRight: '╛',
    topMid: '╤',
    bottomMid: '╧',
    midLeft: '╞',
    midRight: '╡',
    center: '╪',
    middle: '═',
    vertical: '│',
    titleLeft: '╡',
    titleRight: '╞',
  );

  /// 7. ASCII (Clássico)
  /// +─+─+
  /// | | |
  /// +─+─+
  static const ascii = BorderSet(
    topLeft: '+',
    top: '-',
    topRight: '+',
    right: '|',
    left: '|',
    bottomLeft: '+',
    bottom: '-',
    bottomRight: '+',
    topMid: '+',
    bottomMid: '+',
    midLeft: '+',
    midRight: '+',
    center: '+',
    middle: '-',
    vertical: '|',
    titleLeft: '|',
    titleRight: '|',
  );

  // --- Estilos Especiais ---

  static const dotted = BorderSet(
    topLeft: '┌',
    top: '·',
    topRight: '┐',
    right: ':',
    left: ':',
    bottomLeft: '└',
    bottom: '·',
    bottomRight: '┘',
    topMid: '·',
    bottomMid: '·',
    midLeft: ':',
    midRight: ':',
    center: '·',
    middle: '·',
    vertical: ':',
  );

  static const dashed = BorderSet(
    topLeft: '┌',
    top: '╌',
    topRight: '┐',
    right: '╎',
    left: '╎',
    bottomLeft: '└',
    bottom: '╌',
    bottomRight: '┘',
    topMid: '┬',
    bottomMid: '┴',
    midLeft: '├',
    midRight: '┤',
    center: '┼',
    middle: '╌',
    vertical: '╎',
  );

  static const none = BorderSet(
    topLeft: '',
    top: '',
    topRight: '',
    right: '',
    left: '',
    bottomLeft: '',
    bottom: '',
    bottomRight: '',
    topMid: '',
    bottomMid: '',
    midLeft: '',
    midRight: '',
    center: '',
    middle: '',
    vertical: '',
  );

  /// Cria uma cópia deste BorderSet substituindo os campos fornecidos.
  BorderSet copyWith({
    String? topLeft,
    String? top,
    String? topRight,
    String? right,
    String? bottomRight,
    String? bottom,
    String? bottomLeft,
    String? left,
    String? topMid,
    String? bottomMid,
    String? midLeft,
    String? midRight,
    String? center,
    String? middle,
    String? vertical,
    String? titleLeft,
    String? titleRight,
  }) {
    return BorderSet(
      topLeft: topLeft ?? this.topLeft,
      top: top ?? this.top,
      topRight: topRight ?? this.topRight,
      right: right ?? this.right,
      bottomRight: bottomRight ?? this.bottomRight,
      bottom: bottom ?? this.bottom,
      bottomLeft: bottomLeft ?? this.bottomLeft,
      left: left ?? this.left,
      topMid: topMid ?? this.topMid,
      bottomMid: bottomMid ?? this.bottomMid,
      midLeft: midLeft ?? this.midLeft,
      midRight: midRight ?? this.midRight,
      center: center ?? this.center,
      middle: middle ?? this.middle,
      vertical: vertical ?? this.vertical,
      titleLeft: titleLeft ?? this.titleLeft,
      titleRight: titleRight ?? this.titleRight,
    );
  }
}

// =============================================================================
// ADAPTADOR PARA WIZARD (Extension)
// =============================================================================

/// Esta extensão permite usar o BorderSet no contexto do Wizard
/// mantendo a semântica correta (horizontal, treeConnector, etc).
extension WizardBorderAdapter on BorderSet {
  /// No Wizard, a linha horizontal principal é a 'top' ou 'bottom' (geralmente iguais)
  String get horizontal => top;

  /// O conector da árvore (ex: ├) é semanticamente o midLeft em tabelas.
  String get treeConnector => midLeft;
}
