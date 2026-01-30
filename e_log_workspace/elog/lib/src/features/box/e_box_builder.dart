import 'dart:math' as math;
import '../../base/x_term/x_term_color.dart';
// import '../../text/elog_text_wrap.dart'; // <-- Removido, faremos o wrap localmente
import '../../utils/string_utils.dart';
import '../../utils/color_utils.dart';
import '../../core/terminal/terminal_info.dart';

import 'style/box_presets.dart';
import 'style/box_style.dart';
import 'style/shadow_style.dart';

class EBoxBuilder {
  // --- Estado Interno ---
  String _content = '';
  BoxStyle _style = BoxPresets.standard;
  int _padding = 1;
  ShadowStyle? _shadowOverride;

  String? _title;
  BoxTitleAlign _titleAlign = BoxTitleAlign.left;
  BoxOverflow _overflow = BoxOverflow.wrap;

  // Controle de Largura
  int? _fixedWidth;
  int? _minWidth;

  // Overrides
  String? _titleBorderLeftOverride;
  String? _titleBorderRightOverride;

  // --- Métodos de Configuração ---
  EBoxBuilder content(String value) {
    _content = value;
    return this;
  }

  EBoxBuilder title(
    String text, {
    BoxTitleAlign align = BoxTitleAlign.left,
    String? borderLeft,
    String? borderRight,
  }) {
    _title = text;
    _titleAlign = align;
    _titleBorderLeftOverride = borderLeft;
    _titleBorderRightOverride = borderRight;
    return this;
  }

  EBoxBuilder style(BoxStyle style) {
    _style = style;
    return this;
  }

  EBoxBuilder padding(int value) {
    _padding = value;
    return this;
  }

  EBoxBuilder overflow(BoxOverflow mode) {
    _overflow = mode;
    return this;
  }

  EBoxBuilder shadow(ShadowStyle style) {
    _shadowOverride = style;
    return this;
  }

  EBoxBuilder withShadow() {
    _shadowOverride = ShadowStyle.light;
    return this;
  }

  EBoxBuilder width(int width) {
    _fixedWidth = width;
    return this;
  }

  EBoxBuilder autoWidth() {
    _fixedWidth = null;
    return this;
  }

  EBoxBuilder minWidth(int width) {
    _minWidth = width;
    return this;
  }

  // --- Build ---

