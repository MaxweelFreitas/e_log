import '../../../base/x_term/x_term_color.dart';
import 'e_wizard_style.dart';

/// Factory de estilos para passos individuais.
/// O conceito é: "Mantenha a estrutura do tema do Wizard, mude apenas a cor/ícone".
class StepPresets {
  const StepPresets._();

  /// 🔴 **Error / Danger**
  /// Vermelho. Para passos destrutivos ou críticos.
  static EWizardStyle error(EWizardStyle base) {
    return base.copyWith(
        activeColor: XTermColor.rgb(255, 60, 60),
        completedColor: XTermColor.rgb(150, 0, 0),
        stepTitleColor: XTermColor.rgb(255, 100, 100),
        selectionHighlightColor: XTermColor.rgb(255, 0, 0),
        icons: base.icons.copyWith(
          activeStep: '✖',
          completedStep: '✖',
          selectedOption: '☒',
          unselectedOption: '☐',
        ));
  }

  /// 🟡 **Warning**
  /// Amarelo. Para configurações que requerem atenção.
  static EWizardStyle warning(EWizardStyle base) {
    return base.copyWith(
      activeColor: XTermColor.rgb(255, 200, 0),
      completedColor: XTermColor.rgb(180, 140, 0),
      stepTitleColor: XTermColor.rgb(255, 255, 150),
      selectionHighlightColor: XTermColor.rgb(255, 220, 0),
      icons: base.icons.copyWith(activeStep: '⚠'),
    );
  }

  /// 🟢 **Success**
  /// Verde. Para confirmações ou passos finais.
  static EWizardStyle success(EWizardStyle base) {
    return base.copyWith(
      activeColor: XTermColor.rgb(50, 255, 100),
      completedColor: XTermColor.rgb(0, 150, 50),
      stepTitleColor: XTermColor.rgb(150, 255, 150),
      selectionHighlightColor: XTermColor.rgb(0, 255, 0),
      icons: base.icons.copyWith(activeStep: '✓', completedStep: '✓'),
    );
  }

  /// 🔵 **Info / Neutral**
  /// Azul. Para informações ou passos opcionais.
  static EWizardStyle info(EWizardStyle base) {
    return base.copyWith(
      activeColor: XTermColor.rgb(80, 180, 255),
      completedColor: XTermColor.rgb(0, 100, 200),
      stepTitleColor: XTermColor.rgb(200, 230, 255),
      selectionHighlightColor: XTermColor.rgb(0, 200, 255),
      icons: base.icons.copyWith(activeStep: 'ℹ'),
    );
  }

  /// 🟣 **Highlight / Feature**
  /// Roxo/Neon. Para destacar uma funcionalidade nova ou especial.
  static EWizardStyle highlight(EWizardStyle base) {
    return base.copyWith(
      activeColor: XTermColor.rgb(255, 0, 255),
      completedColor: XTermColor.rgb(120, 0, 120),
      stepTitleColor: XTermColor.rgb(255, 150, 255),
      selectionHighlightColor: XTermColor.rgb(255, 0, 255),
      icons: base.icons.copyWith(activeStep: '★'),
    );
  }

  /// 🛠 **Custom Builder**
  /// Permite ao usuário criar um estilo one-off rapidamente.
  ///
  /// Ex: `style: StepPresets.custom(myTheme, color: XTermColor.orange, icon: '🔥')`
  static EWizardStyle custom(
    EWizardStyle base, {
    String? color,
    String? icon,
  }) {
    return base.copyWith(
      activeColor: color,
      selectionHighlightColor: color,
      stepTitleColor: color, // Opcional, pode querer manter branco
      icons: icon != null ? base.icons.copyWith(activeStep: icon) : null,
    );
  }

  /// ☑️ **Checklist / Options Customizer**
  /// Facilita a customização visual de Select e MultiSelect.
  ///
  /// Ex:
  /// `style: StepPresets.checklist(myTheme, selected: '✔', unselected: ' ')`
  static EWizardStyle checklist(
    EWizardStyle base, {
    String? selected, // Ícone marcado. Ex: '[x]', '✔', '★'
    String? unselected, // Ícone desmarcado. Ex: '[ ]', '  ', '☆'
    String? color, // Cor do destaque (highlight)
  }) {
    return base.copyWith(
      selectionHighlightColor: color,
      icons: base.icons.copyWith(
        selectedOption: selected,
        unselectedOption: unselected,
      ),
    );
  }
}
