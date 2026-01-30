import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../shared/fill_set.dart';
import '../../../utils/color_utils.dart';
import 'chart_style.dart';

/// Coleção de temas prontos para o EChartBuilder.
/// Sincronizado com TablePresets e ProgressPresets.
class ChartPresets {
  const ChartPresets._();

  // ===========================================================================
  // 1. ESTILOS BÁSICOS E ESTRUTURAIS
  // ===========================================================================

  /// Clássico: Azul padrão do terminal, limpo.
  static const classic = ChartStyle(
    barColor: XTermColor.blue,
  );

  /// Block: Branco sólido, alto contraste.
  static const block = ChartStyle(
    barColor: XTermColor.white,
    labelColor: XTermColor.white,
  );

  /// Thin: Ciano fino, visual técnico.
  static final thin = ChartStyle(
    barChar: FillSet.thin.solid, // '━'
    emptyChar: FillSet.thin.solid, // '━'
    barColor: XTermColor.cyan,
    labelColor: XTermColor.cyan,
    valueColor: XTermColor.white,
  );

  /// Round: Magenta com pontas arredondadas e trilha pontilhada.
  static const round = ChartStyle(
    barChar: '● ',
    emptyChar: '○ ',
    barColor: XTermColor.magenta,
    labelColor: XTermColor.magenta,
    valueColor: XTermColor.brightMagenta,
  );

  /// Heavy: Amarelo pesado, estilo construção.
  static const heavy = ChartStyle(
    barColor: XTermColor.yellow,
    labelColor: XTermColor.yellow,
  );

  /// Double: Estilo clássico de DOS com linhas duplas.
  static const double = ChartStyle(
    barChar: '═',
    emptyChar: '─',
    barColor: XTermColor.brightMagenta,
    labelColor: XTermColor.magenta,
    valueColor: XTermColor.white,
  );

  // ===========================================================================
  // 2. RETRO / ASCII / MINIMAL
  // ===========================================================================

  /// ASCII: Contraste verde terminal antigo.
  static final ascii = ChartStyle(
    barChar: FillSet.ascii.solid, // '#'
    emptyChar: FillSet.ascii.hDash, // '-'
    labelColor: XTermColor.green,
    valueColor: XTermColor.brightGreen,
    emptyColor: XTermColor.green, // Hífen verde escuro (padrão do terminal)
  );

  /// Pipe: Estilo "Wall", amarelo queimado.
  static final pipe = ChartStyle(
    barChar: '|',
    emptyChar: '.',
    barColor: XTermColor.rgb(215, 175, 0), // Ouro
    labelColor: XTermColor.rgb(215, 175, 0),
    valueColor: XTermColor.white,
    emptyColor: XTermColor.rgb(100, 80, 0), // Pontos dourados escuros
  );

  /// Clean: Sem trilha, foco total no dado.
  static const clean = ChartStyle(
    barChar: '■',
    barColor: XTermColor.white,
    labelColor: XTermStyle.bold,
    valueColor: XTermStyle.bold,
  );

  /// Minimal: Cinza discreto para logs secundários.
  static const minimal = ChartStyle(
    barChar: '─',
    barColor: XTermColor.brightBlack, // Cinza escuro
    labelColor: XTermColor.brightBlack,
    valueColor: XTermColor.white,
    emptyColor: XTermColor.black,
  );

  // ===========================================================================
  // 3. TEMAS SEMÂNTICOS
  // ===========================================================================

  /// Sucesso: Verde Vibrante.
  static const success = ChartStyle(
    labelColor: XTermColor.green,
  );

  /// Aviso: Amarelo/Laranja.
  static const warning = ChartStyle(
    barColor: XTermColor.yellow,
    labelColor: XTermColor.yellow,
  );

  /// Erro: Vermelho Intenso.
  static const error = ChartStyle(
    barColor: XTermColor.red,
    labelColor: XTermColor.red,
  );

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS
  // ===========================================================================

  /// Matrix: Do Verde Escuro (Código velho) ao Verde Neon (Código novo)
  static final matrix = ChartStyle(
    barChar: '1',
    emptyChar: '0',
    valueColor: XTermColor.brightGreen,
    labelColor: XTermColor.green,
    gradientStart: const Rgb(0, 50, 0), // Dark Matrix
    gradientEnd: const Rgb(0, 255, 0), // Bright Matrix
    // O '0' vazio fica num verde bem escuro, quase preto
    emptyColor: XTermColor.rgb(0, 50, 0),
  );

  /// Neon: Cyberpunk Vibe (Roxo -> Ciano)
  static const neon = ChartStyle(
    barChar: '● ',
    emptyChar: '● ',
    barColor: XTermColor.magenta,
    labelColor: XTermColor.cyan,
    valueColor: XTermColor.white,
    gradientStart: Rgb(255, 0, 255), // Magenta
    gradientEnd: Rgb(0, 255, 255), // Cyan
    emptyColor: XTermColor.black,
  );

  /// Fire: Do Vermelho Sangue ao Amarelo Fogo
  static final fire = ChartStyle(
    barChar: FillSet.block.high, // '▓'
    emptyChar: FillSet.block.low, // '░'
    barColor: XTermColor.red,
    labelColor: XTermColor.rgb(255, 140, 0),
    valueColor: XTermColor.rgb(255, 255, 0),
    gradientStart: const Rgb(255, 0, 0), // Red
    gradientEnd: const Rgb(255, 255, 0), // Yellow
    // Fundo texturizado em vermelho escuro (brasa fria)
    emptyColor: XTermColor.rgb(100, 20, 0),
  );

