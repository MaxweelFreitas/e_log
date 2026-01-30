/// Define uma sombra ASCII para boxes.
///
/// Stateless e reutilizável.
final class EBoxShadow {
  /// Deslocamento horizontal (colunas)
  final int offsetX;

  /// Deslocamento vertical (linhas)
  final int offsetY;

  /// Caractere usado para desenhar a sombra
  final String char;

  const EBoxShadow({this.offsetX = 1, this.offsetY = 1, this.char = '░'});

  /// Sombra padrão suave
  static const soft = EBoxShadow();

  /// Sombra densa
  static const dense = EBoxShadow(char: '▓');

  /// Sombra leve pontilhada
  static const dotted = EBoxShadow(char: '.');
}