  String build({int? maxWidth}) {
    // 1. Resolve Estilo
    final activeStyle = _style;
    final activeShadow = _shadowOverride ?? _style.shadow;
    final hasShadow = activeShadow != null;
    final int shadowCharVisLen =
        hasShadow ? StringUtils.visualLength(activeShadow.char) : 0;

    // 2. Resolve Bordas e Marcadores
    final bSet = activeStyle.border;
    final borderLeftW = StringUtils.visualLength(bSet.left);
    final borderRightW = StringUtils.visualLength(bSet.right);
    final cornerTopLeftW = StringUtils.visualLength(bSet.topLeft);
    final cornerTopRightW = StringUtils.visualLength(bSet.topRight);

    final rawL = _titleBorderLeftOverride ?? bSet.titleLeft;
    final rawR = _titleBorderRightOverride ?? bSet.titleRight;
    final finalMarkerL = rawL.isNotEmpty ? '$rawL ' : '';
    final finalMarkerR = rawR.isNotEmpty ? ' $rawR' : '';
    final markerLVis = StringUtils.visualLength(finalMarkerL);
    final markerRVis = StringUtils.visualLength(finalMarkerR);

    // 3. CALCULA LARGURA
    // Para cálculo inicial de AutoWidth, usamos o "maior pedaço contínuo"
    // ou a linha inteira, mas o Word Wrap vai se ajustar depois.
    final rawContentLines = _content.split('\n');
    final maxContentLine = rawContentLines.fold(
        0, (prev, e) => math.max(prev, StringUtils.visualLength(e)));
    final contentStructureWidth = borderLeftW + borderRightW + (_padding * 2);
    final contentBasedWidth = maxContentLine + contentStructureWidth;

    int titleBasedWidth = 0;
    if (_title != null) {
      final titleVis = StringUtils.visualLength(_title!);
      titleBasedWidth = cornerTopLeftW +
          1 +
          markerLVis +
          titleVis +
          markerRVis +
          1 +
          cornerTopRightW;
    }

    final int idealAutoWidth = math.max(contentBasedWidth, titleBasedWidth);
    int targetWidth = _fixedWidth ?? idealAutoWidth;

    if (_minWidth != null) {
      targetWidth = math.max(targetWidth, _minWidth!);
    }

    final int maxAllowed =
        (maxWidth ?? TerminalInfo.width ?? 100) - shadowCharVisLen;
    final int resolvedBoxWidth = math.min(targetWidth, maxAllowed);

    final int safeContentWidth = resolvedBoxWidth - contentStructureWidth;
    final int finalContentWidth = safeContentWidth > 0 ? safeContentWidth : 1;

    // 4. TRATAMENTO DO TÍTULO
    String? effectiveTitle = _title;
    if (_title != null) {
      final int topOverhead =
          cornerTopLeftW + cornerTopRightW + markerLVis + markerRVis + 2;
      final int maxTitleSpace = resolvedBoxWidth - topOverhead;
      final int currentTitleLen = StringUtils.visualLength(_title!);

      if (maxTitleSpace <= 0) {
        effectiveTitle = '';
      } else if (currentTitleLen > maxTitleSpace) {
        if (maxTitleSpace > 3) {
          String truncated = StringUtils.truncate(_title!, maxTitleSpace - 3);
          truncated = truncated.replaceAll('\x1B[0m', '');
          effectiveTitle = '$truncated...';
        } else {
          effectiveTitle = StringUtils.truncate(_title!, maxTitleSpace);
        }
      }
    }

    // 5. WRAP CONTEÚDO (NOVA LÓGICA: Word Wrap)
    List<String> lines;
    if (_overflow == BoxOverflow.ellipsis) {
      lines = [StringUtils.truncate(_content, finalContentWidth)];
    } else {
      // CORREÇÃO: Usa o _smartWrap local em vez do ELogTextWrap genérico
      lines = _smartWrap(_content, finalContentWidth);
    }

    // =========================================================================
    // RENDERIZAÇÃO
    // =========================================================================

    final bool hasTop = bSet.top.isNotEmpty || bSet.topLeft.isNotEmpty;
    final bool hasBottom = bSet.bottom.isNotEmpty || bSet.bottomLeft.isNotEmpty;
    final int totalHeight =
        (hasTop ? 1 : 0) + (_padding * 2) + lines.length + (hasBottom ? 1 : 0);

    String getBgColorAt(int x, int y) {
      if (!activeStyle.isBackgroundGradient) return activeStyle.backgroundColor;
      double t = 0.0;
      final w = resolvedBoxWidth > 1 ? resolvedBoxWidth - 1 : 1;
      final h = totalHeight > 1 ? totalHeight - 1 : 1;
      switch (activeStyle.backgroundGradientDir) {
        case GradientDirection.vertical:
          t = y / h;
          break;
        case GradientDirection.horizontal:
          t = x / w;
          break;
        case GradientDirection.diagonal:
          t = (x / w + y / h) / 2;
          break;
        case GradientDirection.diagonalBack:
          t = (x / w + (1 - y / h)) / 2;
          break;
      }
      return Rgb.interpolate(activeStyle.backgroundGradientStart!,
              activeStyle.backgroundGradientEnd!, t)
          .toAnsi(isBackground: true);
    }

    final buffer = StringBuffer();
    final bColor = activeStyle.borderColor;
    const reset = XTermColor.reset;
    int currentY = 0;

    void writeLine({
      required String left,
      required String middleContent,
      required String right,
      List<String>? customSegments,
      bool drawShadow = true,
    }) {
      buffer.write(getBgColorAt(0, currentY));
      buffer.write(bColor);
      buffer.write(left);

      int currentX = borderLeftW;

      if (activeStyle.backgroundGradientDir == GradientDirection.vertical ||
          !activeStyle.isBackgroundGradient) {
        buffer.write(getBgColorAt(0, currentY));
        buffer.write(middleContent);
        currentX += StringUtils.visualLength(middleContent);
      } else {
        final segments = customSegments ?? middleContent.split('');
        for (var segment in segments) {
          buffer.write(getBgColorAt(currentX, currentY));
          buffer.write(segment);
          currentX += StringUtils.visualLength(segment);
        }
      }

      final remainingSpace =
          resolvedBoxWidth - currentX - StringUtils.visualLength(right);
      if (remainingSpace > 0) {
        if (activeStyle.backgroundGradientDir == GradientDirection.vertical ||
            !activeStyle.isBackgroundGradient) {
          buffer.write(' ' * remainingSpace);
        } else {
          for (int i = 0; i < remainingSpace; i++) {
            buffer.write(getBgColorAt(currentX, currentY));
            buffer.write(' ');
            currentX++;
          }
        }
      }

      buffer.write(getBgColorAt(currentX, currentY));
      buffer.write(bColor);
      buffer.write(right);

      buffer.write(reset);

      if (hasShadow && drawShadow) {
        String shadowColor = activeShadow.color;
        if (activeShadow.isGradient) {
          double tShadow = currentY / (totalHeight > 1 ? totalHeight - 1 : 1);
          shadowColor = Rgb.interpolate(activeShadow.gradientStart!,
                  activeShadow.gradientEnd!, tShadow)
              .toAnsi();
        }
        buffer.write(shadowColor);
        buffer.write(activeShadow.char);
        buffer.write(reset);
      }

      buffer.writeln();
      currentY++;
    }

    // A. TOPO
    if (hasTop) {
      if (effectiveTitle != null) {
        final tColor = activeStyle.titleColor ?? bColor;

        final titleBlockLen =
            markerLVis + StringUtils.visualLength(effectiveTitle) + markerRVis;
        final widthToFill = resolvedBoxWidth - borderLeftW - borderRightW;
        final availableDash = widthToFill - titleBlockLen;

        int leftDashLen = 0, rightDashLen = 0;

        if (availableDash > 0) {
          leftDashLen = 1;
          if (leftDashLen > availableDash) leftDashLen = availableDash;
          rightDashLen = availableDash - leftDashLen;

          if (_titleAlign == BoxTitleAlign.center) {
            leftDashLen = availableDash ~/ 2;
            rightDashLen = availableDash - leftDashLen;
          } else if (_titleAlign == BoxTitleAlign.right) {
            rightDashLen = 1;
            if (rightDashLen > availableDash) rightDashLen = availableDash;
            leftDashLen = availableDash - rightDashLen;
          }
        }

        final segments = <String>[];
        if (leftDashLen > 0) {
          segments.addAll(bSet.top.repeat(leftDashLen).split(''));
        }
        if (finalMarkerL.isNotEmpty) segments.add(finalMarkerL);
        segments.add('$tColor$effectiveTitle$bColor');
        if (finalMarkerR.isNotEmpty) segments.add(finalMarkerR);
        if (rightDashLen > 0) {
          segments.addAll(bSet.top.repeat(rightDashLen).split(''));
        }

        writeLine(
            left: bSet.topLeft,
            middleContent: segments.join(),
            right: bSet.topRight,
            customSegments: segments,
            drawShadow: false);
      } else {
        final widthToFill = resolvedBoxWidth - borderLeftW - borderRightW;
        writeLine(
            left: bSet.topLeft,
            middleContent: bSet.top * widthToFill,
            right: bSet.topRight,
            drawShadow: false);
      }
    }

    // B. CONTEÚDO
    final padStr = ' ' * _padding;
    final emptyContentLine = ' ' * finalContentWidth;

    for (var i = 0; i < _padding; i++) {
      writeLine(
          left: bSet.left,
          middleContent: padStr + emptyContentLine + padStr,
          right: bSet.right);
    }

    for (final line in lines) {
      final paddedLine = StringUtils.padRight(line, finalContentWidth);
      writeLine(
          left: bSet.left,
          middleContent: padStr + paddedLine + padStr,
          right: bSet.right);
    }

    for (var i = 0; i < _padding; i++) {
      writeLine(
          left: bSet.left,
          middleContent: padStr + emptyContentLine + padStr,
          right: bSet.right);
    }

    // C. FUNDO
    if (hasBottom) {
      final widthToFill = resolvedBoxWidth - borderLeftW - borderRightW;
      writeLine(
          left: bSet.bottomLeft,
          middleContent: bSet.bottom * widthToFill,
          right: bSet.bottomRight);
    }

    // D. SOMBRA INFERIOR
    if (hasShadow) {
      final shadowOffsetX = shadowCharVisLen;
      final boxWidth = resolvedBoxWidth;

      if (activeShadow.char.isNotEmpty && shadowCharVisLen > 0) {
        final int repeats = (boxWidth / shadowCharVisLen).ceil();
        final rawShadow = activeShadow.char * repeats;
        final truncatedShadow = StringUtils.truncate(rawShadow, boxWidth);

        buffer.write(' ' * shadowOffsetX);

        if (activeShadow.isGradient) {
          final gradientChars = ColorUtils.generateGradient(
              activeShadow.gradientStart!,
              activeShadow.gradientEnd!,
              truncatedShadow.length);
          for (int i = 0; i < truncatedShadow.length; i++) {
            if (i < gradientChars.length) buffer.write(gradientChars[i]);
            buffer.write(truncatedShadow[i]);
          }
          buffer.write(reset);
        } else {
          buffer.write('${activeShadow.color}$truncatedShadow$reset');
        }
        buffer.writeln();
      }
    }

    return buffer.toString();
  }

