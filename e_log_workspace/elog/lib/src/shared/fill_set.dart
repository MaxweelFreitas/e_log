/// Define conjuntos de caracteres para preenchimento (Fill/Block elements).
class FillSet {
  final String solid; // █
  final String high; // ▓ (75%)
  final String medium; // ▒ (50%)
  final String low; // ░ (25%)
  final String empty; //   (0% ou espaço)

  // Variantes horizontais (para gráficos/progress)
  final String hBar; // ━ (Horizontal Bar)
  final String hDouble; // ═
  final String hDash; // ╌

  const FillSet({
    required this.solid,
    required this.high,
    required this.medium,
    required this.low,
    required this.empty,
    this.hBar = '─',
    this.hDouble = '═',
    this.hDash = '-',
  });

  /// 1. BLOCK: Os clássicos do UTF-8.
  static const block = FillSet(
    solid: '█',
    high: '▓',
    medium: '▒',
    low: '░',
    empty: ' ',
  );

  /// 2. ASCII: Para compatibilidade total.
  static const ascii = FillSet(
    solid: '#',
    high: '=',
    medium: '-',
    low: '.',
    empty: ' ',
    hBar: '-',
    hDouble: '=',
  );

  /// 3. GEOMETRIC: Formas alternativas.
  static const geometric = FillSet(
    solid: '■',
    high: '▧',
    medium: '▪',
    low: '□',
    empty: ' ',
  );

  /// 4. THIN: Linhas finas (para gráficos minimalistas).
  static const thin = FillSet(
    solid: '━',
    high: '─',
    medium: '·',
    low: ' ',
    empty: ' ',
  );
}
