import 'dart:io';
import 'dart:math' as math;
import '../../base/x_term/x_term_color.dart';
import '../../base/x_term/x_term_style.dart';
import '../../core/terminal/terminal_width.dart';
import '../../utils/color_utils.dart';
import 'style/progress_style.dart';

class ProgressBuilder {
  final ProgressStyle style;
  final String label;
  final void Function(String) output;
  final int _total;

  final Rgb? gradientStart;
  final Rgb? gradientEnd;

  List<String>? _gradientCache;
  int _barWidth = 0;
  int _current = 0;
  bool _started = false;

  ProgressBuilder({
    required this.output,
    required this.label,
    this.style = ProgressStyle.block,
    int total = 100,
    int? width,
    this.gradientStart,
    this.gradientEnd,
  }) : _total = total {
    _calculateDimensions(width);
    _precomputeGradient();
  }

  void _calculateDimensions(int? userWidth) {
    try {
      // 1. Calcula a largura visual de um "bloco" (unidade de progresso)
      final charWidth =
          math.max(style.filledChar.length, style.emptyChar.length);
      final safeCharWidth = charWidth > 0 ? charWidth : 1;

      // 2. Calcula o "Overhead" (Espaço fixo ocupado por bordas e texto)
      final overhead = style.startBorder.length + style.endBorder.length + 7;

      // 3. Obtém a largura total disponível usando o Resolver
      final totalWidth = TerminalWidthResolver.resolve(
        userWidth: userWidth,
        contentWidth: 80, // Fallback padrão
        maxWidth: stdout.hasTerminal ? stdout.terminalColumns : null,
      );

      // 4. Subtrai o overhead para saber quanto espaço sobra para a BARRA
      final availableColumns = (totalWidth - overhead).clamp(10, 500);

      // 5. Define a largura em "passos"
      _barWidth = availableColumns ~/ safeCharWidth;
    } on Exception {
      _barWidth = 40;
    }
  }

  /// Gera o cache de gradiente respeitando a prioridade:
  /// 1. Manual (Passado no construtor)
  /// 2. Estilo (Definido no Preset)
  void _precomputeGradient() {
    // 1. Prioridade: Gradiente Manual
    if (gradientStart != null && gradientEnd != null) {
      _gradientCache =
          ColorUtils.generateGradient(gradientStart!, gradientEnd!, _barWidth);
      return;
    }

    // 2. Prioridade: Gradiente do Estilo (Preset)
    // --- ADICIONADO ESTE BLOCO ---
    if (style.gradientStart != null && style.gradientEnd != null) {
      _gradientCache = ColorUtils.generateGradient(
          style.gradientStart!, style.gradientEnd!, _barWidth);
    }
  }

  void update(int current) {
    if (!_started) {
      output('\x1b[2K\r${XTermStyle.bold}$label${XTermColor.reset}\n');
      _started = true;
    }

    _current = current;
    if (_current > _total) _current = _total;
    output(render());
  }

  void increment([int amount = 1]) => update(_current + amount);

  String render() {
    final pct = (_current / _total).clamp(0.0, 1.0);
    final percentInt = (pct * 100).toInt();
    final percentStr = percentInt.toString().padLeft(3);

    final filledCount = (pct * _barWidth).round();
    final emptyCount = _barWidth - filledCount;

    final buffer = StringBuffer();
    buffer.write('\x1b[2K\r'); // Limpa linha

    // Borda Esquerda
    final borderColor = style.borderColor ?? XTermColor.brightBlack;
    buffer.write('$borderColor${style.startBorder}');

    // Estilos de texto (Bold, Underline...)
    if (style.textStyle != null) buffer.write(style.textStyle);
    if (style.underlineColor != null) buffer.write(style.underlineColor);

    // --- PARTE PREENCHIDA ---
    if (_gradientCache != null) {
      for (var i = 0; i < filledCount; i++) {
        // Lógica do TIP (Ponta da barra) com cor do gradiente atual
        if (style.tip != null &&
            i == filledCount - 1 &&
            filledCount < _barWidth) {
          buffer.write('${_gradientCache![i]}${style.tip}');
        } else {
          buffer.write('${_gradientCache![i]}${style.filledChar}');
        }
      }
    } else {
      final barColor = style.filledColor ?? XTermColor.green;
      if (style.tip != null && filledCount > 0 && filledCount < _barWidth) {
        // Desenha barra - 1 + ponta
        buffer.write(
            '$barColor${style.filledChar * (filledCount - 1)}${style.tip}');
      } else {
        buffer.write('$barColor${style.filledChar * filledCount}');
      }
    }

    // --- PARTE VAZIA ---
    final emptyColor = style.emptyColor ?? XTermColor.brightBlack;

    // Reseta cor da barra anterior para aplicar a cor do vazio corretamente
    // (A menos que seja underline, que queremos manter para o "chão" do Pacman)
    if (style.underlineColor == null) {
      buffer.write(XTermColor.reset);
    }

    buffer.write('$emptyColor${style.emptyChar * emptyCount}');

    // Reseta tudo
    buffer.write(XTermColor.reset);

    // Borda Direita + Porcentagem
    buffer.write('$borderColor${style.endBorder} ');
    buffer.write('${XTermColor.cyan}$percentStr%');
    buffer.write(XTermColor.reset);

    return buffer.toString();
  }

  String finish({String? message}) {
    _current = _total;
    final barLine = render();
    output(barLine);
    output('\n');
    if (message != null) {
      output('${XTermColor.green}✔ $message${XTermColor.reset}\n');
    }
    return barLine;
  }
}