  // ===========================================================================
  // HELPER: SMART WORD WRAP (Quebra de Linha Inteligente)
  // ===========================================================================
  List<String> _smartWrap(String text, int maxWidth) {
    if (text.isEmpty) return [];

    final resultLines = <String>[];

    // 1. Divide por parágrafos explícitos (\n)
    for (var paragraph in text.split('\n')) {
      if (paragraph.isEmpty) {
        resultLines.add('');
        continue;
      }

      // 2. Divide parágrafo em palavras
      final words = paragraph.split(' ');
      String currentLine = '';

      for (var word in words) {
        if (word.isEmpty) continue; // Ignora espaços múltiplos extras

        // 3. Verifica tamanho visual da palavra
        int wordLen = StringUtils.visualLength(word);
        int currentLineLen = StringUtils.visualLength(currentLine);

        // Se a linha está vazia, adiciona a palavra (mesmo que seja maior que maxWidth)
        // Isso evita loop infinito, mas corta a palavra se ela for gigante.
        if (currentLineLen == 0) {
          if (wordLen > maxWidth) {
            // Caso extremo: Palavra sozinha é maior que a caixa. Força quebra.
            // Para simplicidade, adiciona ela e deixa o truncate visual cortar depois
            // ou implementa um chunker aqui. Vamos deixar adicionar para não sumir.
            // O ideal seria splitar a palavra, mas isso é raro em UI de texto.
            resultLines.add(StringUtils.truncate(word, maxWidth));
          } else {
            currentLine = word;
          }
        } else {
          // Tenta adicionar: Linha + Espaço + Palavra
          // Se couber, adiciona. Senão, quebra linha.
          if (currentLineLen + 1 + wordLen <= maxWidth) {
            currentLine += ' $word';
          } else {
            resultLines.add(currentLine);
            currentLine = word;
            // Verifica overflow da nova palavra sozinha na nova linha
            if (StringUtils.visualLength(currentLine) > maxWidth) {
              currentLine = StringUtils.truncate(currentLine, maxWidth);
            }
          }
        }
      }
      if (currentLine.isNotEmpty) {
        resultLines.add(currentLine);
      }
    }

    return resultLines;
  }
}

extension on String {
  String repeat(int times) => this * times;
}
