import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../shared/border_set.dart';
import '../../../shared/icon_set.dart';
import 'e_wizard_style.dart';

/// Coleção de estilos prontos para o EWizard.
class EWizardPresets {
  const EWizardPresets._();

  // ===========================================================================
  // 1. CLÁSSICOS & ESTRUTURAIS
  // ===========================================================================

  /// 🌲 **Classic**: O padrão profissional.
  static final classic = EWizardStyle(
    bannerBorderColor: XTermColor.rgb(0, 255, 255),
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerBorderColor: XTermColor.rgb(0, 255, 255),
    messageBorderColor: XTermColor.rgb(0, 255, 255),
    messageTextColor: XTermColor.rgb(240, 240, 240),
    activeColor: XTermColor.rgb(0, 255, 255),
    completedColor: XTermColor.rgb(0, 255, 255),
    stepTitleColor: XTermColor.rgb(255, 255, 255),
    selectionHighlightColor: XTermColor.rgb(0, 255, 255),
    errorColor: XTermColor.rgb(255, 80, 80),
  );

  /// ✨ **Minimal**: Limpo, sem bordas.
  static final minimal = EWizardStyle(
    icons: IconSet.minimal,
    border: BorderSet.none,
    bannerStyle: WizardBoxStyle.none,
    footerStyle: WizardBoxStyle.none,
    renderMessageBox: false,
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerTextColor: XTermColor.rgb(150, 150, 150),
    messageTextColor: XTermColor.rgb(200, 200, 200),
    activeColor: XTermColor.rgb(255, 255, 255),
    completedColor: XTermColor.rgb(100, 100, 100),
    stepTitleColor: XTermColor.rgb(230, 230, 230),
    selectionHighlightColor: XTermColor.rgb(255, 255, 255),
    errorColor: XTermColor.rgb(255, 100, 100),
    treeLineChar: '',
    treeCornerChar: '',
  );

  /// 🖥 **Monochrome**: Alto contraste, ASCII.
  static final monochrome = EWizardStyle(
    icons: IconSet.ascii,
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.box,
    bannerBorderColor: XTermColor.rgb(255, 255, 255),
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerBorderColor: XTermColor.rgb(255, 255, 255),
    messageBorderColor: XTermColor.rgb(150, 150, 150),
    messageTextColor: XTermColor.rgb(255, 255, 255),
    activeColor: XTermColor.rgb(255, 255, 255),
    completedColor: XTermColor.rgb(120, 120, 120),
    stepTitleColor: XTermColor.rgb(255, 255, 255),
    selectionHighlightColor: XTermStyle.reverse,
    errorColor: XTermColor.rgb(255, 0, 0),
  );

  // ===========================================================================
  // 2. SEMÂNTICOS (Status)
  // ===========================================================================

  /// ✅ **Success**: Verde e ícones de check.
  static const success = EWizardStyle(
    icons: IconSet.success, // Usa o set pronto de sucesso
    bannerBorderColor: XTermColor.green,
    activeColor: XTermColor.green,
    stepTitleColor: XTermColor.green,
    selectionHighlightColor: XTermColor.green,
  );

  /// ⚠ **Warning**: Amarelo e ícones de alerta.
  static const warning = EWizardStyle(
    icons: IconSet.warning, // Usa o set pronto de aviso
    bannerBorderColor: XTermColor.yellow,
    activeColor: XTermColor.yellow,
    completedColor: XTermColor.yellow,
    stepTitleColor: XTermColor.yellow,
    selectionHighlightColor: XTermColor.yellow,
  );

  /// ❌ **Error**: Vermelho e ícones de erro.
  static const error = EWizardStyle(
    icons: IconSet.error, // Usa o set pronto de erro
    bannerBorderColor: XTermColor.red,
    activeColor: XTermColor.red,
    completedColor: XTermColor.red,
    stepTitleColor: XTermColor.red,
    selectionHighlightColor: XTermColor.red,
  );

  // ===========================================================================
  // 3. ESTILIZADOS & VIBRANTES
  // ===========================================================================

  /// 💊 **Matrix**: Verde digital (Alias para Retro).
  static final matrix = retro;

