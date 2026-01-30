import 'spinner_frame.dart';

/// Conjunto de frames que compõem um spinner.
///
/// Um SpinnerSet é:
/// - imutável
/// - reutilizável
/// - independente de tempo ou estado
///
/// Ele NÃO anima nada.
/// Apenas descreve a sequência visual.
class SpinnerSet {
  /// Nome simbólico do spinner (ex: dots, line, moon)
  final String name;

  /// Frames que compõem o spinner
  final List<SpinnerFrame> frames;

  /// Intervalo recomendado entre frames (em ms)
  ///
  /// Pode ser ignorado pelo renderizador.
  final int intervalMs;

  const SpinnerSet({
    required this.name,
    required this.frames,
    this.intervalMs = 80,
  });

  /// Quantidade de frames
  int get length => frames.length;

  /// Retorna um frame pelo índice (com loop automático)
  SpinnerFrame frameAt(int index) {
    if (frames.isEmpty) {
      throw StateError('SpinnerSet "$name" has no frames.');
    }
    return frames[index % frames.length];
  }

  /// Cria uma cópia do spinner com novo intervalo
  SpinnerSet withInterval(int intervalMs) {
    return SpinnerSet(name: name, frames: frames, intervalMs: intervalMs);
  }
}
