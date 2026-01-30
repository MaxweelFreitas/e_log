import 'dart:io';
import 'dart:math' as math;
import '../../base/x_term/x_term_color.dart';
import '../../core/terminal/terminal_width.dart';
import '../../utils/color_utils.dart';
import 'style/chart_presets.dart';
import 'style/chart_style.dart';

enum ChartGradientType { global, bar }

class EChartItem {
  final String label;
  final double value;
  EChartItem(this.label, this.value);
}

class EChartBuilder {
  final List<EChartItem> _items = [];
  ChartStyle _style = ChartPresets.block;
  ChartOrientation _orientation = ChartOrientation.horizontal;

  Rgb? _gradientStart;
  Rgb? _gradientEnd;
  ChartGradientType _gradientType = ChartGradientType.global;

  EChartBuilder add(String label, double value) {
    _items.add(EChartItem(label, value));
    return this;
  }

  EChartBuilder addMap(Map<String, double> data) {
    data.forEach((key, value) => add(key, value));
    return this;
  }

  EChartBuilder style(ChartStyle style) {
    _style = style;
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

  String build() {
    if (_items.isEmpty) return 'No data.';
    return _orientation == ChartOrientation.vertical
        ? _renderVertical()
        : _renderHorizontal();
  }

  void print() {
    stdout.write(build());
  }

  // ===========================================================================
  // RENDERIZADOR VERTICAL
  // ===========================================================================
  String _renderVertical() {
    final buffer = StringBuffer();
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

        final barCharWidth = _style.barChar.length;
        final labelWidth = item.label.length;

        final colWidth = _style.columnWidth ??
            math.max(3, math.max(labelWidth, barCharWidth));

        final itemHeight = (item.value / maxValue * height).round();

        final color =
            (_gradientType == ChartGradientType.global && colors != null)
                ? colors[i]
                : (barGradientColor ?? _style.barColor);

        var displayBarChar = _style.barChar;
        if (displayBarChar.length > colWidth) {
          displayBarChar = displayBarChar.substring(0, colWidth);
        }

        final paddingTotal = colWidth - displayBarChar.length;
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

      // --- HACK ANTI-AGRUPAMENTO ---
      if (row % 2 == 0) buffer.write('\u200B');

      buffer.write('\n');
    }

    _renderBottomLabels(buffer);
    return buffer.toString();
  }

  void _renderBottomLabels(StringBuffer buffer) {
    if (_style.showValue) {
      for (final item in _items) {
        final valStr = item.value % 1 == 0
            ? item.value.toInt().toString()
            : item.value.toStringAsFixed(0);

        final barCharWidth = _style.barChar.length;
        final labelWidth = item.label.length;
        final valWidth = valStr.length;

        final colWidth = _style.columnWidth ??
            math.max(3, [labelWidth, barCharWidth, valWidth].reduce(math.max));

        final displayVal =
            valStr.length > colWidth ? valStr.substring(0, colWidth) : valStr;

        _writeCentered(buffer, displayVal, colWidth, _style.valueColor);
      }
      buffer.write('\n');
    }

    for (final item in _items) {
      final barCharWidth = _style.barChar.length;
      final labelWidth = item.label.length;

      final colWidth =
          _style.columnWidth ?? math.max(3, math.max(labelWidth, barCharWidth));

      final displayLabel = item.label.length > colWidth
          ? item.label.substring(0, colWidth)
          : item.label;

      _writeCentered(buffer, displayLabel, colWidth, _style.labelColor);
    }
    buffer.write('\n');
  }

  void _writeCentered(StringBuffer b, String text, int width, String color) {
    final padTotal = width - text.length;
    final l = ' ' * (padTotal ~/ 2);
    final r = ' ' * (padTotal - (padTotal ~/ 2));
    b.write('$l$color$text${XTermColor.reset}$r${' ' * _style.itemGap}');
  }

  // ===========================================================================
  // RENDERIZADOR HORIZONTAL
  // ===========================================================================
  String _renderHorizontal() {
    final buffer = StringBuffer();
    final maxValue = _items.map((e) => e.value).reduce(math.max);
    final maxLabelLen = _items.map((e) => e.label.length).reduce(math.max);

    final valueSpace = _style.showValue ? 7 : 0;
    final overhead = maxLabelLen + 1 + valueSpace;

    final totalWidth = TerminalWidthResolver.resolve(
      userWidth: _style.size,
      contentWidth: 80,
      maxWidth: stdout.hasTerminal ? stdout.terminalColumns : null,
    );

    final visualAvailableWidth = (totalWidth - overhead).clamp(10, 500);

    final barCharWidth = _style.barChar.isNotEmpty ? _style.barChar.length : 1;
    final maxSlots = visualAvailableWidth ~/ barCharWidth;

    final colors = _generateColors(
      steps:
          _gradientType == ChartGradientType.global ? _items.length : maxSlots,
    );

    for (var i = 0; i < _items.length; i++) {
      final item = _items[i];
      final ratio = (item.value / maxValue).clamp(0.0, 1.0);

      final filledSlots = (ratio * maxSlots).round();
      final usedVisualWidth = filledSlots * barCharWidth;
      final remainingVisualWidth = visualAvailableWidth - usedVisualWidth;
      final paddedLabel = item.label.padLeft(maxLabelLen);

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
        final emptyCharWidth = _style.emptyChar.length;
        final emptySlots = remainingVisualWidth ~/ emptyCharWidth;

        // --- ALTERAÇÃO AQUI: Usa _style.emptyColor em vez de hardcoded ---
        buffer.write('${_style.emptyColor}${_style.emptyChar * emptySlots}');
      }

      if (_style.showValue) {
        final valStr = item.value % 1 == 0
            ? item.value.toInt().toString()
            : item.value.toStringAsFixed(1);
        buffer.write(' ${_style.valueColor}$valStr');
      }

      // --- HACK ANTI-AGRUPAMENTO ---
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
