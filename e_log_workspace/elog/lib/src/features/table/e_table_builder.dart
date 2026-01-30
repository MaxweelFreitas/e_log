import '../../base/x_term/x_term_color.dart';
// Importe seu StringUtils corretamente
import '../../utils/string_utils.dart';
import 'model/e_cell.dart';
import 'model/e_cell_text_align.dart';
import 'style/table_style.dart';
import 'style/table_presets.dart';

class ETableBuilder {
  final List<dynamic> _headers = [];
  final List<List<dynamic>> _rows = [];

  List<ECellTextAlign> _columnAlignments = [];

  TableStyle _style = TablePresets.classic;
  bool _showHeaders = true;

  // ===========================================================================
  // CONFIGURATION
  // ===========================================================================

  /// Define os cabeçalhos da tabela.
  ETableBuilder headers(List<dynamic> headers) {
    _headers.clear();
    _headers.addAll(headers);
    return this;
  }

  /// Define o alinhamento de cada coluna.
  ETableBuilder align(List<ECellTextAlign> alignments) {
    _columnAlignments = alignments;
    return this;
  }

  /// Adiciona uma linha de dados.
  ETableBuilder row(List<dynamic> cells) {
    _rows.add(cells);
    return this;
  }

  /// Adiciona múltiplas linhas.
  ETableBuilder rows(List<List<dynamic>> rows) {
    _rows.addAll(rows);
    return this;
  }

  /// Define o estilo visual da tabela.
  ETableBuilder style(TableStyle style) {
    _style = style;
    return this;
  }

