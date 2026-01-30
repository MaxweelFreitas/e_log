import '../style/e_wizard_style.dart';

/// Classe base para todos os passos do Wizard.
abstract class EWizardStep {
  final String id;
  final String title;
  final String? description;

  /// Lógica condicional para pular o passo
  final bool Function(Map<String, dynamic> results)? condition;

  // --- NOVOS CAMPOS ---

  /// Estilo específico para este passo.
  /// Se null, usa o estilo global do Wizard.
  final EWizardStyle? style;

  /// Mensagem de rodapé específica para quando este passo estiver ativo.
  /// Ex: "Pressione ESC para cancelar" ou "Use Espaço para marcar".
  final String? footer;

  const EWizardStep(
    this.title, {
    required this.id,
    this.description,
    this.condition,
    this.style,
    this.footer,
  });
}