  /// 👾 **Retro**: Pixel art, borda dupla.
  static final retro = EWizardStyle(
    icons: IconSet.pixel, // Usa o set de Pixel
    border: BorderSet.double,
    bannerStyle: WizardBoxStyle.box,
    bannerBorderColor: XTermColor.rgb(0, 100, 0),
    bannerTextColor: XTermColor.rgb(0, 255, 0),
    footerStyle: WizardBoxStyle.box,
    footerBorderColor: XTermColor.rgb(0, 100, 0),
    messageBorderColor: XTermColor.rgb(0, 100, 0),
    messageTextColor: XTermColor.rgb(0, 255, 0),
    activeColor: XTermColor.rgb(0, 255, 0),
    completedColor: XTermColor.rgb(0, 100, 0),
    stepTitleColor: XTermColor.rgb(0, 255, 0),
    treeLineChar: '║',
    treeCornerChar: '╠',
    selectionHighlightColor: XTermColor.rgb(100, 255, 100),
    errorColor: XTermColor.rgb(255, 0, 0),
  );

  /// 🔮 **Neon**: Roxo vibrante (Alias para Modern).
  static final neon = modern;

  /// 🚀 **Modern**: Cores vivas, ícones arredondados.
  static final modern = EWizardStyle(
    icons: IconSet.round.copyWith(activeStep: '🚀'),
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.bgMagenta,
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerStyle: WizardBoxStyle.solidBackground,
    footerBackgroundColor: XTermColor.bgBlue,
    footerTextColor: XTermColor.rgb(0, 0, 0),
    messageBorderColor: XTermColor.rgb(255, 0, 255),
    messageTextColor: XTermColor.rgb(255, 200, 255),
    activeColor: XTermColor.rgb(255, 0, 255),
    completedColor: XTermColor.rgb(255, 0, 255),
    stepTitleColor: XTermColor.rgb(255, 100, 255),
    selectionHighlightColor: XTermColor.rgb(255, 0, 255),
    errorColor: XTermColor.rgb(255, 0, 80),
  );

  /// ☢ **Meltdown**: Fogo e Alerta.
  static final meltdown = fire; // Alias

  /// 🔥 **Fire**: Tons quentes.
  static final fire = EWizardStyle(
    icons: IconSet.fire, // Usa o set de Fogo diretamente
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.box,
    bannerBorderColor: XTermColor.rgb(100, 50, 50),
    bannerTextColor: XTermColor.rgb(255, 255, 0),
    footerBorderColor: XTermColor.rgb(100, 50, 50),
    messageBorderColor: XTermColor.rgb(100, 50, 50),
    messageTextColor: XTermColor.rgb(255, 200, 200),
    activeColor: XTermColor.rgb(255, 50, 50),
    completedColor: XTermColor.rgb(100, 50, 50),
    stepTitleColor: XTermColor.rgb(255, 100, 100),
    selectionHighlightColor: XTermColor.rgb(255, 255, 0),
    errorColor: XTermColor.rgb(255, 255, 0),
  );

  /// 🖊 **Highlight**: Fundo Azul com marca-texto.
  static const highlight = EWizardStyle(
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.bgBlue,
    bannerTextColor: XTermColor.black + XTermColor.bgYellow,
    activeColor: XTermColor.yellow,
    completedColor: XTermColor.blue,
    selectionHighlightColor: XTermColor.bgBlue + XTermColor.white,
  );

  // ===========================================================================
  // 4. TEMAS RGB & SISTEMAS
  // ===========================================================================

  /// 🐧 **Yaru** (Ubuntu): Laranja e Roxo.
  static final yaru = ubuntu;

  static final ubuntu = EWizardStyle(
    icons: IconSet.star, // Usa o set de Estrelas diretamente
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.rgbBg(233, 84, 32),
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerBorderColor: XTermColor.rgb(233, 84, 32),
    messageBorderColor: XTermColor.rgb(119, 41, 83),
    messageTextColor: XTermColor.rgb(255, 255, 255),
    activeColor: XTermColor.rgb(233, 84, 32),
    completedColor: XTermColor.rgb(119, 41, 83),
    stepTitleColor: XTermColor.rgb(233, 84, 32),
    selectionHighlightColor: XTermColor.rgb(233, 84, 32),
    errorColor: XTermColor.rgb(239, 41, 41),
  );

