import 'e_wizard_step.dart';

class InfoStep extends EWizardStep {
  final bool waitForEnter;

  const InfoStep(
    super.title, {
    required super.id,
    required String description,
    super.condition,
    super.style,
    super.footer,
    this.waitForEnter = true,
  }) : super(description: description);
}
