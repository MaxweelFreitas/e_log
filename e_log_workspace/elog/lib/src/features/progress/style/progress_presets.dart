import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../shared/border_set.dart';
import '../../../shared/fill_set.dart';
import 'progress_style.dart';

/// Coleção de temas prontos para o ProgressBuilder.
class ProgressPresets {
  const ProgressPresets._();

  // ===========================================================================
  // 1. ESTILOS BÁSICOS
  // ===========================================================================

  static final classic = ProgressStyle(
    filledChar: FillSet.ascii.hDouble, // '='
    emptyChar: ' ',
    tip: '>',
    textStyle: XTermStyle.underline,
    underlineColor: XTermColor.blue,
    emptyColor: XTermColor.brightBlack, // Fundo cinza
  );

  static final block = ProgressStyle(
    filledChar: FillSet.block.solid, // '█'
    emptyChar: FillSet.block.low, // '░'
    emptyColor: XTermColor.brightBlack, // Fundo cinza
  );

  static const clean = ProgressStyle(
    filledChar: '▰',
    emptyChar: '▱',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack, // Fundo cinza
  );

  static final hash = ProgressStyle(
    filledChar: FillSet.ascii.solid, // '#'
    emptyChar: FillSet.ascii.low, // '.'
    emptyColor: XTermColor.brightBlack, // Fundo cinza
  );

  // ===========================================================================
  // 2. GEOMÉTRICOS
  // ===========================================================================

  static const rect = ProgressStyle(
    filledChar: '▮',
    emptyChar: '▯',
    emptyColor: XTermColor.brightBlack,
  );

  static final shade = ProgressStyle(
    filledChar: FillSet.block.high, // '▓'
    emptyChar: FillSet.block.low, // '░'
    startBorder: BorderSet.single.vertical, // '│'
    endBorder: BorderSet.single.vertical, // '│'
    emptyColor: XTermColor.brightBlack,
  );

  static const circle = ProgressStyle(
    filledChar: '● ',
    emptyChar: '○ ',
    startBorder: '(',
    endBorder: ')',
    emptyColor: XTermColor.brightBlack,
  );

  static const square = ProgressStyle(
    filledChar: '◼ ',
    emptyChar: '◻ ',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack,
  );

  // ===========================================================================
  // 3. CRIATIVOS & FUN
  // ===========================================================================

  static final hearts = ProgressStyle(
    filledChar: '♥ ', emptyChar: '♡ ', startBorder: '', endBorder: '',
    filledColor: XTermColor.red,
    emptyColor: XTermColor.rgb(100, 0, 0), // Vermelho escuro
  );

  static final star = ProgressStyle(
    filledChar: '★ ',
    emptyChar: '☆ ',
    filledColor: XTermColor.yellow,
    // Dourado escuro para a estrela vazia
    emptyColor: XTermColor.rgb(100, 80, 0),
    borderColor: XTermColor.yellow,
  );

  static const dots = ProgressStyle(
    filledChar: '• ',
    emptyChar: '· ',
    startBorder: '(',
    endBorder: ')',
    emptyColor: XTermColor.brightBlack,
  );

  static const arrow = ProgressStyle(
    filledChar: '> ',
    emptyChar: '> ',
    emptyColor: XTermColor.brightBlack,
  );

  static const pacman = ProgressStyle(
    filledChar: ' ', // Vazio (já comeu)
    emptyChar: '•', // Comida
    startBorder: '', endBorder: '',
    tip: 'ᗧ',
    filledColor: XTermColor.yellow,
    emptyColor: XTermColor.white, // Comida branca
    textStyle: XTermStyle.underline,
  );

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS
  // ===========================================================================

  static final matrix = ProgressStyle(
    filledChar: '1', emptyChar: '0', tip: '1',
    filledColor: XTermColor.rgb(0, 255, 0), // Neon Green
    emptyColor: XTermColor.rgb(0, 50, 0), // Dark Green
    borderColor: XTermColor.rgb(0, 255, 0),
  );

  static final neon = ProgressStyle(
    filledChar: '● ', emptyChar: '● ', startBorder: '(', endBorder: ')',
    filledColor: XTermColor.rgb(255, 0, 255), // Magenta Puro
    // Roxo escuro para luz apagada
    emptyColor: XTermColor.rgb(60, 0, 60),
    borderColor: XTermColor.rgb(200, 0, 200),
  );

  static final fire = ProgressStyle(
    filledChar: FillSet.block.high, // '▓'
    emptyChar: FillSet.block.low, // '░'
    startBorder: BorderSet.double.vertical, // '║'
    endBorder: BorderSet.double.vertical, // '║'
    filledColor: XTermColor.rgb(255, 69, 0), // OrangeRed
    emptyColor: XTermColor.rgb(80, 20, 0), // Dark Red Brown
    borderColor: XTermColor.rgb(255, 140, 0),
  );

