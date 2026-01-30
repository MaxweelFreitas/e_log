import 'e_wizard_step.dart';

class MessageStep extends EWizardStep {
  final String content;

  const MessageStep(
    super.title, {
    required super.id,
    required this.content,
    super.style,
    super.footer, // Ex: "Pressione Enter para continuar"
  });
}
