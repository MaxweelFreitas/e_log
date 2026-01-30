import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../shared/border_set.dart';
import '../../../shared/fill_set.dart';
import 'block_style.dart';

/// Presets prontos para o EBlockBuilder.
/// Sincronizado com ChartPresets, TablePresets e ProgressPresets.
class BlockPresets {
  const BlockPresets._();

  // ===========================================================================
  // 1. ESTILOS BÁSICOS E ESTRUTURAIS
  // ===========================================================================

  /// Clássico: Barra padrão do terminal.
  static final classic = BlockStyle(
    borderChar: BorderSet.single.vertical, // '│'
    borderColor: XTermColor.blue,
  );

  /// Block: Barra grossa e sólida.
  static final block = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
  );

  /// Thin: Barra fina e elegante.
  static final thin = BlockStyle(
    borderChar: BorderSet.single.vertical, // '│'
    borderColor: XTermColor.cyan,
    showPaddingLines: false,
  );

  /// Round: Simula borda arredondada (usando barra bold).
  static final round = BlockStyle(
    borderChar: BorderSet.heavy.vertical, // '┃'
    borderColor: XTermColor.magenta,
  );

  /// Heavy: Barra pesada.
  static const heavy = BlockStyle(
    borderChar: '▌',
    borderColor: XTermColor.yellow,
  );

  /// Double: Estilo DOS com linha dupla.
  static final double = BlockStyle(
    borderChar: BorderSet.double.vertical, // '║'
    borderColor: XTermColor.brightMagenta,
  );

  // ===========================================================================
  // 2. RETRO / ASCII / MINIMAL
  // ===========================================================================

  /// ASCII: Usando Pipe simples.
  static final ascii = BlockStyle(
    borderChar: BorderSet.ascii.vertical, // '|'
    borderColor: XTermColor.green,
  );

  /// Pipe: Estilo "Wall", amarelo queimado.
  static final pipe = BlockStyle(
    borderChar: BorderSet.double.vertical, // '║'
    borderColor: XTermColor.rgb(215, 175, 0), // Ouro
  );

  /// Clean: Apenas uma linha fina, foco no texto.
  static final clean = BlockStyle(
    borderChar: BorderSet.single.vertical, // '│'
    textColor: XTermStyle.bold,
  );

  /// Minimal: Cinza discreto.
  static const minimal = BlockStyle(
    borderChar: '┊', // Específico
    borderColor: XTermColor.brightBlack,
    textColor: XTermColor.brightBlack,
  );

  // ===========================================================================
  // 3. SEMÂNTICOS
  // ===========================================================================

  /// Sucesso (Verde)
  static final success = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.green,
    textColor: XTermColor.green,
  );

  /// Alerta (Amarelo)
  static final warning = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.yellow,
    textColor: XTermColor.yellow,
  );

  /// Erro (Vermelho)
  static final error = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.red,
    textColor: XTermColor.red,
  );

  /// Info (Azul)
  static final info = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.cyan,
    textColor: XTermColor.cyan,
  );

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS
  // ===========================================================================

  /// Citação: Barra cinza, texto itálico.
  static const quote = BlockStyle(
    borderChar: '❝',
    borderColor: XTermColor.brightBlack,
    textColor: XTermStyle.italic + XTermColor.brightWhite,
    showPaddingLines: false,
  );

  /// Matrix: Verde Neon sobre Verde Escuro.
  static final matrix = BlockStyle(
    borderChar: BorderSet.double.vertical, // '║'
    borderColor: XTermColor.rgb(0, 255, 0), // Neon Green
    textColor: XTermColor.green,
  );

  /// Neon: Cyberpunk Vibe.
  static final neon = BlockStyle(
    borderChar: BorderSet.single.vertical, // '│'
    borderColor: XTermColor.rgb(255, 0, 255), // Magenta
    textColor: XTermColor.rgb(0, 255, 255), // Cyan
  );

  /// Fire: Laranja e Vermelho.
  static final fire = BlockStyle(
    borderChar: FillSet.block.high, // '▓'
    borderColor: XTermColor.rgb(255, 69, 0), // OrangeRed
    textColor: XTermColor.rgb(255, 255, 0), // Yellow
  );

  /// Forest: Tons de Verde.
  static final forest = BlockStyle(
    borderChar: '🌲',
    borderColor: XTermColor.rgb(34, 139, 34), // ForestGreen
    textColor: XTermColor.rgb(144, 238, 144), // LightGreen
  );

  /// Amber: Monitor monocromático.
  static final amber = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.rgb(255, 176, 0),
    textColor: XTermColor.rgb(255, 176, 0),
  );

  // ===========================================================================
  // 5. TEMAS RGB / TRUECOLOR
  // ===========================================================================

  /// Dracula: Roxo e Rosa.
  static final dracula = BlockStyle(
    borderChar: '▌',
    borderColor: XTermColor.rgb(189, 147, 249), // Purple
    textColor: XTermColor.rgb(255, 121, 198), // Pink
  );

  /// Cyberpunk: Ciano e Amarelo.
  static final cyberpunk = BlockStyle(
    borderChar: FillSet.block.solid, // '█'
    borderColor: XTermColor.cyan,
    textColor: XTermColor.rgb(254, 244, 9), // Yellow
  );

  /// Yaru: Laranja Ubuntu.
  static final yaru = BlockStyle(
    borderChar: '▋',
    borderColor: XTermColor.rgb(233, 84, 32),
    textColor: XTermColor.white,
  );

  /// Oceanic: Azul Profundo.
  static final oceanic = BlockStyle(
    borderChar: BorderSet.single.vertical, // '│'
    borderColor: XTermColor.rgb(0, 150, 200),
    textColor: XTermColor.rgb(200, 240, 255),
  );

  /// Monokai: Verde e Rosa.
  static final monokai = BlockStyle(
    borderChar: '▰',
    borderColor: XTermColor.rgb(166, 226, 46), // Green
    textColor: XTermColor.white,
  );

  /// Vercel: Preto e Branco Minimalista.
  static const vercel = BlockStyle(
    borderChar: '▲',
    textColor: XTermColor.white,
  );

  /// Solarized: Ciano e Violeta.
  static final solarized = BlockStyle(
    borderChar: '◉',
    borderColor: XTermColor.rgb(42, 161, 152), // Cyan
    textColor: XTermColor.rgb(133, 153, 0), // Green
  );

  /// Candy: Rosa Doce.
  static final candy = BlockStyle(
    borderChar: '♥',
    borderColor: XTermColor.rgb(255, 105, 180), // Hot Pink
    textColor: XTermColor.rgb(135, 206, 250), // Sky Blue
  );
}
