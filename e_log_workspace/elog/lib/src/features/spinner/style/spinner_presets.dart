import '../spinner_frame.dart';
import '../spinner_set.dart';

/// Presets oficiais de spinners do Ascy.
class SpinnerPresets {
  const SpinnerPresets._();

  // ─────────────────────────────────────────────
  // DOTS
  // ─────────────────────────────────────────────
  static const dots = SpinnerSet(
    name: 'dots',
    frames: [SpinnerFrame('.  '), SpinnerFrame('.. '), SpinnerFrame('...')],
  );

  static const dots2 = SpinnerSet(
    name: 'dots2',
    frames: [
      SpinnerFrame('⠋'),
      SpinnerFrame('⠙'),
      SpinnerFrame('⠹'),
      SpinnerFrame('⠸'),
      SpinnerFrame('⠼'),
      SpinnerFrame('⠴'),
      SpinnerFrame('⠦'),
      SpinnerFrame('⠧'),
      SpinnerFrame('⠇'),
      SpinnerFrame('⠏'),
    ],
  );

  static const dots3 = SpinnerSet(
    name: 'dots3',
    frames: [
      SpinnerFrame('⣷'),
      SpinnerFrame('⣯'),
      SpinnerFrame('⣟'),
      SpinnerFrame('⡿'),
      SpinnerFrame('⢿'),
      SpinnerFrame('⣻'),
      SpinnerFrame('⣾'),
      SpinnerFrame('⣽'),
      //
    ],
  );

  // ─────────────────────────────────────────────
  // LINE / BAR
  // ─────────────────────────────────────────────

  static const line = SpinnerSet(
    name: 'line',
    intervalMs: 100,
    frames: [
      SpinnerFrame('|'),
      SpinnerFrame('/'),
      SpinnerFrame('-'),
      SpinnerFrame('\\'),
    ],
  );

  static const bar = SpinnerSet(
    name: 'bar',
    intervalMs: 100,
    frames: [
      SpinnerFrame('▁'),
      SpinnerFrame('▂'),
      SpinnerFrame('▃'),
      SpinnerFrame('▄'),
      SpinnerFrame('▅'),
      SpinnerFrame('▆'),
      SpinnerFrame('▇'),
      SpinnerFrame('█'),
      SpinnerFrame('▇'),
      SpinnerFrame('▆'),
      SpinnerFrame('▅'),
      SpinnerFrame('▄'),
      SpinnerFrame('▃'),
      SpinnerFrame('▂'),
    ],
  );

  static const pulse = SpinnerSet(
    name: 'pulse',
    frames: [
      SpinnerFrame('█'),
      SpinnerFrame('▓'),
      SpinnerFrame('▒'),
      SpinnerFrame('░'),
    ],
  );

  // ─────────────────────────────────────────────
  // ARROWS / FLOW
  // ─────────────────────────────────────────────

  static const arrow = SpinnerSet(
    name: 'arrow',
    intervalMs: 120,
    frames: [
      SpinnerFrame('←'),
      SpinnerFrame('↖'),
      SpinnerFrame('↑'),
      SpinnerFrame('↗'),
      SpinnerFrame('→'),
      SpinnerFrame('↘'),
      SpinnerFrame('↓'),
      SpinnerFrame('↙'),
    ],
  );

  static const bounce = SpinnerSet(
    name: 'bounce',
    intervalMs: 120,
    frames: [
      SpinnerFrame('⠁'),
      SpinnerFrame('⠂'),
      SpinnerFrame('⠄'),
      SpinnerFrame('⠂'),
    ],
  );

  // ─────────────────────────────────────────────
  // NATURE / EMOJI
  // ─────────────────────────────────────────────

  static const moon = SpinnerSet(
    name: 'moon',
    intervalMs: 150,
    frames: [
      SpinnerFrame('🌑'),
      SpinnerFrame('🌒'),
      SpinnerFrame('🌓'),
      SpinnerFrame('🌔'),
      SpinnerFrame('🌕'),
      SpinnerFrame('🌖'),
      SpinnerFrame('🌗'),
      SpinnerFrame('🌘'),
    ],
  );

  static const earth = SpinnerSet(
    name: 'earth',
    intervalMs: 180,
    frames: [SpinnerFrame('🌍'), SpinnerFrame('🌎'), SpinnerFrame('🌏')],
  );

