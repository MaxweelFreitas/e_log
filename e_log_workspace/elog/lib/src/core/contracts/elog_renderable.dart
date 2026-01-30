/// Contrato base para qualquer elemento que possa ser renderizado
/// no terminal via Ascy.
///
/// Tudo que vira output final deve implementar isso:
/// - Boxes
/// - Tables
/// - Spinners
/// - Logs simples
/// - Builders compostos
abstract class ELogRenderable {
  const ELogRenderable();

  /// Retorna a string final pronta para ser impressa no terminal.
  ///
  /// ⚠️ Regras:
  /// - Já deve conter cores ANSI, estilos, bordas, etc
  /// - NÃO deve imprimir nada diretamente (sem stdout aqui)
  /// - NÃO deve adicionar quebra de linha no final, a menos que faça parte do layout
  String render();

  /// Indica se o renderable possui conteúdo visível.
  /// Útil para pipelines e renderização condicional.
  bool get isEmpty => render().trim().isEmpty;
}
