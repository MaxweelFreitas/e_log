import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../shared/border_set.dart';
import '../../../shared/fill_set.dart';
import '../../../utils/color_utils.dart';
import 'box_style.dart';
import 'shadow_style.dart';

/// Coleção de temas prontos para o EBoxBuilder.
class BoxPresets {
  const BoxPresets._();

  // ===========================================================================
  // 1. ESTILOS BÁSICOS & ESTRUTURAIS
  // ===========================================================================

  static const standard = BoxStyle();

  static const rounded = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.blue,
  );

  static const heavy = BoxStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.white,
  );

  static const double = BoxStyle(
    border: BorderSet.double,
    borderColor: XTermColor.brightMagenta,
  );

  static const lightDouble = BoxStyle(
    border: BorderSet.lightDouble,
    borderColor: XTermColor.cyan,
  );

  // ===========================================================================
  // 2. RETRO / ASCII / MINIMAL
  // ===========================================================================

  static const ascii = BoxStyle(
    border: BorderSet.ascii,
    borderColor: XTermColor.brightBlack,
  );

  static const dotted = BoxStyle(
    border: BorderSet.dotted,
    borderColor: XTermColor.brightBlack,
  );

  static const dashed = BoxStyle(
    border: BorderSet.dashed,
    borderColor: XTermColor.brightBlack,
  );

  static const mixed = BoxStyle(
    border: BorderSet.mixed,
    borderColor: XTermColor.yellow,
  );

  // ===========================================================================
  // 3. SEMÂNTICOS (STATUS)
  // ===========================================================================

  static const success = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.green,
    titleColor: XTermColor.green,
  );

  static const warning = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.yellow,
    titleColor: XTermColor.yellow,
  );

  static const error = BoxStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.red,
    titleColor: XTermColor.red,
  );

  static const info = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.cyan,
    titleColor: XTermColor.cyan,
  );

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS (GRADIENTES ORGÂNICOS)
  // ===========================================================================

  /// Matrix: Verde digital. Fundo sólido para contraste do código.
  static final matrix = BoxStyle(
    border: BorderSet.double,
    borderColor: XTermColor.green,
    backgroundColor: XTermColor.rgbBg(0, 20, 0),
    shadow: const ShadowStyle(char: '0', color: XTermColor.green),
  );

  /// Neon: Cyberpunk Vibe.
  static final neon = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.magenta,
    backgroundColor: XTermColor.bgBlack,
    shadow: ShadowStyle(
      char: FillSet.block.low,
      color: XTermColor.cyan,
    ),
  );

  /// Fire: Gradiente Diagonal (Rising Flames).
  /// De Vermelho Escuro (Base) para Laranja Queimado (Topo/Direita).
  static final fire = BoxStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.rgb(255, 69, 0), // OrangeRed
    titleColor: XTermColor.rgb(255, 255, 0), // Yellow
    backgroundGradientStart: const Rgb(80, 10, 0), // Deep Red
    backgroundGradientEnd: const Rgb(160, 60, 0), // Fire Orange
    backgroundGradientDir: GradientDirection.diagonalBack, // ↙️ para ↗️
  );

  /// Forest: Gradiente Diagonal (Sunlight).
  /// De Verde Escuro para Verde Lima suave.
  static final forest = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(34, 139, 34),
    backgroundGradientStart: const Rgb(10, 40, 10), // Deep Forest
    backgroundGradientEnd: const Rgb(40, 80, 20), // Sunlight Leaves
    backgroundGradientDir: GradientDirection.diagonal, // ↖️ para ↘️
  );

  /// Oceanic: Gradiente Vertical (Profundidade).
  /// Fundo do mar (escuro) subindo para a superfície (mais claro).
  static final oceanic = BoxStyle(
    borderColor: XTermColor.rgb(0, 150, 200),
    backgroundGradientStart: const Rgb(0, 15, 30), // Abyss
    backgroundGradientEnd: const Rgb(0, 60, 90), // Surface
  );

  /// Amber: Monitor monocromático retro.
  static final amber = BoxStyle(
    border: BorderSet.double,
    borderColor: XTermColor.rgb(255, 176, 0),
    titleColor: XTermColor.rgb(255, 176, 0),
    backgroundColor: XTermColor.bgBlack,
  );

  // ===========================================================================
  // 5. TEMAS RGB / TRUECOLOR (CARDS)
  // ===========================================================================

  static final dracula = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(189, 147, 249),
    backgroundColor: XTermColor.rgbBg(40, 42, 54),
    shadow: ShadowStyle.bg,
  );

  static final cyberpunk = BoxStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.cyan,
    titleColor: XTermColor.rgb(255, 255, 0),
    backgroundColor: XTermColor.bgBlack,
    shadow: ShadowStyle(
      char: FillSet.block.high,
      color: XTermColor.magenta,
    ),
  );

  static final yaru = BoxStyle(
    borderColor: XTermColor.rgb(233, 84, 32),
    backgroundColor: XTermColor.rgbBg(48, 10, 36),
  );

  static final monokai = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(166, 226, 46),
    backgroundColor: XTermColor.rgbBg(39, 40, 34),
  );

  static const vercel = BoxStyle(
    borderColor: XTermColor.white,
    backgroundColor: XTermColor.bgBlack,
    titleColor: XTermStyle.bold,
  );

  static final solarized = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(133, 153, 0),
    backgroundColor: XTermColor.rgbBg(7, 54, 66),
  );

  static final candy = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(255, 105, 180),
    backgroundColor: XTermColor.rgbBg(50, 20, 40),
    shadow: ShadowStyle(char: '♥ ', color: XTermColor.rgb(255, 20, 147)),
  );

  // ===========================================================================
  // 6. SPECIAL / GRADIENTS
  // ===========================================================================

  /// Rainbow: Diagonal Vibrante. Sombra Horizontal (Espectro).
  static final rainbow = BoxStyle(
    border: BorderSet.double,
    borderColor: XTermColor.white,
    titleColor: XTermColor.white,
    backgroundGradientStart: const Rgb(0, 60, 60),
    backgroundGradientEnd: const Rgb(60, 0, 60),
    backgroundGradientDir: GradientDirection.diagonal,
    shadow: ShadowStyle(
      char: FillSet.block.high,
      gradientStart: const Rgb(0, 255, 255),
      gradientEnd: const Rgb(255, 0, 255),
    ),
  );

  /// Sunset: Diagonal Quente. Sombra Horizontal.
  static final sunset = BoxStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.yellow,
    backgroundGradientStart: const Rgb(100, 40, 0),
    backgroundGradientEnd: const Rgb(40, 0, 60),
    backgroundGradientDir: GradientDirection.diagonal,
    shadow: ShadowStyle(
      char: FillSet.block.high,
      gradientStart: const Rgb(255, 100, 0),
      gradientEnd: const Rgb(100, 0, 255),
    ),
  );

  // ===========================================================================
  // 7. UTILITY
  // ===========================================================================

  static const borderless = BoxStyle(
    border: BorderSet.none,
    padding: 0,
  );

  static const compact = BoxStyle(
    padding: 0,
  );

  static const elevated = BoxStyle(
    border: BorderSet.none,
    shadow: ShadowStyle.medium,
  );
}