  /// Relógio
  static const clock = SpinnerSet(
    name: 'clock',
    frames: [
      SpinnerFrame('🕛'),
      SpinnerFrame('🕐'),
      SpinnerFrame('🕑'),
      SpinnerFrame('🕒'),
      SpinnerFrame('🕓'),
      SpinnerFrame('🕔'),
      SpinnerFrame('🕕'),
      SpinnerFrame('🕖'),
      SpinnerFrame('🕗'),
      SpinnerFrame('🕘'),
      SpinnerFrame('🕙'),
      SpinnerFrame('🕚'),
    ],
  );

  // ─────────────────────────────────────────────
  // SHAPES
  // ─────────────────────────────────────────────

  /// Spinner circular
  static const circle = SpinnerSet(
    name: 'circle',
    frames: [
      SpinnerFrame('◐'),
      SpinnerFrame('◓'),
      SpinnerFrame('◑'),
      SpinnerFrame('◒'),
    ],
  );

  /// Arco girando
  static const arc = SpinnerSet(
    name: 'arc',
    frames: [
      SpinnerFrame('◜'),
      SpinnerFrame('◠'),
      SpinnerFrame('◝'),
      SpinnerFrame('◞'),
      SpinnerFrame('◡'),
      SpinnerFrame('◟'),
    ],
  );

  /// Quadrado rotativo
  static const square = SpinnerSet(
    name: 'square',
    frames: [
      SpinnerFrame('◰'),
      SpinnerFrame('◳'),
      SpinnerFrame('◲'),
      SpinnerFrame('◱'),
    ],
  );

  /// Minimal (1 char)
  static const minimal = SpinnerSet(
    name: 'minimal',
    frames: [
      SpinnerFrame('·'),
      SpinnerFrame('•'),
      SpinnerFrame('●'),
      SpinnerFrame('•'),
    ],
  );

  /// Loader pesado
  static const heavy = SpinnerSet(
    name: 'heavy',
    frames: [
      SpinnerFrame('▖'),
      SpinnerFrame('▘'),
      SpinnerFrame('▝'),
      SpinnerFrame('▗'),
    ],
  );

  /// Pontos saltando
  static const jumpingDots = SpinnerSet(
    name: 'jumpingDots',
    frames: [
      SpinnerFrame('⠁'),
      SpinnerFrame('⠂'),
      SpinnerFrame('⠄'),
      SpinnerFrame('⠂'),
      SpinnerFrame('⠁'),
    ],
  );

  // ─────────────────────────────────────────────
  // FUN / CHARACTERS (NOVOS)
  // ─────────────────────────────────────────────

  /// Robot piscando
  static const robot = SpinnerSet(
    name: 'robot',
    intervalMs: 250,
    frames: [
      SpinnerFrame('[ >_• ]'), // Olho aberto
      SpinnerFrame('[ >_• ]'), // Olho aberto
      SpinnerFrame('[ >_< ]'), // Pisca forte
      SpinnerFrame('[ >_• ]'), // Olho aberto
      SpinnerFrame('[ >_• ]'), // Olho aberto
      SpinnerFrame('[ >_- ]'), // Pisca leve
    ],
  );

  /// Caranguejo andando
  static const crab = SpinnerSet(
    name: 'crab',
    intervalMs: 120,
    frames: [
      SpinnerFrame('🦀      '),
      SpinnerFrame(' 🦀     '),
      SpinnerFrame('  🦀    '),
      SpinnerFrame('   🦀   '),
      SpinnerFrame('    🦀  '),
      SpinnerFrame('     🦀 '),
      SpinnerFrame('    🦀  '),
      SpinnerFrame('   🦀   '),
      SpinnerFrame('  🦀    '),
      SpinnerFrame(' 🦀     '),
      SpinnerFrame('🦀      '),
    ],
  );

  /// Emoji Dance
  static const dance = SpinnerSet(
    name: 'dance',
    intervalMs: 200,
    frames: [
      SpinnerFrame('(>_<)'),
      SpinnerFrame('(^o^)'),
      SpinnerFrame('(<_>)'),
      SpinnerFrame('(^_^)'),
    ],
  );

  // ─────────────────────────────────────────────
  // UTIL
  // ─────────────────────────────────────────────

  /// Lista completa de presets
  static const all = [
    // Dots
    dots, dots2, dots3, jumpingDots,
    // Line/Bar
    line, bar, pulse, heavy, minimal,
    // Shapes
    circle, arc, square, arrow, bounce,
    // Nature
    moon, earth, clock,
    // Fun
    robot, dance, crab
  ];

  /// Busca um preset pelo nome
  static SpinnerSet? byName(String name) {
    for (final spinner in all) {
      if (spinner.name == name) return spinner;
    }
    return null;
  }
}
