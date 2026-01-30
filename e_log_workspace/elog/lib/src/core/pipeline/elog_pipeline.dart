import '../contracts/elog_renderable.dart';

/// Pipeline de renderização para ELog.
///
/// Permite encadear múltiplos renderables e
/// gerar uma saída única e previsível.
///
/// Exemplo:
/// ELogPipeline([
///   ELogBox(...),
///   ELogSpinner(...),
///   ELogTable(...),
/// ]).render();
class ELogPipeline implements ELogRenderable {
  final List<ELogRenderable> _nodes;

  /// Se true, ignora renderables vazios
  final bool skipEmpty;

  /// Separador entre renderizações
  final String separator;

  ELogPipeline(
    Iterable<ELogRenderable> nodes, {
    this.skipEmpty = true,
    this.separator = '\n',
  }) : _nodes = List.unmodifiable(nodes);

  /// Cria um pipeline vazio
  const ELogPipeline.empty({this.skipEmpty = true, this.separator = '\n'})
    : _nodes = const [];

  /// Adiciona um novo renderable e retorna um novo pipeline
  ELogPipeline add(ELogRenderable node) {
    return ELogPipeline(
      [..._nodes, node],
      skipEmpty: skipEmpty,
      separator: separator,
    );
  }

  /// Adiciona vários renderables
  ELogPipeline addAll(Iterable<ELogRenderable> nodes) {
    return ELogPipeline(
      [..._nodes, ...nodes],
      skipEmpty: skipEmpty,
      separator: separator,
    );
  }

  /// Indica se o pipeline está vazio
  @override
  bool get isEmpty =>
      _nodes.isEmpty || _nodes.every((n) => skipEmpty ? n.isEmpty : false);

  /// Renderiza todo o pipeline
  @override
  String render() {
    final buffer = StringBuffer();

    for (final node in _nodes) {
      if (skipEmpty && node.isEmpty) continue;

      if (buffer.isNotEmpty) {
        buffer.write(separator);
      }

      buffer.write(node.render());
    }

    return buffer.toString();
  }

  /// Acesso somente leitura aos nós
  List<ELogRenderable> get nodes => _nodes;
}
