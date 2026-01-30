import 'e_wizard_step.dart';

class SelectStep extends EWizardStep {
  final List<String> options;

  const SelectStep(
    super.title, {
    required super.id,
    required this.options,
    super.description,
    super.condition,
    super.style,
    super.footer,
  });
}
