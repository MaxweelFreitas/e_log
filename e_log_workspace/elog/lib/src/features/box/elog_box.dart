import '../../utils/string_utils.dart';
import '../../base/x_term/x_term_color.dart';
import '../../core/contracts/elog_renderable.dart';
import 'style/box_presets.dart';
import 'style/box_style.dart';

class ELogBox implements ELogRenderable {
  final List<String> lines;
  final BoxStyle style;
  final int padding;
  final String? title;
  final BoxTitleAlign titleAlign;

  const ELogBox({
    required this.lines,
    this.style = BoxPresets.standard,
    this.padding = 1,
    this.title,
    this.titleAlign = BoxTitleAlign.left,
  });

  @override
  String render() {
    final border = style.border;
    final borderColor = style.borderColor;
    const reset = XTermColor.reset;

    // Cor de Fundo (Background)
    final bgColor = style.backgroundColor;

    // Configuração de Sombra
    final shadowStyle = style.shadow;
    final hasShadow = shadowStyle != null;
    final shadowStr =
        hasShadow ? '${shadowStyle.color}${shadowStyle.char}$reset' : '';

    // -------------------------------------------------------------------------
    // 1. CÁLCULOS DE LARGURA
    // -------------------------------------------------------------------------

    // Largura do conteúdo (sem padding)
    final contentMaxLen = _maxLineLength(lines);

    // Largura do Título Completo (Texto + Conectores customizados)
    int titleTotalLen = 0;
    int tLeftLen = 0;
    int tRightLen = 0;

    if (title != null) {
      // Mede o tamanho visual exato dos conectores
      tLeftLen = StringUtils.visualLength(border.titleLeft);
      tRightLen = StringUtils.visualLength(border.titleRight);
      final titleTextLen = StringUtils.visualLength(title!);

      titleTotalLen = tLeftLen + titleTextLen + tRightLen;
    }

    // Calcula a largura interna necessária (InnerWidth)
    int innerWidth = contentMaxLen + (padding * 2);

    if (titleTotalLen > innerWidth) {
      innerWidth = titleTotalLen;
    }

    // Recalcula a largura efetiva do conteúdo para o padRight
    final effectiveContentWidth = innerWidth - (padding * 2);

    final buffer = StringBuffer();

    // -------------------------------------------------------------------------
    // 2. DESENHO: TOPO
    // -------------------------------------------------------------------------
    buffer.write('$bgColor$borderColor${border.topLeft}');

    if (title == null) {
      // Topo sem título
      buffer.write(border.top * innerWidth);
    } else {
      // Topo com título dinâmico
      final availableSpace = innerWidth - titleTotalLen;

      int leftDash = 0;
      int rightDash = 0;

      switch (titleAlign) {
        case BoxTitleAlign.left:
          leftDash = availableSpace > 0 ? 1 : 0;
          rightDash = availableSpace - leftDash;
          break;
        case BoxTitleAlign.center:
          leftDash = availableSpace ~/ 2;
          rightDash = availableSpace - leftDash;
          break;
        case BoxTitleAlign.right:
          rightDash = availableSpace > 0 ? 1 : 0;
          leftDash = availableSpace - rightDash;
          break;
      }

      if (leftDash < 0) leftDash = 0;
      if (rightDash < 0) rightDash = 0;

      buffer.write(border.top * leftDash);
      buffer.write(border.titleLeft);
      buffer.write(title);
      buffer.write('$bgColor$borderColor');
      buffer.write(border.titleRight);
      buffer.write(border.top * rightDash);
    }

    buffer.write('${border.topRight}$reset\n');

    // -------------------------------------------------------------------------
    // 3. DESENHO: CONTEÚDO
    // -------------------------------------------------------------------------
    for (final line in lines) {
      final paddedLine = StringUtils.padRight(line, effectiveContentWidth);
      final pad = ' ' * padding;

      // 1. Borda Esquerda
      buffer.write('$bgColor$borderColor${border.left}');

      // 2. Padding + Texto + Padding
      buffer.write('$reset$bgColor$pad$paddedLine$pad');

      // 3. Borda Direita
      buffer.write('$bgColor$borderColor${border.right}$reset');

      // 4. Sombra Lateral
      // CORREÇÃO: Removido espaço ' ' antes de $shadowStr
      if (hasShadow) buffer.write(shadowStr);

      buffer.write('\n');
    }

    // -------------------------------------------------------------------------
    // 4. DESENHO: BASE
    // -------------------------------------------------------------------------
    buffer.write(
        '$bgColor$borderColor${border.bottomLeft}${border.bottom * innerWidth}${border.bottomRight}$reset');

    // Canto da sombra na linha da base
    // CORREÇÃO: Removido espaço ' ' antes de $shadowStr
    if (hasShadow) buffer.write(shadowStr);

    // -------------------------------------------------------------------------
    // 5. DESENHO: SOMBRA INFERIOR
    // -------------------------------------------------------------------------
    if (hasShadow) {
      buffer.write('\n');
      // CORREÇÃO: Reduzido de 2 espaços para 1 espaço para alinhar com a lateral
      buffer.write(' ${shadowStr * (innerWidth + 2)}');
    }

    return buffer.toString();
  }

  int _maxLineLength(List<String> lines) {
    if (lines.isEmpty) return 0;
    return lines.fold(0, (max, line) {
      final len = StringUtils.visualLength(line);
      return len > max ? len : max;
    });
  }

  @override
  bool get isEmpty => lines.isEmpty;
}
