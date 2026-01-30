import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import 'table_style.dart';

/// Coleção de temas prontos para o ETableBuilder.
class TablePresets {
  const TablePresets._();

  // ===========================================================================
  // 1. ESTILOS ESTRUTURAIS & CLÁSSICOS
  // ===========================================================================

  static const classic = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.brightBlack,
    headerColor: XTermColor.cyan,
  );

  static const rounded = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.blue,
    headerColor: XTermColor.brightWhite,
  );

  static const heavy = TableStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.white,
    headerColor: XTermColor.yellow,
  );

  static const double = TableStyle(
    border: BorderSet.double,
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.brightMagenta,
  );

  static const ascii = TableStyle(
    border: BorderSet.ascii,
    headerColor: XTermColor.green,
  );

  static const minimal = TableStyle(
    border: BorderSet(
      topLeft: '',
      top: '─',
      topRight: '',
      right: '',
      left: '',
      bottomLeft: '',
      bottom: '─',
      bottomRight: '',
      topMid: '─',
      bottomMid: '─',
      midLeft: '',
      midRight: '',
      center: '─',
      middle: '─',
      vertical: ' ',
    ),
    borderColor: XTermColor.brightBlack,
    headerColor: XTermColor.white,
  );

  // ===========================================================================
  // 2. TEMAS SEMÂNTICOS (SOLID & OUTLINE)
  // ===========================================================================

  // --- SUCCESS ---
  static const success = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.green,
    headerColor: XTermColor.white,
    headerBackground: XTermColor.bgGreen,
    contentColor: XTermColor.green,
  );

  static const successOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.green,
    headerColor: XTermColor.green,
  );

  // --- WARNING ---
  static const warning = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.yellow,
    headerColor: XTermColor.black,
    headerBackground: XTermColor.bgYellow,
    contentColor: XTermColor.yellow,
  );

  static const warningOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.yellow,
    headerColor: XTermColor.yellow,
  );

  // --- ERROR ---
  static const error = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.red,
    headerColor: XTermColor.white,
    headerBackground: XTermColor.bgRed,
    contentColor: XTermColor.red,
  );

  static const errorOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.red,
    headerColor: XTermColor.red,
  );

  // ===========================================================================
  // 3. TEMAS ESTILIZADOS (SOLID & OUTLINE)
  // ===========================================================================

  // --- MATRIX ---
  static const matrix = TableStyle(
    border: BorderSet.double,
    borderColor: XTermColor.green,
    headerColor: XTermColor.black,
    headerBackground: XTermColor.bgGreen,
    contentColor: XTermColor.brightGreen,
    contentBackground: XTermColor.bgBlack,
  );

  static const matrixOutline = TableStyle(
    border: BorderSet.double,
    borderColor: XTermColor.green,
    headerColor: XTermColor.brightGreen,
    contentColor: XTermColor.green,
  );

  // --- NEON ---
  static final neon = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.white,
    headerBackground: XTermColor.bgMagenta,
    contentColor: XTermColor.cyan,
    contentBackground: XTermColor.rgbBg(20, 20, 40),
  );

  static const neonOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.magenta,
    contentColor: XTermColor.cyan,
  );

  // --- FIRE ---
  static final fire = TableStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.rgb(100, 50, 50),
    headerColor: XTermColor.rgb(255, 255, 0),
    headerBackground: XTermColor.rgbBg(150, 50, 50),
    contentColor: XTermColor.rgb(255, 200, 200),
    contentBackground: XTermColor.rgbBg(60, 20, 20),
  );

  static final fireOutline = TableStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.rgb(255, 50, 50),
    headerColor: XTermColor.rgb(255, 255, 0),
  );

  // --- FOREST ---
  static final forest = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(34, 139, 34),
    headerColor: XTermColor.white,
    headerBackground: XTermColor.rgbBg(34, 139, 34),
    contentColor: XTermColor.rgb(144, 238, 144),
    contentBackground: XTermColor.rgbBg(10, 40, 10),
  );

  static final forestOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(34, 139, 34),
    headerColor: XTermColor.rgb(34, 139, 34),
    contentColor: XTermColor.rgb(144, 238, 144),
  );

  // --- AMBER (ADICIONADO) ---
  static final amber = TableStyle(
    border: BorderSet.double,
    borderColor: XTermColor.rgb(255, 176, 0),
    headerColor: XTermColor.black,
    headerBackground: XTermColor.rgbBg(255, 176, 0),
    contentColor: XTermColor.rgb(255, 176, 0),
    contentBackground: XTermColor.bgBlack,
  );

  static final amberOutline = TableStyle(
    border: BorderSet.double,
    borderColor: XTermColor.rgb(255, 176, 0),
    headerColor: XTermColor.rgb(255, 200, 0),
    contentColor: XTermColor.rgb(184, 134, 11),
  );

  // ===========================================================================
  // 4. TEMAS RGB / TRUECOLOR (SOLID & OUTLINE)
  // ===========================================================================

  // --- DRACULA ---
  static final dracula = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(98, 114, 164),
    headerColor: XTermColor.rgb(255, 255, 255),
    headerBackground: XTermColor.rgbBg(68, 71, 90),
    contentColor: XTermColor.rgb(248, 248, 242),
    contentBackground: XTermColor.rgbBg(40, 42, 54),
  );

  static final draculaOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(189, 147, 249),
    headerColor: XTermColor.rgb(255, 121, 198),
    contentColor: XTermColor.rgb(248, 248, 242),
  );

  // --- CYBERPUNK ---
  static const cyberpunk = TableStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.black,
    headerBackground: XTermColor.bgYellow,
    contentColor: XTermColor.cyan,
    contentBackground: XTermColor.bgBlack,
  );

  static final cyberpunkOutline = TableStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.rgb(255, 255, 0),
    contentColor: XTermColor.cyan,
  );

  // --- YARU ---
  static final yaru = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.rgb(119, 41, 83),
    headerColor: XTermColor.white,
    headerBackground: XTermColor.rgbBg(233, 84, 32),
    contentColor: XTermColor.white,
    contentBackground: XTermColor.rgbBg(48, 10, 36),
  );

  static final yaruOutline = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.rgb(233, 84, 32),
    headerColor: XTermColor.rgb(233, 84, 32),
  );

  // --- OCEANIC ---
  static final oceanic = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.rgb(0, 150, 200),
    headerColor: XTermColor.white,
    headerBackground: XTermColor.rgbBg(0, 100, 150),
    contentColor: XTermColor.rgb(200, 240, 255),
    contentBackground: XTermColor.rgbBg(0, 40, 70),
  );

  static final oceanicOutline = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.rgb(0, 150, 200),
    headerColor: XTermColor.rgb(0, 200, 255),
  );

  // --- MONOKAI ---
  static final monokai = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(73, 72, 62),
    headerColor: XTermColor.rgb(249, 38, 114),
    headerBackground: XTermColor.rgbBg(39, 40, 34),
    contentColor: XTermColor.rgb(230, 219, 116),
    contentBackground: XTermColor.rgbBg(39, 40, 34),
  );

  static final monokaiOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.brightBlack,
    headerColor: XTermColor.rgb(249, 38, 114),
    contentColor: XTermColor.rgb(230, 219, 116),
  );

  // --- VERCEL ---
  static final vercel = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.rgb(50, 50, 50),
    headerColor: XTermColor.black,
    headerBackground: XTermColor.bgWhite,
    contentColor: XTermColor.white,
    contentBackground: XTermColor.bgBlack,
  );

  static final vercelOutline = TableStyle(
    border: BorderSet.single,
    borderColor: XTermColor.white,
    headerColor: XTermColor.white,
    contentColor: XTermColor.rgb(200, 200, 200),
  );

  // --- SOLARIZED ---
  static final solarized = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(147, 161, 161),
    headerColor: XTermColor.rgb(253, 246, 227),
    headerBackground: XTermColor.rgbBg(88, 110, 117),
    contentColor: XTermColor.rgb(101, 123, 131),
    contentBackground: XTermColor.rgbBg(253, 246, 227),
  );

  static final solarizedOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(88, 110, 117), // Cinza Base01 (Borda discreta)
    headerColor: XTermColor.rgb(181, 137, 0), // Amarelo (Destaque Header)
    contentColor: XTermColor.rgb(42, 161, 152), // Ciano (Texto)
  );

  // --- CANDY (CORRIGIDO) ---
  static final candy = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(255, 105, 180),
    headerColor: XTermColor.white,
    headerBackground: XTermColor.rgbBg(255, 105, 180),
    contentColor: XTermColor.rgb(75, 0, 130),
    contentBackground: XTermColor.rgbBg(255, 240, 245),
  );

  /// Candy Outline agora usa paleta "Cotton Candy":
  /// Borda: Rosa | Header: Azul Céu | Texto: Branco
  static final candyOutline = TableStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.rgb(255, 105, 180), // Hot Pink
    headerColor: XTermColor.rgb(135, 206, 250), // Light Sky Blue (Contraste)
    contentColor: XTermColor.rgb(255, 255, 255), // Branco (Leitura limpa)
  );
}
