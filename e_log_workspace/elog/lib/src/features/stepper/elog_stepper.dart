import 'elog_step.dart';

/// Controla a execução sequencial de steps
class ELogStepper {
  final List<ELogStep> steps;

  int _currentIndex = -1;

  ELogStepper(this.steps);

  /// Step atual em execução
  ELogStep? get current => _currentIndex >= 0 && _currentIndex < steps.length
      ? steps[_currentIndex]
      : null;

  /// Retorna true se todos concluíram com sucesso
  bool get isCompleted => steps.isNotEmpty && steps.every((s) => s.isSuccess);

  /// Inicia o próximo step
  ELogStep? next() {
    if (_currentIndex >= 0) {
      final prev = steps[_currentIndex];
      if (prev.isRunning) {
        prev.succeed();
      }
    }

    _currentIndex++;

    if (_currentIndex >= steps.length) {
      return null;
    }

    final step = steps[_currentIndex];
    step.start();
    return step;
  }

  /// Marca o step atual como erro
  void failCurrent() {
    final step = current;
    if (step != null) {
      step.fail();
    }
  }

  /// Reseta todo o pipeline
  void reset() {
    for (final step in steps) {
      step.reset();
    }
    _currentIndex = -1;
  }
}

void main() {
  final stepper = ELogStepper([
    ELogStep('Inicializando'),
    ELogStep('Validando'),
    ELogStep('Finalizando'),
  ]);

  stepper.next(); // Inicializando
  stepper.next(); // Validando
  stepper.next(); // Finalizando
}
