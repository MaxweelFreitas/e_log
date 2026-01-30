import '../../core/contracts/elog_renderable.dart';

class ESpinnerBuilder implements ELogRenderable {
  final List<String> frames;
  final String label;
  final int frame;

  const ESpinnerBuilder({
    required this.frames,
    this.label = '',
    this.frame = 0,
  });

  @override
  String render() {
    if (frames.isEmpty) return label;

    final index = frame % frames.length;
    final current = frames[index];

    if (label.isEmpty) {
      return current;
    }

    return '$current $label';
  }

  /// Retorna nova instância com frame atualizado (stateless)
  ESpinnerBuilder next(int nextFrame) {
    return ESpinnerBuilder(frames: frames, label: label, frame: nextFrame);
  }

  @override
  bool get isEmpty => frames.isEmpty;
}
