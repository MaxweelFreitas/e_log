import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import 'tree_style.dart';

/// Coleção de temas prontos para o ETreeBuilder.
class TreePresets {
  const TreePresets._();

  // ===========================================================================
  // 1. ESTILOS ESTRUTURAIS (Baseados no BorderSet)
  // ===========================================================================

  /// 🌲 **Classic (Single)**: O padrão. Linhas finas, visual limpo.
  static const classic = TreeStyle(
    border: BorderSet.single,
    keyColor: XTermColor.cyan,
    valueColor: XTermColor.reset,
  );

  /// 📦 **Rounded**: Bordas arredondadas (╭ ╰). Visual moderno.
  static const rounded = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.blue,
    keyColor: XTermColor.white,
    valueColor: XTermColor.brightWhite,
  );

  /// 🏗 **Heavy**: Linhas grossas/negrito (┣ ┗).
  static const heavy = TreeStyle(
    border: BorderSet.heavy,
    structureColor: XTermColor.white,
    keyColor: XTermColor.yellow,
    valueColor: XTermColor.white,
  );

  /// ═ **Double**: Linhas duplas (╠ ╚). Estilo retro.
  static const double = TreeStyle(
    border: BorderSet.double,
    structureColor: XTermColor.magenta,
    keyColor: XTermColor.magenta,
    valueColor: XTermColor.white,
  );

  /// 🖥 **ASCII**: Caracteres padrão (+ - |). Compatibilidade total.
  static const ascii = TreeStyle(
    border: BorderSet.ascii,
    structureColor: XTermColor.reset,
    keyColor: XTermColor.green,
    valueColor: XTermColor.reset,
  );

  // --- HÍBRIDOS ---

  /// ╓ **Light Double**: Vertical duplo, horizontal simples.
  static const lightDouble = TreeStyle(
    border: BorderSet.lightDouble,
    structureColor: XTermColor.cyan,
    keyColor: XTermColor.brightCyan,
    valueColor: XTermColor.white,
  );

  /// ╒ **Mixed**: Horizontal duplo, vertical simples.
  static const mixed = TreeStyle(
    border: BorderSet.mixed,
    structureColor: XTermColor.blue,
    keyColor: XTermColor.yellow,
    valueColor: XTermColor.reset,
  );

  // --- MINIMALISTAS ---

  /// ╌ **Dashed**: Linhas tracejadas.
  static const dashed = TreeStyle(
    border: BorderSet.dashed,
    keyColor: XTermColor.white,
    valueColor: XTermColor.reset,
  );

  /// · **Dotted**: Linhas pontilhadas.
  static const dotted = TreeStyle(
    border: BorderSet.dotted,
    keyColor: XTermColor.white,
    valueColor: XTermColor.reset,
  );

  /// ✨ **Clean**: Minimalista, sem linhas verticais longas.
  static const clean = TreeStyle(
    border: BorderSet(
      topLeft: '',
      top: '',
      topRight: '',
      right: '',
      left: '',
      bottomLeft: '›',
      bottom: ' ',
      bottomRight: '',
      topMid: '',
      bottomMid: '',
      midLeft: '›',
      midRight: '',
      center: '',
      middle: ' ',
      vertical: ' ',
    ),
    structureColor: XTermColor.green,
    keyColor: XTermColor.reset,
    valueColor: XTermColor.brightBlack,
  );

  // ===========================================================================
  // 2. TEMAS SEMÂNTICOS (Sincronizados com API Standard)
  // ===========================================================================

  /// ✅ **Success**: Tons de verde.
  static const success = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.green,
    keyColor: XTermColor.brightGreen,
    valueColor: XTermColor.white,
    rootColor: XTermColor.green,
  );

  /// ⚠ **Warning**: Tons de amarelo.
  static const warning = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.yellow,
    keyColor: XTermColor.brightYellow,
    valueColor: XTermColor.white,
    rootColor: XTermColor.yellow,
  );

  /// ❌ **Error**: Tons de vermelho.
  static const error = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.red,
    keyColor: XTermColor.brightRed,
    valueColor: XTermColor.white,
    rootColor: XTermColor.red,
  );

  /// 🚨 **Critical**: Vermelho intenso e bordas pesadas.
  static const critical = TreeStyle(
    border: BorderSet.heavy,
    structureColor: XTermColor.brightRed,
    keyColor: XTermColor.red,
    valueColor: XTermColor.brightWhite,
    separatorColor: XTermColor.red,
    rootColor: XTermColor.bgRed + XTermColor.white,
  );

  // ===========================================================================
  // 3. TEMAS ESTILIZADOS
  // ===========================================================================

  /// 💊 **Matrix**: Verde digital fosforescente.
  static const matrix = TreeStyle(
    border: BorderSet.double, // Tech feel
    structureColor: XTermColor.green,
    keyColor: XTermColor.brightGreen,
    valueColor: XTermColor.white,
    rootColor: XTermColor.brightGreen,
  );

  /// 🔮 **Neon**: Roxo e Magenta vibrantes.
  static const neon = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.magenta,
    keyColor: XTermColor.brightMagenta,
    valueColor: XTermColor.cyan,
    separatorColor: XTermColor.magenta,
    rootColor: XTermColor.brightMagenta,
  );

  /// 🖊 **Highlight**: Fundo Azul com destaque Amarelo.
  static const highlight = TreeStyle(
    border: BorderSet.single,
    structureColor: XTermColor.blue,
    keyColor: XTermColor.yellow,
    valueColor: XTermColor.white,
    rootColor: XTermColor.bgBlue + XTermColor.white,
  );

  /// 🟠 **Amber**: Monitor antigo.
  static final amber = TreeStyle(
    border: BorderSet.double,
    structureColor: XTermColor.rgb(255, 176, 0),
    keyColor: XTermColor.rgb(255, 200, 0),
    valueColor: XTermColor.rgb(184, 134, 11),
    rootColor: XTermColor.rgb(255, 176, 0),
  );

  /// 🌲 **Forest**: Tons de verde natureza.
  static final forest = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.rgb(34, 139, 34),
    keyColor: XTermColor.rgb(144, 238, 144),
    valueColor: XTermColor.white,
    rootColor: XTermColor.rgb(34, 139, 34),
  );

  // ===========================================================================
  // 4. TEMAS RGB / TRUECOLOR & DEVOPS
  // ===========================================================================

  /// 🦇 **Dracula**: Tema dark famoso.
  static final dracula = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.rgb(115, 115, 145), // Lavanda
    keyColor: XTermColor.rgb(255, 121, 198), // Rosa
    valueColor: XTermColor.rgb(139, 233, 253), // Ciano
    separatorColor: XTermColor.rgb(189, 147, 249), // Roxo
    rootColor: XTermColor.rgb(255, 85, 85), // Vermelho
  );

  /// 🤖 **Cyberpunk**: Alto contraste, Neon.
  static final cyberpunk = TreeStyle(
    border: BorderSet.heavy,
    structureColor: XTermColor.rgb(255, 0, 255), // Magenta
    keyColor: XTermColor.rgb(255, 255, 0), // Amarelo
    valueColor: XTermColor.rgb(0, 255, 255), // Ciano
    separatorColor: XTermColor.rgb(255, 0, 255),
    rootColor: XTermColor.rgb(0, 255, 0), // Verde Matrix
  );

  /// ☢ **Meltdown**: Tons de vermelho e salmão (Modern Error).
  static final meltdown = TreeStyle(
    border: BorderSet.heavy,
    structureColor: XTermColor.rgb(255, 85, 85), // Vermelho Borda
    keyColor: XTermColor.rgb(255, 184, 108), // Laranja
    valueColor: XTermColor.rgb(255, 230, 230), // Rosa Pálido
    separatorColor: XTermColor.rgb(255, 85, 85),
    rootColor: XTermColor.rgb(255, 85, 85),
  );

  /// 🐧 **Yaru (Ubuntu)**: Laranja e Roxo.
  static final yaru = TreeStyle(
    border: BorderSet.single,
    structureColor: XTermColor.rgb(119, 41, 83), // Roxo Ubuntu
    keyColor: XTermColor.rgb(233, 84, 32), // Laranja Ubuntu
    valueColor: XTermColor.white,
    separatorColor: XTermColor.rgb(119, 41, 83),
    rootColor: XTermColor.white,
  );

  /// 🌊 **Oceanic**: Tons de azul e verde água (Similar ao Cloud).
  static final oceanic = TreeStyle(
    border: BorderSet.single,
    structureColor: XTermColor.rgb(0, 100, 150),
    keyColor: XTermColor.rgb(100, 220, 255),
    valueColor: XTermColor.rgb(50, 255, 200),
    separatorColor: XTermColor.rgb(0, 150, 200),
    rootColor: XTermColor.white,
  );

  /// ☁ **Cloud**: Azul claro e branco.
  static final cloud = TreeStyle(
    border: BorderSet.single,
    structureColor: XTermColor.rgb(30, 144, 255),
    keyColor: XTermColor.rgb(135, 206, 235),
    valueColor: XTermColor.white,
    rootColor: XTermColor.rgb(30, 144, 255),
  );

  /// 🍎 **Monokai**: Clássico Sublime Text.
  static final monokai = TreeStyle(
    border: BorderSet.rounded,
    keyColor: XTermColor.rgb(249, 38, 114),
    valueColor: XTermColor.rgb(230, 219, 116),
    rootColor: XTermColor.rgb(166, 226, 46),
  );

  /// ▲ **Vercel**: Preto e Branco Corporativo.
  static final vercel = TreeStyle(
    border: BorderSet.single,
    structureColor: XTermColor.white,
    keyColor: XTermColor.white,
    valueColor: XTermColor.rgb(200, 200, 200),
    rootColor: XTermColor.white,
  );

  /// 🌞 **Solarized**: Tons de areia e ciano.
  static final solarized = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.rgb(181, 137, 0), // Yellow
    keyColor: XTermColor.rgb(133, 153, 0), // Green
    valueColor: XTermColor.rgb(42, 161, 152), // Cyan
    rootColor: XTermColor.rgb(203, 75, 22), // Orange
  );

  /// 🍭 **Candy**: Cores pastel (Rosa e Azul).
  static final candy = TreeStyle(
    border: BorderSet.rounded,
    structureColor: XTermColor.rgb(255, 105, 180), // Hot Pink
    keyColor: XTermColor.rgb(255, 182, 193), // Light Pink
    valueColor: XTermColor.rgb(135, 206, 250), // Sky Blue
    rootColor: XTermColor.rgb(255, 105, 180),
  );
}
