import '../../base/x_term/x_term_color.dart';
import 'style/tree_style.dart';
import 'style/tree_presets.dart';

class ETreeBuilder {
  final Map<String, dynamic> _data;

  // Configurações Internas
  TreeStyle _style;
  bool _showRoot = false;
  String _rootLabel = 'root';

  /// Construtor Híbrido.
  /// Aceita [style] opcionalmente para manter compatibilidade com o resto da lib,
  /// mas define [TreePresets.classic] como padrão se for nulo.
  ETreeBuilder(this._data, {TreeStyle? style})
      : _style = style ?? TreePresets.classic;

  // --- MÉTODOS DO BUILDER (Fluentes) ---

  /// Define o estilo visual da árvore (sobrescreve o do construtor).
  ETreeBuilder style(TreeStyle style) {
    _style = style;
    return this;
  }

  /// Define se o nó raiz deve ser exibido.
  ETreeBuilder showRoot(bool enable) {
    _showRoot = enable;
    return this;
  }

  /// Define o texto do rótulo da raiz (caso showRoot seja true).
  ETreeBuilder rootLabel(String label) {
    _rootLabel = label;
    return this;
  }

  // --- BUILD ---

  String build() {
    final buffer = StringBuffer();

    // 1. Renderiza Raiz (Opcional)
    if (_showRoot) {
      buffer.writeln('${_style.rootColor}$_rootLabel${XTermColor.reset}');
    }

    // 2. Renderiza Nós Recursivamente
    _buildNode(buffer, _data, '', true);

    var result = buffer.toString();
    if (result.endsWith('\n')) result = result.substring(0, result.length - 1);

    return result;
  }

  void _buildNode(
    StringBuffer buffer,
    dynamic node,
    String prefix,
    bool isLastItemOfParent,
  ) {
    const reset = XTermColor.reset;
    final b = _style.border;
    final colStruct = _style.structureColor;
    final colKey = _style.keyColor;
    final colVal = _style.valueColor;
    final colSep = _style.separatorColor;

    if (node is Map) {
      final entries = node.entries.toList();
      final count = entries.length;

      for (var i = 0; i < count; i++) {
        final entry = entries[i];
        final isLastChild = (i == count - 1);

        // A. Desenha os Conectores (├─ ou └─)
        final connectorChar = isLastChild ? b.bottomLeft : b.midLeft;
        final limb = b.middle;
        final connectorStr = '$connectorChar$limb';

        // B. Prepara o prefixo para os FILHOS
        final childGuide = isLastChild ? ' ' : b.vertical;
        final childPrefix = '$childGuide   ';

        // C. Renderiza o Item
        if (entry.value is Map || entry.value is List) {
          // --- PASTA / NÓ PAI ---
          buffer.writeln(
              '$colStruct$prefix$connectorStr$reset $colKey${entry.key}$reset');

          _buildNode(buffer, entry.value, '$prefix$childPrefix', isLastChild);
        } else {
          // --- ITEM FINAL / ARQUIVO ---
          if (entry.value == null) {
            buffer.writeln(
                '$colStruct$prefix$connectorStr$reset $colKey${entry.key}$reset');
          } else {
            final valString = entry.value.toString();
            buffer.writeln(
                '$colStruct$prefix$connectorStr$reset $colKey${entry.key}$colSep: $colVal$valString$reset');
          }
        }
      }
    } else if (node is List) {
      // Lista Simples
      final count = node.length;
      for (var i = 0; i < count; i++) {
        final item = node[i];
        final isLastChild = (i == count - 1);

        final connectorChar = isLastChild ? b.bottomLeft : b.midLeft;
        final connectorStr = '$connectorChar${b.middle}';

        final childGuide = isLastChild ? ' ' : b.vertical;
        final childPrefix = '$childGuide   ';

        if (item is Map || item is List) {
          buffer.writeln(
              '$colStruct$prefix$connectorStr$reset $colKey[Item $i]$reset');
          _buildNode(buffer, item, '$prefix$childPrefix', isLastChild);
        } else {
          buffer.writeln(
              '$colStruct$prefix$connectorStr$reset $colVal$item$reset');
        }
      }
    }
  }
}
