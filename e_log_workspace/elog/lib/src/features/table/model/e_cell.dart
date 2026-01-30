import 'e_cell_text_align.dart';

/// Representa uma célula individual com configurações específicas.
class ECell {
  /// O texto ou conteúdo da célula.
  final String content;

  /// Alinhamento específico para ESTA célula.
  /// Se null, usará o alinhamento da coluna.
  final ECellTextAlign? align;

  // Futuramente você pode adicionar: Color? background, bool bold, etc.

  const ECell(this.content, {this.align});
}
