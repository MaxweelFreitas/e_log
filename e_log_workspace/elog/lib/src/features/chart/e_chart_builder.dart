import 'dart:io';
import 'dart:math' as math;
import '../../base/x_term/x_term_color.dart';
import '../../base/x_term/x_term_style.dart';
import '../../core/terminal/terminal_width.dart';
import '../../utils/color_utils.dart';
import '../../utils/string_utils.dart'; // Importante para visualLength
import 'style/chart_presets.dart';
import 'style/chart_style.dart';

// --- ENUMS ---

/// Define o tipo de gráfico (Compatibilidade com Demo).
enum ChartType { bar, line }

/// Define como o gradiente é aplicado.
enum ChartGradientType { global, bar }

// --- ITEM DO GRÁFICO ---

class EChartItem {
  final String label;
  final double value;
  EChartItem(this.label, this.value);
}

// --- BUILDER ---

class EChartBuilder {
  final List<EChartItem> _items = [];
  ChartStyle _style = ChartPresets.block;

  // Orientação interna
  ChartOrientation _orientation = ChartOrientation.horizontal;

  // Campos para Título e Tipo
  String? _title;

  Rgb? _gradientStart;
  Rgb? _gradientEnd;
  ChartGradientType _gradientType = ChartGradientType.global;

  // ===========================================================================
  // FLUENT SETTERS
  // ===========================================================================

  /// Define o título do gráfico.
  EChartBuilder title(String title) {
    _title = title;
    return this;
  }

  /// Define o tipo do gráfico e ajusta a orientação automaticamente.
  EChartBuilder type(ChartType type) {
    if (type == ChartType.bar) {
      _orientation = ChartOrientation.horizontal;
    }
    return this;
  }

  EChartBuilder add(String label, double value) {
    _items.add(EChartItem(label, value));
    return this;
  }

  /// Adiciona dados via Map.
  EChartBuilder data(Map<String, double> data) {
    data.forEach((key, value) => add(key, value));
    return this;
  }

  /// Alias para [data] (Compatibilidade).
  EChartBuilder addMap(Map<String, double> data) => this.data(data);

  EChartBuilder style(ChartStyle style) {
    _style = style;
    return this;
  }

  /// Define a largura do gráfico.
  /// (Requer que ChartStyle tenha o método copyWith implementado)
  EChartBuilder width(int width) {
    _style = _style.copyWith(size: width);
    return this;
  }

  EChartBuilder orientation(ChartOrientation orientation) {
    _orientation = orientation;
    return this;
  }

  EChartBuilder gradient(Rgb start, Rgb end,
      {ChartGradientType type = ChartGradientType.global}) {
    _gradientStart = start;
    _gradientEnd = end;
    _gradientType = type;
    return this;
  }

  // ===========================================================================
  // BUILD & PRINT
  // ===========================================================================

  String build() {
    final buffer = StringBuffer();

    // Renderiza Título se existir
    if (_title != null) {
      buffer.writeln('${XTermStyle.bold}$_title${XTermColor.reset}');
      buffer.writeln(); // Espaço em branco
    }

    if (_items.isEmpty) return 'No data.';

    buffer.write(_orientation == ChartOrientation.vertical
        ? _renderVertical()
        : _renderHorizontal());

    return buffer.toString();
  }

  void print() {
    stdout.write(build());
  }

  // ===========================================================================
  // RENDERIZADOR VERTICAL
  // ===========================================================================
  String _renderVertical() {
    final buffer = StringBuffer();
    if (_items.isEmpty) return '';

    final maxValue = _items.map((e) => e.value).reduce(math.max);
    final height = _style.size ?? 10;

    final colors = _generateColors(
        steps:
            _gradientType == ChartGradientType.global ? _items.length : height);

    for (int row = height; row > 0; row--) {
      final barGradientColor =
          (_gradientType == ChartGradientType.bar && colors != null)
              ? colors[height - row]
              : null;

      for (var i = 0; i < _items.length; i++) {
        final item = _items[i];

        final barCharWidth = StringUtils.visualLength(_style.barChar);
        final labelWidth = StringUtils.visualLength(item.label);

        final colWidth = _style.columnWidth ??
            math.max(3, math.max(labelWidth, barCharWidth));

        final itemHeight = (item.value / maxValue * height).round();

        final color =
            (_gradientType == ChartGradientType.global && colors != null)
                ? colors[i]
                : (barGradientColor ?? _style.barColor);

        var displayBarChar = _style.barChar;
        if (StringUtils.visualLength(displayBarChar) > colWidth) {
          displayBarChar = displayBarChar.substring(0, 1);
        }

        final paddingTotal =
            colWidth - StringUtils.visualLength(displayBarChar);
        final leftPad = ' ' * (paddingTotal ~/ 2);
        final rightPad = ' ' * (paddingTotal - (paddingTotal ~/ 2));

        if (itemHeight >= row) {
          buffer.write(
              '$leftPad$color$displayBarChar${XTermColor.reset}$rightPad');
        } else {
          buffer.write(' ' * colWidth);
        }

        buffer.write(' ' * _style.itemGap);
      }

      // Hack anti-agrupamento de linha
      if (row % 2 == 0) buffer.write('\u200B');
      buffer.write('\n');
    }

    _renderBottomLabels(buffer);
    return buffer.toString();
  }

