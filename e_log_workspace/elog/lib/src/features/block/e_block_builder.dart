import 'dart:io';
import '../../base/x_term/x_term_color.dart';
import 'style/block_presets.dart';
import 'style/block_style.dart';

class EBlockBuilder {
  final List<String> _lines = [];
  BlockStyle _style = BlockPresets.classic;

  // ===========================================================================
  // MÉTODOS DE CONSTRUÇÃO (Fluent API)
  // ===========================================================================

  /// Adiciona uma única linha de texto.
  EBlockBuilder text(Object text) {
    _lines.add(text.toString());
    return this;
  }

  /// Adiciona várias linhas de texto.
  EBlockBuilder lines(List<Object> lines) {
    _lines.addAll(lines.map((e) => e.toString()));
    return this;
  }

  /// Define o estilo do bloco.
  EBlockBuilder style(BlockStyle style) {
    _style = style;
    return this;
  }

  // ===========================================================================
  // MÉTODOS DE SAÍDA (Output)
  // ===========================================================================

  /// Constrói a string formatada com cores ANSI.
  String build() {
    if (_lines.isEmpty) return '';

    final buffer = StringBuffer();

    // Cor da barra lateral
    final barColor = _style.borderColor;
    // Caractere da barra
    final barChar = _style.borderChar;
    // Monta a barra: [COR][CHAR][RESET]
    final bar = '$barColor$barChar${XTermColor.reset}';

    // Helper para formatar o texto interno
    final textColor = _style.textColor;
    String formatText(String t) => '$textColor$t${XTermColor.reset}';

    // 1. Padding Superior (Opcional)
    // Ex: █
    if (_style.showPaddingLines) {
      buffer.writeln(bar);
    }

    // 2. Conteúdo
    // Ex: █  Texto...
    for (final line in _lines) {
      buffer.write(bar);
      buffer.write(_style.paddingLeft); // Espaço entre barra e texto
      buffer.writeln(formatText(line));
    }

    // 3. Padding Inferior (Opcional)
    // Ex: █
    if (_style.showPaddingLines) {
      buffer.write(bar);
    }

    return buffer.toString();
  }

  /// Imprime o bloco no console.
  ///
  /// [content] pode ser uma String única ou uma List<String>.
  /// [style] opcional para sobrescrever o estilo atual.
  void print([Object? content, BlockStyle? style]) {
    // 1. Aplica estilo se fornecido
    if (style != null) {
      _style = style;
    }

    // 2. Adiciona conteúdo se fornecido
    if (content != null) {
      if (content is List) {
        lines(content.cast<Object>());
      } else {
        text(content);
      }
    }

    // 3. Imprime
    if (_lines.isNotEmpty) {
      stdout.writeln(build());
    }

    // 4. Limpa o estado para reutilização (Importante para Singletons)
    _reset();
  }

  // ===========================================================================
  // ATALHOS SEMÂNTICOS
  // ===========================================================================

  /// Atalho para bloco de Sucesso (Verde).
  void success(Object message) {
    print(message, BlockPresets.success);
  }

  /// Atalho para bloco de Erro (Vermelho).
  void error(Object message) {
    print(message, BlockPresets.error);
  }

  /// Atalho para bloco de Aviso (Amarelo).
  void warning(Object message) {
    print(message, BlockPresets.warning);
  }

  /// Atalho para bloco de Informação (Ciano/Azul).
  void info(Object message) {
    print(message, BlockPresets.info);
  }

  // ===========================================================================
  // PRIVADOS
  // ===========================================================================

  void _reset() {
    _lines.clear();
    _style = BlockPresets.classic; // Volta ao padrão
  }
}
