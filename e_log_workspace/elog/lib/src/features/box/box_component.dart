import '../../base/x_term/x_term_color.dart';
import '../../core/contracts/elog_renderable.dart';
import 'style/box_presets.dart';
import 'style/box_style.dart'; // Certifique-se que o caminho está certo
import '../../utils/string_utils.dart'; // Importante para alinhar cores corretamente

class BoxComponent implements ELogRenderable {
  final List<String> content;
  final BoxStyle style;
  final String? title;

  const BoxComponent(
    this.content, {
    this.style = BoxPresets.standard,
    this.title,
  });

  @override
  String render() {
    final border = style.border;
    final borderColor = style.borderColor;
    const reset = XTermColor.reset;

    // 1. Verifica se tem sombra configurada no estilo
    final shadowStyle = style.shadow;
    final hasShadow = shadowStyle != null;

    // Prepara a string da sombra (ex: cor + caractere + reset)
    final shadowStr =
        hasShadow ? '${shadowStyle.color}${shadowStyle.char}$reset' : '';

    // 2. Calcular largura do conteúdo (Usando StringUtils para ignorar ANSI)
    final contentWidth = _calculateMaxWidth();
    final innerWidth = contentWidth + (style.padding * 2);

    final buffer = StringBuffer();

    // 3. Topo
    buffer.write(
        '$borderColor${border.topLeft}${border.top * innerWidth}${border.topRight}$reset');

    if (hasShadow) {
      buffer.write(
          '\n'); // Sombra empurra o topo para baixo visualmente? Não, mas precisamos quebrar linha se for shadow block.
    }
    // Ajuste lógico: Se tem sombra, geralmente o topo não tem sombra lateral,
    // mas se quisermos ser consistentes com o ELogBox anterior:
    if (!hasShadow) {
      buffer.write('\n'); // Se não tem sombra, quebra linha normal.
    } else {
      buffer.write('\n'); // Mantém a quebra.
    }

    // (Opcional: Lógica de título aqui)

    // 4. Conteúdo
    for (final line in content) {
      // Padding inteligente que ignora cores ANSI na contagem
      final paddedLine = StringUtils.padRight(line, contentWidth);
      final padding = ' ' * style.padding;

      buffer.write('$borderColor${border.left}$reset');
      buffer.write('$padding$paddedLine$padding');
      buffer.write('$borderColor${border.right}$reset');

      // Sombra lateral
      if (hasShadow) buffer.write(' $shadowStr');

      buffer.write('\n');
    }

    // 5. Base
    buffer.write(
        '$borderColor${border.bottomLeft}${border.bottom * innerWidth}${border.bottomRight}$reset');

    // Sombra inferior
    if (hasShadow) {
      // Canto da sombra lateral
      buffer.write(' $shadowStr\n');

      // Barra inferior deslocada (2 espaços para alinhar à direita)
      buffer.write('  ${shadowStr * (innerWidth + 2)}');
    }

    return buffer.toString();
  }

  int _calculateMaxWidth() {
    int max = 0;
    if (title != null) max = StringUtils.visualLength(title!);

    for (final line in content) {
      // Usa visualLength para contar corretamente mesmo com cores
      final len = StringUtils.visualLength(line);
      if (len > max) max = len;
    }
    return max;
  }

  @override
  bool get isEmpty => content.isEmpty;
}