  /// Forest: Do Verde Musgo ao Verde Lima
  static final forest = ChartStyle(
    barChar: '▰',
    emptyChar: '▱',
    labelColor: XTermColor.rgb(85, 107, 47),
    valueColor: XTermColor.rgb(144, 238, 144),
    gradientStart: const Rgb(34, 139, 34), // ForestGreen
    gradientEnd: const Rgb(154, 205, 50), // YellowGreen
    // Fundo verde muito escuro
    emptyColor: XTermColor.rgb(20, 50, 20),
  );

  /// Amber: Do Laranja Escuro ao Ouro
  static final amber = ChartStyle(
    emptyChar: '░',
    barColor: XTermColor.rgb(255, 176, 0),
    labelColor: XTermColor.rgb(255, 176, 0),
    valueColor: XTermColor.rgb(255, 215, 0),
    gradientStart: const Rgb(200, 100, 0),
    gradientEnd: const Rgb(255, 215, 0),
    // Fundo âmbar escuro/marrom
    emptyColor: XTermColor.rgb(100, 60, 0),
  );

  // ===========================================================================
  // 5. TEMAS RGB / TRUECOLOR
  // ===========================================================================

  /// Dracula: Roxo Profundo -> Rosa Choque
  static final dracula = ChartStyle(
    barChar: '━',
    emptyChar: '━',
    barColor: XTermColor.rgb(189, 147, 249),
    labelColor: XTermColor.rgb(189, 147, 249),
    valueColor: XTermColor.rgb(248, 248, 242),
    gradientStart: const Rgb(189, 147, 249), // Purple
    gradientEnd: const Rgb(255, 121, 198), // Pink
    // Cor de "Seleção" do Dracula (Cinza azulado)
    emptyColor: XTermColor.rgb(68, 71, 90),
  );

  /// Cyberpunk: Ciano Neon -> Amarelo Ácido
  static final cyberpunk = ChartStyle(
    emptyChar: '▒',
    barColor: XTermColor.cyan,
    labelColor: XTermColor.cyan,
    valueColor: XTermColor.white,
    gradientStart: const Rgb(0, 240, 255), // Cyan
    gradientEnd: const Rgb(254, 244, 9), // Yellow
    // Fundo cinza azulado escuro
    emptyColor: XTermColor.rgb(30, 60, 70),
  );

  /// Yaru: Laranja Quente -> Roxo Beringela
  static final yaru = ChartStyle(
    barChar: '● ',
    emptyChar: '● ',
    barColor: XTermColor.rgb(233, 84, 32),
    labelColor: XTermColor.rgb(233, 84, 32),
    valueColor: XTermColor.white,
    gradientStart: const Rgb(233, 84, 32), // Orange
    gradientEnd: const Rgb(119, 41, 83), // Aubergine
    // Fundo roxo beringela escuro
    emptyColor: XTermColor.rgb(80, 20, 40),
  );

  /// Oceanic: Azul Marinho -> Azul Celeste
  static final oceanic = ChartStyle(
    emptyChar: '░',
    barColor: XTermColor.rgb(0, 150, 200),
    labelColor: XTermColor.rgb(0, 200, 255),
    valueColor: XTermColor.white,
    gradientStart: const Rgb(0, 70, 130), // Deep Blue
    gradientEnd: const Rgb(0, 210, 255), // Light Blue
    // Fundo azul marinho profundo
    emptyColor: XTermColor.rgb(0, 40, 80),
  );

  /// Monokai: Verde Código -> Rosa Destaque
  static final monokai = ChartStyle(
    barChar: '▰',
    emptyChar: '▱',
    barColor: XTermColor.rgb(166, 226, 46), // Fallback
    labelColor: XTermColor.rgb(249, 38, 114),
    valueColor: XTermColor.rgb(102, 217, 239),
    gradientStart: const Rgb(166, 226, 46), // Green
    gradientEnd: const Rgb(249, 38, 114), // Pink
    // Cinza monokai background
    emptyColor: XTermColor.rgb(73, 72, 62),
  );

  /// Solarized: Ciano -> Violeta (Base01 -> Violet)
  static final solarized = ChartStyle(
    barChar: '◉ ',
    emptyChar: '○ ',
    barColor: XTermColor.cyan,
    labelColor: XTermColor.rgb(133, 153, 0),
    valueColor: XTermColor.rgb(181, 137, 0),
    gradientStart: const Rgb(42, 161, 152), // Cyan
    gradientEnd: const Rgb(108, 113, 196), // Violet
    // Solarized Base02 (Fundo escuro)
    emptyColor: XTermColor.rgb(7, 54, 66),
  );

  /// Candy: Rosa Bebê -> Azul Bebê (Cotton Candy)
  static final candy = ChartStyle(
    barChar: '❤ ',
    emptyChar: '♡ ',
    barColor: XTermColor.magenta,
    labelColor: XTermColor.rgb(255, 105, 180),
    valueColor: XTermColor.rgb(135, 206, 250),
    gradientStart: const Rgb(255, 105, 180), // Hot Pink
    gradientEnd: const Rgb(135, 206, 250), // Sky Blue
    // Fundo roxo/rosa bem escuro
    emptyColor: XTermColor.rgb(100, 50, 80),
  );

  /// Vercel: Minimalismo Preto e Branco
  static final vercel = ChartStyle(
    barChar: '▲',
    emptyChar: '△',
    barColor: XTermColor.white,
    labelColor: XTermColor.rgb(180, 180, 180), // Cinza Claro
    valueColor: XTermColor.white,
    gradientStart: const Rgb(100, 100, 100),
    gradientEnd: const Rgb(255, 255, 255),
    // Fundo cinza médio
    emptyColor: XTermColor.rgb(60, 60, 60),
  );
}
