import '../../core/contracts/elog_renderable.dart';

/// Representa uma única etapa de um pipeline.
///
/// É puramente descritiva (stateless).
class StepItem {
  final String label;

  /// Ícone exibido antes do texto
  ///
  /// Ex:
  /// - ⏳ em progresso
  /// - ✔ concluído
  /// - ✖ erro
  /// - ○ pendente
  final String icon;

  /// Texto opcional exibido ao final
  final String? detail;

  const StepItem({required this.label, required this.icon, this.detail});
}

/// Renderizável de um conjunto de etapas (pipeline / stepper).
///
/// NÃO controla estado
/// NÃO anima
/// NÃO escreve no terminal
///
/// Apenas transforma dados em texto estruturado.
class StepperRenderable implements ELogRenderable {
  final List<StepItem> steps;

  /// Espaçamento entre ícone e label
  final String iconSeparator;

  /// Prefixo de cada linha
  final String linePrefix;

  const StepperRenderable({
    required this.steps,
    this.iconSeparator = ' ',
    this.linePrefix = '',
  });

  @override
  String render() {
    final buffer = StringBuffer();

    for (var i = 0; i < steps.length; i++) {
      final step = steps[i];

      buffer.write(linePrefix);
      buffer.write(step.icon);
      buffer.write(iconSeparator);
      buffer.write(step.label);

      if (step.detail != null && step.detail!.isNotEmpty) {
        buffer.write(' ');
        buffer.write(step.detail);
      }

      if (i < steps.length - 1) {
        buffer.writeln();
      }
    }

    return buffer.toString();
  }

  @override
  bool get isEmpty => steps.isEmpty;
}
