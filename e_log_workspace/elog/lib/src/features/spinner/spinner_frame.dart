/// Representa um único frame de um spinner.
///
/// Um frame é apenas texto (já estilizado ou não),
/// podendo conter caracteres ASCII, Unicode ou ANSI.
class SpinnerFrame {
  /// Conteúdo visual do frame
  final String value;

  /// Largura visual do frame (opcional).
  ///
  /// Útil para alinhamento em layouts mais complexos.
  final int? width;

  const SpinnerFrame(this.value, {this.width});

  /// Cria um frame simples
  factory SpinnerFrame.simple(String value) {
    return SpinnerFrame(value);
  }

  @override
  String toString() => value;
}
