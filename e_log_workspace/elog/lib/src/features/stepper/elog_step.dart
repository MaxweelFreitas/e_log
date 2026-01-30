/// Estados possíveis de um step
enum ELogStepStatus { pending, running, success, error }

/// Representa um passo de execução (pipeline / stepper)
///
/// NÃO renderiza.
/// NÃO controla tempo.
/// Apenas modela estado + rótulo.
class ELogStep {
  final String label;
  final String? description;

  ELogStepStatus _status = ELogStepStatus.pending;

  ELogStep(this.label, {this.description});

  ELogStepStatus get status => _status;

  bool get isPending => _status == ELogStepStatus.pending;
  bool get isRunning => _status == ELogStepStatus.running;
  bool get isSuccess => _status == ELogStepStatus.success;
  bool get isError => _status == ELogStepStatus.error;

  /// Marca como em execução
  void start() {
    _status = ELogStepStatus.running;
  }

  /// Marca como sucesso
  void succeed() {
    _status = ELogStepStatus.success;
  }

  /// Marca como erro
  void fail() {
    _status = ELogStepStatus.error;
  }

  /// Reseta o step
  void reset() {
    _status = ELogStepStatus.pending;
  }
}
