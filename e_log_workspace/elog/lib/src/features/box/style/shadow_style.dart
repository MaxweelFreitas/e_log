import '../../../base/x_term/x_term_color.dart';
import '../../../utils/color_utils.dart';

/// Define o visual da sombra (Caractere + Cor).
class ShadowStyle {
  final String char;
  final String color;
  final Rgb? gradientStart;
  final Rgb? gradientEnd;
  final GradientDirection direction;

  const ShadowStyle({
    required this.char,
    this.color = XTermColor.brightBlack,
    this.gradientStart,
    this.gradientEnd,
    this.direction = GradientDirection.horizontal,
  });

  bool get isGradient => gradientStart != null && gradientEnd != null;

  // ---------------------------------------------------------------------------
  // PRESETS DE SOMBRA
  // ---------------------------------------------------------------------------

  /// Leve (Padrão): ░
  static const light = ShadowStyle(char: '░');

  /// Média: ▒
  static const medium = ShadowStyle(char: '▒');

  /// Densa: ▓
  static const dense = ShadowStyle(char: '▓');

  /// Sólida: Bloco cheio (█)
  static const solid = ShadowStyle(char: '█');

  /// Transparente/Fundo: Usa espaço vazio mas pinta o fundo
  /// (Ideal para terminais modernos)
  static const bg = ShadowStyle(char: ' ', color: XTermColor.black);
}
