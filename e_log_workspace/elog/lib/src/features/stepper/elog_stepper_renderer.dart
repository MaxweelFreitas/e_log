import 'elog_step.dart';

/// Renderiza visualmente um Stepper no terminal
class ELogStepperRenderer {
  final String indent;
  final bool showDescription;

  ELogStepperRenderer({this.indent = '  ', this.showDescription = true});

  /// Renderiza todos os steps
  List<String> render(List<ELogStep> steps) {
    final output = <String>[];

    for (final step in steps) {
      output.add(_renderStep(step));
    }

    return output;
  }

  String _renderStep(ELogStep step) {
    final icon = _iconFor(step.status);

    final buffer = StringBuffer()..write('$indent$icon ${step.label}');

    if (showDescription && step.description != null) {
      buffer.write('\n$indent  ${step.description}');
    }

    return buffer.toString();
  }

  String _iconFor(ELogStepStatus status) => switch (status) {
        ELogStepStatus.pending => '○',
        ELogStepStatus.running => '▶',
        ELogStepStatus.success => '✔',
        ELogStepStatus.error => '✖',
      };
}
