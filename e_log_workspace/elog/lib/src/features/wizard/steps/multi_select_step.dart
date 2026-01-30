import 'e_wizard_step.dart';

class MultiSelectStep extends EWizardStep {
  final List<String> options;
  final List<int> initialSelections;
  final int minSelection;
  final int maxSelection;

  const MultiSelectStep(
    super.title, {
    required super.id,
    required this.options,
    super.description,
    super.condition,
    super.style,
    super.footer,
    this.initialSelections = const [],
    this.minSelection = 0,
    this.maxSelection = 999,
  });
}