  void _renderBottomLabels(StringBuffer buffer) {
    if (_style.showValue) {
      for (final item in _items) {
        final valStr = item.value.toInt().toString();
        // Simplificado: Assumindo largura baseada no maior elemento
        final width = _calculateColWidth(item);
        _writeCentered(buffer, valStr, width, _style.valueColor);
      }
      buffer.write('\n');
    }

    for (final item in _items) {
      final width = _calculateColWidth(item);
      _writeCentered(buffer, item.label, width, _style.labelColor);
    }
    buffer.write('\n');
  }

  int _calculateColWidth(EChartItem item) {
    final barCharWidth = StringUtils.visualLength(_style.barChar);
    final labelWidth = StringUtils.visualLength(item.label);
    return _style.columnWidth ??
        math.max(3, math.max(labelWidth, barCharWidth));
  }

  void _writeCentered(StringBuffer b, String text, int width, String color) {
    final vLen = StringUtils.visualLength(text);
    final padTotal = math.max(0, width - vLen);
    final l = ' ' * (padTotal ~/ 2);
    final r = ' ' * (padTotal - (padTotal ~/ 2));
    b.write('$l$color$text${XTermColor.reset}$r${' ' * _style.itemGap}');
  }

  // ===========================================================================
  // RENDERIZADOR HORIZONTAL
  // ===========================================================================
  String _renderHorizontal() {
    final buffer = StringBuffer();
    if (_items.isEmpty) return '';

    final maxValue = _items.map((e) => e.value).reduce(math.max);
    final maxLabelLen =
        _items.map((e) => StringUtils.visualLength(e.label)).reduce(math.max);

    final valueSpace = _style.showValue ? 7 : 0;
    final overhead = maxLabelLen + 1 + valueSpace;

    final totalWidth = TerminalWidthResolver.resolve(
      userWidth: _style.size,
      contentWidth: 80,
      maxWidth: stdout.hasTerminal ? stdout.terminalColumns : null,
    );

    final visualAvailableWidth = (totalWidth - overhead).clamp(10, 500);

    final barCharWidth = StringUtils.visualLength(_style.barChar).clamp(1, 4);
    final maxSlots = visualAvailableWidth ~/ barCharWidth;

    final colors = _generateColors(
      steps:
          _gradientType == ChartGradientType.global ? _items.length : maxSlots,
    );

    for (var i = 0; i < _items.length; i++) {
      final item = _items[i];
      final ratio = (item.value / maxValue).clamp(0.0, 1.0);

      final filledSlots = (ratio * maxSlots).round();

      final paddedLabel = StringUtils.padRight(item.label, maxLabelLen);

      buffer.write('${_style.labelColor}$paddedLabel ');

      if (_gradientType == ChartGradientType.bar && colors != null) {
        for (var k = 0; k < filledSlots; k++) {
          final color = k < colors.length ? colors[k] : colors.last;
          buffer.write('$color${_style.barChar}');
        }
      } else {
        final color = (colors != null) ? colors[i] : _style.barColor;
        buffer.write('$color${_style.barChar * filledSlots}');
      }

      buffer.write(XTermColor.reset);

      if (_style.emptyChar.isNotEmpty) {
        final emptyCharWidth = StringUtils.visualLength(_style.emptyChar);
        final emptySlots =
            (visualAvailableWidth - (filledSlots * barCharWidth)) ~/
                emptyCharWidth;
        final safeEmptySlots = math.max(0, emptySlots);
        buffer
            .write('${_style.emptyColor}${_style.emptyChar * safeEmptySlots}');
      }

      if (_style.showValue) {
        final valStr = item.value % 1 == 0
            ? item.value.toInt().toString()
            : item.value.toStringAsFixed(1);
        buffer.write(' ${_style.valueColor}$valStr');
      }

      if (i % 2 == 0) buffer.write('\u200B');

      buffer.write('${XTermColor.reset}\n');
    }
    return buffer.toString();
  }

  List<String>? _generateColors({required int steps}) {
    if (_gradientStart != null && _gradientEnd != null && steps > 0) {
      return ColorUtils.generateGradient(
        _gradientStart!,
        _gradientEnd!,
        steps,
      );
    }

    if (_style.gradientStart != null &&
        _style.gradientEnd != null &&
        steps > 0) {
      return ColorUtils.generateGradient(
        _style.gradientStart!,
        _style.gradientEnd!,
        steps,
      );
    }

    return null;
  }
}