  /// Define se deve mostrar o header (útil para listas simples)
  ETableBuilder showHeaders(bool show) {
    _showHeaders = show;
    return this;
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  String build() {
    if (_headers.isEmpty && _rows.isEmpty) return '';

    // --- Helper para extrair texto (String ou ECell) ---
    String getText(dynamic item) {
      if (item is ECell) return item.content;
      return item.toString();
    }

    // 1. CÁLCULO DE LARGURAS (Visual Length)
    final columnWidths = <int, int>{};

    // Determina o número máximo de colunas
    int columnsCount = _headers.length;
    if (_rows.isNotEmpty) {
      for (final row in _rows) {
        if (row.length > columnsCount) columnsCount = row.length;
      }
    }

    // Mede Headers (Usando StringUtils para suportar Emojis/CJK)
    for (var i = 0; i < columnsCount; i++) {
      int w = 0;
      if (i < _headers.length) {
        final text = getText(_headers[i]);
        w = StringUtils.visualLength(text);
      }
      columnWidths[i] = w;
    }

    // Mede Rows e atualiza largura máxima
    for (final row in _rows) {
      for (var i = 0; i < columnsCount; i++) {
        if (i < row.length) {
          final text = getText(row[i]);
          final len = StringUtils.visualLength(text);
          final currentMax = columnWidths[i] ?? 0;
          if (len > currentMax) {
            columnWidths[i] = len;
          }
        }
      }
    }

    // 2. RENDERIZAÇÃO
    final buffer = StringBuffer();
    final border = _style.border;
    final cBorder = _style.borderColor;
    final cHeader = _style.headerColor;
    final cContent = _style.contentColor;
    final bgHeader = _style.headerBackground;
    final bgContent = _style.contentBackground;
    const cReset = XTermColor.reset;

    // --- Helpers de Renderização ---

    /// Aplica o alinhamento adicionando espaços (padding)
    String applyAlign(String text, int targetWidth, ECellTextAlign align) {
      // O SEGREDO ESTÁ AQUI: Medir visualmente para saber quanto falta
      final textLen = StringUtils.visualLength(text);
      final padding = targetWidth - textLen;

      if (padding <= 0) return text;

      // Espaços são width=1, então padding chars = padding visual
      switch (align) {
        case ECellTextAlign.left:
          return text + (' ' * padding);
        case ECellTextAlign.right:
          return (' ' * padding) + text;
        case ECellTextAlign.center:
          final l = padding ~/ 2;
          final r = padding - l;
          return (' ' * l) + text + (' ' * r);
      }
    }

    void drawHorizontalLine(String start, String line, String sep, String end) {
      buffer.write('$cBorder$start');
      for (var i = 0; i < columnsCount; i++) {
        final w = columnWidths[i] ?? 0;
        // +2 para compensar o padding interno de 1 espaço cada lado
        buffer.write(line * (w + 2));
        if (i < columnsCount - 1) buffer.write(sep);
      }
      buffer.write('$end$cReset\n');
    }

    void drawContentRow(List<dynamic> data, {bool isHeader = false}) {
      final textColor = isHeader ? cHeader : cContent;
      final bgColor = isHeader ? bgHeader : bgContent;

      // Se tiver background, não desenhamos bordas verticais internas vazadas
      final hasBg = bgColor.isNotEmpty;
      final leftChar = hasBg ? ' ' : border.left;
      final rightChar = hasBg ? ' ' : border.right;
      final vertChar = hasBg ? ' ' : border.vertical;
      final borderPaint = hasBg ? bgColor : cBorder;

      buffer.write('$borderPaint$leftChar$cReset');

      for (var i = 0; i < columnsCount; i++) {
        final w = columnWidths[i] ?? 0;
        final cellData = i < data.length ? data[i] : '';

        // --- Resolução de Dados e Alinhamento ---
        String text;
        ECellTextAlign align;

        // Alinhamento padrão da coluna
        final colAlign = (i < _columnAlignments.length)
            ? _columnAlignments[i]
            : ECellTextAlign.left;

        if (cellData is ECell) {
          text = cellData.content;
          align = cellData.align ?? colAlign;
        } else {
          text = cellData.toString();
          align = colAlign;
        }

        // Formata usando largura visual correta
        final formattedText = applyAlign(text, w, align);

        // Desenha: Background + Espaço + TextoFormatado + Espaço + Reset
        // Nota: Os espaços ao redor do formattedText são o padding padrão da tabela
        buffer.write('$bgColor $textColor$formattedText $cReset');

        if (i < columnsCount - 1) {
          buffer.write('$borderPaint$vertChar$cReset');
        }
      }

      buffer.write('$borderPaint$rightChar$cReset\n');
    }

    // --- DESENHO DA ESTRUTURA ---

    final bool headerIsSolid = bgHeader.isNotEmpty;
    final bool contentIsSolid = bgContent.isNotEmpty;

    // 1. TOPO
    // Só desenha borda superior se não tiver header sólido (estilo flat)
    // ou se o estilo pedir borda explicita.
    // Aqui mantemos a lógica clássica:
    if (!headerIsSolid) {
      drawHorizontalLine(
          border.topLeft, border.top, border.topMid, border.topRight);
    }

    // 2. CABEÇALHOS
    if (_headers.isNotEmpty && _showHeaders) {
      drawContentRow(_headers, isHeader: true);

      if (headerIsSolid) {
        // Se header é sólido e corpo não, precisamos de uma linha separadora/topo do corpo
        if (!contentIsSolid) {
          drawHorizontalLine(
              border.topLeft, border.top, border.topMid, border.topRight);
        }
      } else {
        // Header vazado (padrão): Desenha separador Mid
        drawHorizontalLine(
            border.midLeft, border.middle, border.center, border.midRight);
      }
    } else {
      // Sem headers
      if (!contentIsSolid && !headerIsSolid) {
        drawHorizontalLine(
            border.topLeft, border.top, border.topMid, border.topRight);
      }
    }

    // 3. CORPO
    for (var i = 0; i < _rows.length; i++) {
      drawContentRow(_rows[i]);
    }

    // 4. BASE
    if (!contentIsSolid) {
      drawHorizontalLine(border.bottomLeft, border.bottom, border.bottomMid,
          border.bottomRight);
    }

    return buffer.toString();
  }
}