  static final forest = ProgressStyle(
    filledChar: '▰', emptyChar: '▱', startBorder: '⁅', endBorder: '⁆',
    filledColor: XTermColor.rgb(34, 139, 34), // ForestGreen
    emptyColor: XTermColor.rgb(20, 60, 20), // Dark Forest
    borderColor: XTermColor.rgb(85, 107, 47),
  );

  static final amber = ProgressStyle(
    filledChar: FillSet.block.solid, // '█'
    emptyChar: FillSet.block.low, // '░'
    startBorder: BorderSet.double.vertical, // '║'
    endBorder: BorderSet.double.vertical, // '║'
    filledColor: XTermColor.rgb(255, 191, 0), // Amber
    // Âmbar escuro (quase marrom)
    emptyColor: XTermColor.rgb(80, 60, 0),
    borderColor: XTermColor.rgb(255, 191, 0),
  );

  // ===========================================================================
  // 5. TEMAS RGB / TRUECOLOR
  // ===========================================================================

  static final dracula = ProgressStyle(
    filledChar: '━', emptyChar: '━', startBorder: '╒', endBorder: '╛', tip: '●',
    filledColor: XTermColor.rgb(255, 121, 198), // Pink
    emptyColor: XTermColor.rgb(98, 114, 164), // Grey/Purple
    borderColor: XTermColor.rgb(189, 147, 249),
  );

  static final cyberpunk = ProgressStyle(
    filledChar: '/',
    emptyChar: ' ',
    startBorder: FillSet.block.solid, // '█'
    endBorder: FillSet.block.solid, // '█'
    filledColor: XTermColor.rgb(0, 255, 255), // Cyan
    // Ciano escuro
    emptyColor: XTermColor.rgb(0, 50, 50),
    borderColor: XTermColor.rgb(255, 255, 0),
  );

  static final yaru = ProgressStyle(
    filledChar: '● ', emptyChar: '● ',
    filledColor: XTermColor.rgb(233, 84, 32), // Orange
    // Laranja escuro
    emptyColor: XTermColor.rgb(80, 30, 10),
    borderColor: XTermColor.white,
  );

  static final oceanic = ProgressStyle(
    filledChar: '~', emptyChar: '~',
    filledColor: XTermColor.rgb(0, 210, 255), // Bright Blue
    emptyColor: XTermColor.rgb(0, 50, 80), // Deep Blue
    borderColor: XTermColor.rgb(0, 100, 150),
  );

  static final monokai = ProgressStyle(
    filledChar: '◼ ', emptyChar: '◻ ', startBorder: '❲', endBorder: '❳',
    filledColor: XTermColor.rgb(166, 226, 46), // Green
    emptyColor: XTermColor.rgb(73, 72, 62), // Grey
    borderColor: XTermColor.white,
  );

  static final vercel = ProgressStyle(
    filledChar: '▲ ',
    emptyChar: '△ ',
    startBorder: '',
    endBorder: '',
    filledColor: XTermColor.white,
    emptyColor: XTermColor.rgb(80, 80, 80), // Dark Grey
  );

  static final solarized = ProgressStyle(
    filledChar: '◉ ', emptyChar: '○ ', startBorder: '{', endBorder: '}',
    filledColor: XTermColor.rgb(133, 153, 0), // Green
    emptyColor: XTermColor.rgb(7, 54, 66), // Base02
    borderColor: XTermColor.rgb(42, 161, 152),
  );

  static final candy = ProgressStyle(
    filledChar: '❤ ', emptyChar: '♡ ', startBorder: '(', endBorder: ')',
    filledColor: XTermColor.rgb(255, 105, 180), // Hot Pink
    // Rosa Escuro
    emptyColor: XTermColor.rgb(100, 40, 70),
    borderColor: XTermColor.rgb(255, 20, 147),
  );

  // ===========================================================================
  // 6. RAINBOW ASPECTS
  // ===========================================================================

  static const rainbowLinear = ProgressStyle(
    filledChar: '█',
    emptyChar: ' ',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack,
  );

  static const rainbowFlow = ProgressStyle(
    filledChar: '▓',
    emptyChar: '░',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack,
  );

  static const rainbowDots = ProgressStyle(
    filledChar: '● ',
    emptyChar: '○ ',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack,
  );

  static const rainbowBar = ProgressStyle(
    filledChar: '▬',
    emptyChar: '—',
    startBorder: '',
    endBorder: '',
    emptyColor: XTermColor.brightBlack,
  );

  /// Lista completa de presets para iteração e demos.
  static final all = [
    classic,
    block,
    clean,
    hash,
    rect,
    shade,
    circle,
    square,
    hearts,
    star,
    dots,
    arrow,
    pacman,
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
    rainbowLinear,
    rainbowFlow,
    rainbowDots,
    rainbowBar
  ];
}
