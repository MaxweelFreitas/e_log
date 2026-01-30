import '../../../base/x_term/x_term_color.dart';
import 'e_api_style.dart';

/// Coleção de temas prontos para o EApiBuilder.
class EApiPresets {
  const EApiPresets._();

  // ─────────────────────────────────────────────
  // 1. CLÁSSICOS & BÁSICOS
  // ─────────────────────────────────────────────

  static final standard = EApiStyle.standard();

  static const classic = EApiStyle(
    borderColor: XTermColor.blue,
    headerColor: XTermColor.brightWhite,
    treeStructureColor: XTermColor.brightBlack, // Cinza discreto
    keyColor: XTermColor.cyan,
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.bgBlue,
  );

  static const minimal = EApiStyle(
    borderColor: XTermColor.brightBlack,
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.brightBlack,
    keyColor: XTermColor.brightWhite,
    valueColor: XTermColor.white,
    // Sem backgrounds para ser minimalista
  );

  // ─────────────────────────────────────────────
  // 2. SEMÂNTICOS
  // ─────────────────────────────────────────────

  static const success = EApiStyle(
    borderColor: XTermColor.green,
    headerColor: XTermColor.brightWhite,
    treeStructureColor: XTermColor.green,
    keyColor: XTermColor.brightGreen,
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.bgGreen,
  );

  static const warning = EApiStyle(
    borderColor: XTermColor.yellow,
    headerColor: XTermColor.black,
    treeStructureColor: XTermColor.yellow,
    keyColor: XTermColor.yellow,
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.bgYellow,
  );

  static final error = EApiStyle.error();

  static const info = EApiStyle(
    borderColor: XTermColor.cyan,
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.cyan,
    keyColor: XTermColor.brightCyan,
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.bgCyan,
  );

  // ─────────────────────────────────────────────
  // 3. ESTILIZADOS
  // ─────────────────────────────────────────────

  /// **Matrix**
  static final matrix = EApiStyle(
    borderColor: XTermColor.green,
    headerColor: XTermColor.black,
    treeStructureColor: XTermColor.rgb(0, 100, 0), // Verde escuro para linhas
    keyColor: XTermColor.brightGreen,
    valueColor: XTermColor.green,
    titleBackgroundColor: XTermColor.bgGreen,
    contentBackgroundColor: XTermColor.rgbBg(0, 20, 0),
  );

  /// **Neon**
  static const neon = EApiStyle(
    borderColor: XTermColor.magenta,
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.magenta,
    keyColor: XTermColor.brightMagenta,
    valueColor: XTermColor.cyan,
    titleBackgroundColor: XTermColor.bgMagenta,
    contentBackgroundColor: XTermColor.bgBrightBlack,
  );

  /// **Fire**
  static final fire = EApiStyle(
    borderColor: XTermColor.rgb(255, 69, 0),
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(100, 50, 0),
    keyColor: XTermColor.rgb(255, 140, 0), // Orange
    valueColor: XTermColor.rgb(255, 255, 0), // Yellow
    titleBackgroundColor: XTermColor.rgbBg(200, 40, 0),
    contentBackgroundColor: XTermColor.rgbBg(50, 10, 0),
  );

  /// **Forest**
  static final forest = EApiStyle(
    borderColor: XTermColor.rgb(34, 139, 34),
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(20, 80, 20),
    keyColor: XTermColor.rgb(144, 238, 144), // Light Green
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.rgbBg(34, 139, 34),
    contentBackgroundColor: XTermColor.rgbBg(10, 30, 10),
  );

  /// **Amber**
  static final amber = EApiStyle(
    borderColor: XTermColor.rgb(255, 176, 0),
    headerColor: XTermColor.black,
    treeStructureColor: XTermColor.rgb(150, 100, 0),
    keyColor: XTermColor.rgb(255, 176, 0),
    valueColor: XTermColor.rgb(255, 200, 100),
    titleBackgroundColor: XTermColor.rgbBg(255, 176, 0),
    contentBackgroundColor: XTermColor.bgBlack,
  );

  // ─────────────────────────────────────────────
  // 4. TEMAS RGB (TRUECOLOR)
  // ─────────────────────────────────────────────

