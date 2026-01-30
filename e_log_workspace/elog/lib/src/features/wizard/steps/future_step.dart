import '../../spinner/style/spinner_presets.dart';
import '../../spinner/spinner_set.dart';
import 'e_wizard_step.dart';

class FutureStep extends EWizardStep {
  final Future<dynamic> Function() task;
  final String loadingText;

  /// Pode ser um [SpinnerSet] ou uma [String] com o nome do preset.
  /// Se null, usa o padrão (dots).
  final dynamic spinner;

  const FutureStep(
    super.title, {
    required super.id,
    required this.task,
    this.loadingText = 'Processing...',
    this.spinner,
    super.description,
    super.condition,
    super.style,
    super.footer,
  });

  /// Helper para resolver o spinner correto
  SpinnerSet getResolvedSpinner() {
    if (spinner is SpinnerSet) return spinner as SpinnerSet;
    if (spinner is String) {
      final found = SpinnerPresets.byName(spinner as String);
      if (found != null) return found;
    }
    return SpinnerPresets.dots2; // Default bonito
  }
}
