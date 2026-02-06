import 'dart:io';
import 'dart:math' as math;
import '../../base/x_term/x_term_color.dart';
import '../../base/x_term/x_term_style.dart';
import '../../core/terminal/terminal_width.dart';
import '../../utils/color_utils.dart';
import '../../utils/string_utils.dart';
import 'style/progress_style.dart';

class ProgressBuilder {
  final ProgressStyle style;
  final String label;
  final void Function(String) output;
  final int _total;

  final Rgb? gradientStart;
  final Rgb? gradientEnd;

  final bool showPercentage;

  List<String>? _gradientCache;
  int _barWidth = 0;
  int _current = 0;
  bool _started = false;
  String? _lastMessage;

  ProgressBuilder({
    required this.output,
    required this.label,
    this.style = ProgressStyle.block,
    int total = 100,
    int? width,
    this.gradientStart,
    this.gradientEnd,
    this.showPercentage = true,
  }) : _total = total {
    _calculateDimensions(width);
    _precomputeGradient();
  }

  void _calculateDimensions(int? userWidth) {
    try {
      final startLen = StringUtils.visualLength(style.startBorder);
      final endLen = StringUtils.visualLength(style.endBorder);
      final labelLen = StringUtils.visualLength(label);
      final fillLen = math.max(1, StringUtils.visualLength(style.filledChar));

      final percentSpace = showPercentage ? 5 : 0;

      final overhead = labelLen + 1 + startLen + endLen + 1 + percentSpace;

      final totalWidth = TerminalWidthResolver.resolve(
        userWidth: userWidth,
        contentWidth: 80,
        maxWidth: stdout.hasTerminal ? stdout.terminalColumns : null,
      );

      // --- CORREÇÃO DO LAYOUT ---
      // Subtraímos 1 para garantir que a linha não quebre automaticamente
      final availableColumns = (totalWidth - overhead - 1).clamp(5, 500);

      _barWidth = availableColumns ~/ fillLen;
    } catch (e) {
      _barWidth = 30;
    }
  }

  void _precomputeGradient() {
    if (_barWidth <= 0) return;

    if (gradientStart != null && gradientEnd != null) {
      _gradientCache =
          ColorUtils.generateGradient(gradientStart!, gradientEnd!, _barWidth);
      return;
    }

    if (style.gradientStart != null && style.gradientEnd != null) {
      _gradientCache = ColorUtils.generateGradient(
          style.gradientStart!, style.gradientEnd!, _barWidth);
    }
  }

  void update(int current, {String? message}) {
    // Garante inicialização
    if (!_started) _started = true;

    _current = current;
    if (_current > _total) _current = _total;
    if (_current < 0) _current = 0;

    if (message != null) {
      _lastMessage = message;
    }

    output(render());
  }

  void increment([int amount = 1]) => update(_current + amount);

  String render() {
    final pct = (_current / _total).clamp(0.0, 1.0);
    final percentInt = (pct * 100).toInt();

    final filledCount = (pct * _barWidth).round();
    final emptyCount = math.max(0, _barWidth - filledCount);

    final buffer = StringBuffer();

    // Limpa a linha e volta ao início
    buffer.write('\x1b[2K\r');

    // Label
    buffer.write('${XTermStyle.bold}$label${XTermColor.reset} ');

    // Borda Esq
    final borderColor = style.borderColor ?? XTermColor.brightBlack;
    buffer.write('$borderColor${style.startBorder}');

    if (style.textStyle != null) buffer.write(style.textStyle);
    if (style.underlineColor != null) buffer.write(style.underlineColor);

    // Barra Preenchida
    if (_gradientCache != null && _gradientCache!.isNotEmpty) {
      for (var i = 0; i < filledCount; i++) {
        final color = (i < _gradientCache!.length)
            ? _gradientCache![i]
            : _gradientCache!.last;
        if (style.tip != null &&
            i == filledCount - 1 &&
            filledCount < _barWidth) {
          buffer.write('$color${style.tip}');
        } else {
          buffer.write('$color${style.filledChar}');
        }
      }
    } else {
      final barColor = style.filledColor ?? XTermColor.green;
      if (filledCount > 0) {
        if (style.tip != null && filledCount < _barWidth) {
          buffer.write(
              '$barColor${style.filledChar * (filledCount - 1)}${style.tip}');
        } else {
          buffer.write('$barColor${style.filledChar * filledCount}');
        }
      }
    }

    // Barra Vazia
    final emptyColor = style.emptyColor ?? XTermColor.brightBlack;
    if (style.underlineColor == null) buffer.write(XTermColor.reset);
    if (emptyCount > 0) {
      buffer.write('$emptyColor${style.emptyChar * emptyCount}');
    }

    buffer.write(XTermColor.reset);

    // Borda Dir
    buffer.write('$borderColor${style.endBorder}');

    // Porcentagem
    if (showPercentage) {
      final percentStr = percentInt.toString().padLeft(3);
      buffer.write(' ${XTermColor.cyan}$percentStr%${XTermColor.reset}');
    }

    // Mensagem
    if (_lastMessage != null && _lastMessage!.isNotEmpty) {
      buffer.write(' $_lastMessage');
    }

    return buffer.toString();
  }

  String finish({String? message}) {
    _current = _total;
    final barLine = render();

    output(barLine);
    output('\n'); // Quebra de linha apenas no final

    if (message != null) {
      output('${XTermColor.green}✔ $message${XTermColor.reset}\n');
    }
    return barLine;
  }
}
