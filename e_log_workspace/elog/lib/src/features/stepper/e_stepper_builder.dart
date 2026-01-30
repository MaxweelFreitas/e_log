import '../../core/contracts/elog_renderable.dart';

enum EStepState { pending, running, success, failure, skipped }

class EStep {
  final String label;
  final EStepState state;
  final String? message;

  const EStep({required this.label, required this.state, this.message});
}

class EStepperBuilder implements ELogRenderable {
  final List<EStep> steps;

  const EStepperBuilder(this.steps);

  @override
  String render() {
    final buffer = <String>[];

    for (final step in steps) {
      buffer.add(_renderStep(step));
    }

    return buffer.join('\n');
  }

  String _renderStep(EStep step) {
    final icon = _iconFor(step.state);
    final base = '$icon ${step.label}';

    if (step.message == null || step.message!.isEmpty) {
      return base;
    }

    return '$base — ${step.message}';
  }

  String _iconFor(EStepState state) {
    switch (state) {
      case EStepState.pending:
        return '○';
      case EStepState.running:
        return '⏳';
      case EStepState.success:
        return '✔';
      case EStepState.failure:
        return '✖';
      case EStepState.skipped:
        return '⏭';
    }
  }

  @override
  bool get isEmpty => steps.isEmpty;
}