  /// 🦇 **Dracula**: Dark theme clássico.
  static final dracula = EWizardStyle(
    // Ícone customizado pois Dracula usa o vampiro
    icons: IconSet.ascii.copyWith(
      activeStep: '🧛',
      selectedOption: '[x]',
      unselectedOption: '[ ]',
    ),
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.rgbBg(40, 42, 54),
    bannerBorderColor: XTermColor.rgb(189, 147, 249),
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerBorderColor: XTermColor.rgb(80, 250, 123),
    messageBorderColor: XTermColor.rgb(98, 114, 164),
    messageTextColor: XTermColor.rgb(248, 248, 242),
    activeColor: XTermColor.rgb(255, 121, 198),
    completedColor: XTermColor.rgb(98, 114, 164),
    stepTitleColor: XTermColor.rgb(189, 147, 249),
    selectionHighlightColor: XTermColor.rgb(80, 250, 123),
    errorColor: XTermColor.rgb(255, 85, 85),
  );

  /// 🍎 **Monokai**: Clássico Sublime Text.
  static final monokai = EWizardStyle(
    icons: IconSet.minimal,
    bannerBorderColor: XTermColor.rgb(102, 217, 239),
    activeColor: XTermColor.rgb(249, 38, 114),
    completedColor: XTermColor.rgb(166, 226, 46),
    stepTitleColor: XTermColor.rgb(230, 219, 116),
    selectionHighlightColor: XTermColor.rgb(249, 38, 114),
  );

  /// 🌊 **Oceanic**: Tons de Azul.
  static final oceanic = ocean;

  static final ocean = EWizardStyle(
    // Ícones customizados de onda
    icons: IconSet.classic.copyWith(
      activeStep: '🌊',
      completedStep: '💧',
      selectedOption: '⚓',
    ),
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.rgbBg(0, 50, 100),
    bannerTextColor: XTermColor.rgb(255, 255, 255),
    footerBorderColor: XTermColor.rgb(0, 100, 255),
    messageBorderColor: XTermColor.rgb(0, 150, 255),
    messageTextColor: XTermColor.rgb(200, 240, 255),
    activeColor: XTermColor.rgb(0, 255, 255),
    completedColor: XTermColor.rgb(0, 50, 150),
    stepTitleColor: XTermColor.rgb(100, 200, 255),
    selectionHighlightColor: XTermColor.rgb(0, 255, 255),
    errorColor: XTermColor.rgb(255, 100, 50),
  );

  // ===========================================================================
  // 5. DEVOPS & EXTRAS
  // ===========================================================================

  /// **Amber**: Monitor antigo.
  static final amber = EWizardStyle(
    icons: IconSet.pixel.copyWith(
      activeStep: '►',
      selectionCursor: '»',
      completedStep: '■',
      selectedOption: '[*]',
    ),
    border: BorderSet.double,
    bannerStyle: WizardBoxStyle.box,
    bannerBorderColor: XTermColor.rgb(255, 176, 0),
    bannerTextColor: XTermColor.rgb(255, 176, 0),
    footerStyle: WizardBoxStyle.box,
    footerBorderColor: XTermColor.rgb(255, 176, 0),
    messageBorderColor: XTermColor.rgb(184, 134, 11),
    messageTextColor: XTermColor.rgb(255, 176, 0),
    activeColor: XTermColor.rgb(255, 200, 0),
    completedColor: XTermColor.rgb(184, 134, 11),
    stepTitleColor: XTermColor.rgb(255, 176, 0),
    selectionHighlightColor: XTermColor.rgb(255, 215, 0),
    errorColor: XTermColor.rgb(255, 69, 0),
  );

  /// **Cyberpunk**: Amarelo Neon e Preto.
  static final cyberpunk = EWizardStyle(
    icons: IconSet.minimal.copyWith(
      activeStep: '⚡',
      completedStep: 'x',
      selectionCursor: '»',
      unselectedOption: ' ',
    ),
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.bgYellow,
    bannerTextColor: XTermColor.rgb(0, 0, 0),
    footerBorderColor: XTermColor.rgb(255, 255, 0),
    messageBorderColor: XTermColor.rgb(80, 80, 80),
    messageTextColor: XTermColor.rgb(255, 255, 200),
    activeColor: XTermColor.rgb(255, 255, 0),
    completedColor: XTermColor.rgb(80, 80, 80),
    stepTitleColor: XTermColor.rgb(255, 255, 0),
    selectionHighlightColor: XTermColor.bgYellow + XTermColor.black,
    errorColor: XTermColor.rgb(255, 0, 50),
  );

