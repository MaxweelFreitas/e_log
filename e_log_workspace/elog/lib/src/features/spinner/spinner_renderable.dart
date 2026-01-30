import '../../core/contracts/elog_renderable.dart';
import 'spinner_controller.dart';

/// Adapter que torna um SpinnerController renderizável.
///
/// Ele:
/// - NÃO controla tempo
/// - NÃO escreve no terminal
/// - APENAS expõe o frame atual como string
///
/// Quem decide *quando* renderizar é o runtime (CLI, loop, pipeline, etc).
class SpinnerRenderable implements ELogRenderable {
  final SpinnerController controller;

  /// Texto opcional exibido após o spinner
  final String? label;

  /// Espaço entre spinner e label
  final String separator;

  SpinnerRenderable({
    required this.controller,
    this.label,
    this.separator = ' ',
  });

  @override
  String render() {
    final frame = controller.currentFrame;
    if (label == null || label!.isEmpty) {
      return frame;
    }
    return '$frame$separator$label';
  }

  @override
  bool get isEmpty => false;
}