  /// **Dracula**
  static final dracula = EApiStyle(
    borderColor: XTermColor.rgb(189, 147, 249), // Purple
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(98, 114, 164), // Comment Purple
    keyColor: XTermColor.rgb(255, 121, 198), // Pink
    separatorColor: XTermColor.rgb(139, 233, 253), // Cyan
    valueColor: XTermColor.rgb(241, 250, 140), // Yellow
    titleBackgroundColor: XTermColor.rgbBg(68, 71, 90), // Selection
    contentBackgroundColor: XTermColor.rgbBg(40, 42, 54), // Background
    backgroundColor: XTermColor.rgbBg(40, 42, 54),
  );

  /// **Cyberpunk**
  static final cyberpunk = EApiStyle(
    borderColor: XTermColor.rgb(0, 255, 255), // Cyan
    headerColor: XTermColor.black,
    treeStructureColor: XTermColor.rgb(255, 0, 255), // Magenta
    keyColor: XTermColor.rgb(255, 255, 0), // Yellow
    valueColor: XTermColor.rgb(0, 255, 255), // Cyan
    titleBackgroundColor: XTermColor.bgCyan,
    contentBackgroundColor: XTermColor.rgbBg(20, 20, 20),
  );

  /// **Yaru (Ubuntu)**
  static final yaru = EApiStyle(
    borderColor: XTermColor.rgb(233, 84, 32), // Orange
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(119, 41, 83), // Aubergine
    keyColor: XTermColor.rgb(233, 84, 32), // Orange
    valueColor: XTermColor.white,
    titleBackgroundColor: XTermColor.rgbBg(119, 41, 83),
    contentBackgroundColor: XTermColor.rgbBg(48, 10, 36),
  );

  /// **Oceanic**
  static final oceanic = EApiStyle(
    borderColor: XTermColor.rgb(0, 150, 200),
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(0, 100, 150),
    keyColor: XTermColor.rgb(0, 255, 255), // Cyan
    valueColor: XTermColor.rgb(200, 240, 255), // Light Blue
    titleBackgroundColor: XTermColor.rgbBg(0, 100, 150),
    contentBackgroundColor: XTermColor.rgbBg(0, 40, 70),
  );

  /// **Monokai**
  static final monokai = EApiStyle(
    borderColor: XTermColor.rgb(166, 226, 46), // Green
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(117, 113, 94), // Grey
    keyColor: XTermColor.rgb(249, 38, 114), // Pink
    valueColor: XTermColor.rgb(230, 219, 116), // Yellow
    titleBackgroundColor: XTermColor.rgbBg(39, 40, 34),
    contentBackgroundColor: XTermColor.rgbBg(39, 40, 34),
  );

  /// **Vercel**
  static final vercel = EApiStyle(
    borderColor: XTermColor.white,
    headerColor: XTermColor.black,
    treeStructureColor: XTermColor.rgb(80, 80, 80),
    keyColor: XTermColor.white,
    valueColor: XTermColor.rgb(200, 200, 200),
    titleBackgroundColor: XTermColor.bgWhite,
    contentBackgroundColor: XTermColor.bgBlack,
  );

  /// **Solarized**
  static final solarized = EApiStyle(
    borderColor: XTermColor.rgb(133, 153, 0), // Green
    headerColor: XTermColor.rgb(253, 246, 227), // Light Cream
    treeStructureColor: XTermColor.rgb(88, 110, 117), // Base01
    keyColor: XTermColor.rgb(38, 139, 210), // Blue
    valueColor: XTermColor.rgb(42, 161, 152), // Cyan
    titleBackgroundColor: XTermColor.rgbBg(7, 54, 66), // Base02
    contentBackgroundColor: XTermColor.rgbBg(0, 43, 54), // Base03
  );

  /// **Candy**
  static final candy = EApiStyle(
    borderColor: XTermColor.rgb(255, 105, 180), // Hot Pink
    headerColor: XTermColor.white,
    treeStructureColor: XTermColor.rgb(255, 182, 193), // Light Pink
    keyColor: XTermColor.rgb(255, 105, 180),
    valueColor: XTermColor.rgb(135, 206, 250), // Sky Blue
    titleBackgroundColor: XTermColor.rgbBg(255, 105, 180),
    contentBackgroundColor: XTermColor.rgbBg(50, 20, 40), // Dark Purple BG
  );

  /// Lista completa de todos os presets.
  static final all = [
    standard,
    classic,
    minimal,
    success,
    warning,
    error,
    info,
    matrix,
    neon,
    fire,
    forest,
    amber,
    dracula,
    cyberpunk,
    yaru,
    oceanic,
    monokai,
    vercel,
    solarized,
    candy,
  ];
}