  /// **Forest**: Tons de verde.
  static final forest = EWizardStyle(
    icons: IconSet.classic.copyWith(
      activeStep: '🌲',
      completedStep: '⚘',
      selectedOption: '♣',
      unselectedOption: '♧',
    ),
    bannerBorderColor: XTermColor.rgb(34, 139, 34),
    bannerTextColor: XTermColor.rgb(144, 238, 144),
    footerBorderColor: XTermColor.rgb(34, 139, 34),
    messageBorderColor: XTermColor.rgb(34, 139, 34),
    messageTextColor: XTermColor.rgb(200, 255, 200),
    activeColor: XTermColor.rgb(144, 238, 144),
    completedColor: XTermColor.rgb(34, 139, 34),
    stepTitleColor: XTermColor.rgb(144, 238, 144),
    selectionHighlightColor: XTermColor.rgb(144, 238, 144),
    errorColor: XTermColor.rgb(255, 100, 100),
  );

  /// **Vercel**: P&B corporativo.
  static final vercel = EWizardStyle(
    icons: IconSet.geometric, // Usa o set Geométrico diretamente
    border: BorderSet.single,
    bannerStyle: WizardBoxStyle.box,
    bannerBorderColor: XTermColor.rgb(80, 80, 80),
    bannerBackgroundColor: XTermColor.rgbBg(255, 255, 255),
    bannerTextColor: XTermColor.rgb(0, 0, 0),
    footerStyle: WizardBoxStyle.none,
    footerTextColor: XTermColor.rgb(150, 150, 150),
    messageBorderColor: XTermColor.rgb(80, 80, 80),
    messageTextColor: XTermColor.rgb(230, 230, 230),
    activeColor: XTermColor.rgb(255, 255, 255),
    completedColor: XTermColor.rgb(100, 100, 100),
    stepTitleColor: XTermColor.rgb(255, 255, 255),
    selectionHighlightColor: XTermColor.rgb(255, 255, 255),
    errorColor: XTermColor.rgb(255, 70, 70),
  );

  /// **Cloud**: Azul céu.
  static final cloud = EWizardStyle(
    icons: IconSet.cloud, // Usa o set de Nuvem diretamente
    bannerBorderColor: XTermColor.rgb(30, 144, 255),
    bannerTextColor: XTermColor.rgb(30, 144, 255),
    footerBorderColor: XTermColor.rgb(30, 144, 255),
    messageBorderColor: XTermColor.rgb(135, 206, 235),
    messageTextColor: XTermColor.rgb(224, 255, 255),
    activeColor: XTermColor.rgb(0, 191, 255),
    completedColor: XTermColor.rgb(70, 130, 180),
    stepTitleColor: XTermColor.rgb(240, 248, 255),
    selectionHighlightColor: XTermColor.rgb(0, 191, 255),
    errorColor: XTermColor.rgb(255, 99, 71),
  );

  /// **Solarized**: Tons de areia e ciano.
  static final solarized = EWizardStyle(
    icons: IconSet.classic.copyWith(
      selectionCursor: '➤',
      selectedOption: 'x',
      unselectedOption: ' ',
    ),
    bannerBorderColor: XTermColor.rgb(181, 137, 0),
    bannerTextColor: XTermColor.rgb(147, 161, 161),
    footerBorderColor: XTermColor.rgb(88, 110, 117),
    messageBorderColor: XTermColor.rgb(42, 161, 152),
    messageTextColor: XTermColor.rgb(131, 148, 150),
    activeColor: XTermColor.rgb(181, 137, 0),
    completedColor: XTermColor.rgb(88, 110, 117),
    stepTitleColor: XTermColor.rgb(147, 161, 161),
    selectionHighlightColor: XTermColor.rgb(203, 75, 22),
    errorColor: XTermColor.rgb(220, 50, 47),
  );

  /// **Candy**: Cores pastel.
  static final candy = EWizardStyle(
    icons: IconSet.lovely, // Usa o set de Corações diretamente
    bannerStyle: WizardBoxStyle.solidBackground,
    bannerBackgroundColor: XTermColor.rgbBg(255, 182, 193),
    bannerTextColor: XTermColor.rgb(0, 0, 0),
    footerStyle: WizardBoxStyle.none,
    footerTextColor: XTermColor.rgb(255, 105, 180),
    messageBorderColor: XTermColor.rgb(173, 216, 230),
    messageTextColor: XTermColor.rgb(255, 255, 255),
    activeColor: XTermColor.rgb(255, 105, 180),
    completedColor: XTermColor.rgb(135, 206, 250),
    stepTitleColor: XTermColor.rgb(221, 160, 221),
    selectionHighlightColor: XTermColor.rgb(255, 182, 193),
    errorColor: XTermColor.rgb(255, 99, 71),
  );
}
