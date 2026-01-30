import 'e_wizard_step.dart';

typedef ValidatorCallback = String? Function(String input);

class InputTextStep extends EWizardStep {
  final String? defaultValue;
  final bool isPassword;
  final String? placeholder;
  final ValidatorCallback? validator;

  const InputTextStep(
    super.title, {
    required super.id,
    super.description,
    super.condition,
    super.style,
    super.footer,
    this.defaultValue,
    this.isPassword = false,
    this.placeholder,
    this.validator,
  });
}
