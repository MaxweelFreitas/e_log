import 'e_wizard_step.dart';

class ToggleStep extends EWizardStep {
  final String activeLabel;
  final String inactiveLabel;
  final bool initialValue;

  const ToggleStep(
    super.title, {
    required super.id,
    super.description,
    super.condition,
    super.style,
    super.footer,
    this.activeLabel = 'Yes',
    this.inactiveLabel = 'No',
    this.initialValue = false,
  });
}
