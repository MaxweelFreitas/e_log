import 'dart:math' as math;

import '../../../base/x_term/x_term_color.dart';
import '../../../base/x_term/x_term_style.dart';
import '../../../core/models/elog_record.dart';
import '../../../core/terminal/terminal_info.dart';
import '../../../core/terminal/terminal_width.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';
import '../../box/style/shadow_style.dart';
import '../config/elog_config.dart';
import '../elog_level.dart';
// Imports de Estilo
import '../style/e_log_presets.dart';
import '../style/e_log_style.dart';

enum ELogLayout { inline, boxed }

/// Define o alinhamento da tag de nível no topo da caixa (ex: [ INFO ]).
enum ELogTagAlign { left, center, right }

class ELogBuilder {
  // Configuração
  ELogLevel _level = ELogLevel.info;
  ELogLayout _layout = ELogLayout.inline;
  ELogStyle _style = ELogPresets.standard;

  final DateTime _time = DateTime.now();

  String _message = '';
  String? _title;
  String? _sourcePath;
  String? _stackTrace;
  String? _linkUrl;
  String? _linkText;

  // Customização da Tag (Título do Nível)
  String? _tagBorderLeft;
  String? _tagBorderRight;
  ELogTagAlign _tagAlign = ELogTagAlign.left;

  // Controle de Largura
  int? _fixedWidth;
  bool _autoWidth = true;

  // ===========================================================================
  // SETTERS (Fluentes)
  // ===========================================================================

  ELogBuilder message(String msg) {
    _message = msg;
    return this;
  }

  ELogBuilder content(dynamic content) {
    _message = content.toString();
    return this;
  }

  ELogBuilder title(String title) {
    _title = title;
    return this;
  }

  ELogBuilder level(ELogLevel level) {
    _level = level;
    return this;
  }

  ELogBuilder layout(ELogLayout layout) {
    _layout = layout;
    return this;
  }

  ELogBuilder style(ELogStyle style) {
    _style = style;
    return this;
  }

  ELogBuilder shadow(ShadowStyle shadow) {
    _style = _style.copyWith(shadow: shadow);
    return this;
  }

  /// Customiza os caracteres que cercam a tag de nível.
  /// Ex: tagStyle(left: '[ ', right: ' ]') resulta em ─[ INFO ]─
  /// Para remover, passe strings vazias: tagStyle(left: '', right: '')
  ELogBuilder tagStyle({String? left, String? right}) {
    if (left != null) _tagBorderLeft = left;
    if (right != null) _tagBorderRight = right;
    return this;
  }

  /// Define o alinhamento da tag de nível (Esquerda, Centro, Direita).
  ELogBuilder tagAlign(ELogTagAlign align) {
    _tagAlign = align;
    return this;
  }

  ELogBuilder source(String path) {
    _sourcePath = path;
    return this;
  }

  ELogBuilder error(dynamic error, [StackTrace? stack]) {
    _level = ELogLevel.error;
    _message = error.toString();
    if (stack != null) _stackTrace = stack.toString();
    return this;
  }

  ELogBuilder link({required String url, String? text}) {
    _linkUrl = url;
    _linkText = text ?? url;
    return this;
  }

  ELogBuilder width(int width) {
    _fixedWidth = width;
    _autoWidth = false;
    return this;
  }

  ELogBuilder autoWidth() {
    _autoWidth = true;
    _fixedWidth = null;
    return this;
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

  String build() {
    return _layout == ELogLayout.inline ? _buildInline() : _buildBoxed();
  }

  void print() {
    final renderedString = build();

    final record = ELogRecord(
      time: _time,
      level: _level,
      message: _message,
      renderedMessage: renderedString,
      title: _title,
      source: _sourcePath,
      error: _level == ELogLevel.error ? _message : null,
      stackTrace: _stackTrace != null
          ? StackTrace.fromString(_stackTrace!)
          : null,
      linkUrl: _linkUrl,
    );

    ELogConfig().output.emit(record);
  }

  // ---------------------------------------------------------------------------
  // RENDERERS
  // ---------------------------------------------------------------------------

  String _buildInline() {
    final timeStr = ELogConfig().format(_time);
    const reset = XTermColor.reset;

    final cTime = _style.timestampColor;
    final cBracket = _style.bracketColor;
    final cMsg = _style.messageColor;
    final cLabel = _style.labelColor ?? _level.color;

    final levelLabel = StringUtils.padRight(_level.label, 5);

    final buffer = StringBuffer();
    buffer.write('$cBracket[$reset$cTime$timeStr$reset$cBracket]$reset ');
    buffer.write('$cBracket[$reset$cLabel$levelLabel$reset$cBracket]$reset ');
    buffer.write('$cMsg $_message$reset');

    if (_linkUrl != null) {
      final clickable = XTermStyle.link(
        url: _linkUrl!,
        linkText: _linkText ?? 'Link',
      );
      buffer.write(' $clickable');
    }
    return buffer.toString();
  }

  String _buildBoxed() {
    final border = _style.border;
    final borderColor =
        _style.borderColor ??
        (_level == ELogLevel.info ? XTermColor.white : _level.color);

    final cTime = _style.timestampColor;
    final cMsg = _style.messageColor;
    const reset = XTermColor.reset;
    final timeFull = ELogConfig().format(_time);

    // --- SETUP SOMBRA ---
    final shadow = _style.shadow;
    final hasShadow = shadow != null;
    final int shadowCharWidth = hasShadow
        ? StringUtils.visualLength(shadow.char)
        : 0;
    final shadowRightStr = hasShadow
        ? '${shadow.color}${shadow.char}$reset'
        : '';

    String lineEnd() => '$shadowRightStr\n';

    // 1. Coleta Campos
    final Map<String, String> fields = {};
    String clean(String s) => s.replaceAll('\t', '    ');

    if (_title != null) fields['Title'] = clean(_title!);
    fields['Log Time'] = clean(timeFull);
    if (_sourcePath != null) fields['Source path'] = clean(_sourcePath!);
    fields['Message'] = clean(_message);
    if (_linkUrl != null) {
      fields['Link'] = clean(_linkText ?? _linkUrl!);
    }
    if (_stackTrace != null) fields['StackTrace'] = clean(_stackTrace!);

    // 2. Calcula Largura Ideal
    int maxContentWidth = 60;
    for (final entry in fields.entries) {
      final labelLen = entry.key.length + 2;
      final valLines = entry.value.split('\n');
      int maxValLen = 0;
      for (final line in valLines) {
        maxValLen = math.max(maxValLen, StringUtils.visualLength(line));
      }
      final totalLen = labelLen + maxValLen;
      if (totalLen > maxContentWidth) maxContentWidth = totalLen;
    }
    int idealTotalWidth = maxContentWidth + 4;

    // 3. Resolve Largura Final
    final int termWidth = TerminalInfo.width ?? 100;
    final int maxAllowedBoxWidth = termWidth - shadowCharWidth;

    int? resolvedMaxWidth;
    if (!_autoWidth && _fixedWidth == null) {
      resolvedMaxWidth = idealTotalWidth;
    }

    int targetUserWidth = idealTotalWidth;
    if (_fixedWidth != null) {
      targetUserWidth = _fixedWidth!;
    }

    final int finalBoxWidth = TerminalWidthResolver.resolve(
      userWidth: _fixedWidth != null ? targetUserWidth : null,
      contentWidth: idealTotalWidth,
      minWidth: 40,
      maxWidth: math.min(resolvedMaxWidth ?? 9999, maxAllowedBoxWidth),
    );

    final innerWidth = finalBoxWidth - 2;

    // =========================================================================
    // RENDERIZAÇÃO
    // =========================================================================
    final buffer = StringBuffer();

    void drawSeparator() {
      buffer.write(borderColor);
      buffer.write(border.midLeft);
      buffer.write('╶' * innerWidth);
      buffer.write(border.midRight);
      buffer.write('$reset${lineEnd()}');
    }

    void drawLine(String label, String value, {bool isLink = false}) {
      final prefix = '$label: ';
      final int visualPrefixLen = StringUtils.visualLength(prefix);
      final int availableTextSpace = innerWidth - 1 - visualPrefixLen - 1;
      final int safeWrapWidth = math.max(1, availableTextSpace);

      final wrappedLines = StringUtils.wrap(value, width: safeWrapWidth);

      for (var i = 0; i < wrappedLines.length; i++) {
        buffer.write('$borderColor${border.left}$reset ');

        if (i == 0) {
          buffer.write('${XTermStyle.bold}$prefix$reset');
        } else {
          buffer.write(' ' * visualPrefixLen);
        }

        String textLine = wrappedLines[i];
        if (isLink && _linkUrl != null) {
          textLine = XTermStyle.link(url: _linkUrl!, linkText: textLine);
        } else if (label == 'Message') {
          textLine = '$cMsg$textLine$reset';
        } else if (label == 'Log Time') {
          textLine = '$cTime$textLine$reset';
        }

        buffer.write(textLine);

        final int visualTextLine = StringUtils.visualLength(wrappedLines[i]);
        final int occupied = 1 + visualPrefixLen + visualTextLine;
        final int remaining = innerWidth - occupied;
        final int safePadding = math.max(0, remaining);

        buffer.write(' ' * safePadding);
        buffer.write('$borderColor${border.right}$reset${lineEnd()}');
      }
    }

    // --- A. TOPO (Tag / Label) ---
    final cHeader = _style.labelColor ?? _level.color;
    final titleStr = ' ${_level.icon} ${_level.label} ';
    final titleVisLen = StringUtils.visualLength(titleStr);

    // Resolve os conectores (Overrides ou Padrão do BorderSet)
    final String leftConn = _tagBorderLeft ?? border.titleLeft;
    final String rightConn = _tagBorderRight ?? border.titleRight;

    final int leftConnLen = StringUtils.visualLength(leftConn);
    final int rightConnLen = StringUtils.visualLength(rightConn);
    const int cornersLen = 2; // topLeft + topRight (assumindo 1 char cada)

    // Espaço disponível para traços (dashes)
    final int availableForDashes = math.max(
      0,
      finalBoxWidth - titleVisLen - leftConnLen - rightConnLen - cornersLen,
    );

    int leftDash = 0;
    int rightDash = 0;

    // Cálculo dos traços baseado no alinhamento
    switch (_tagAlign) {
      case ELogTagAlign.left:
        leftDash = 1; // Pelo menos 1 traço à esquerda para estética
        rightDash = availableForDashes - leftDash;
        break;
      case ELogTagAlign.center:
        leftDash = availableForDashes ~/ 2;
        rightDash = availableForDashes - leftDash;
        break;
      case ELogTagAlign.right:
        rightDash = 1; // Pelo menos 1 traço à direita
        leftDash = availableForDashes - rightDash;
        break;
    }

    // Garante não negativo
    if (rightDash < 0) rightDash = 0;
    if (leftDash < 0) leftDash = 0;

    buffer.write('$borderColor${border.topLeft}');
    buffer.write(border.top * leftDash);

    // Conector Esquerdo + Texto + Conector Direito
    buffer.write(leftConn);
    buffer.write('$reset$cHeader$titleStr$reset$borderColor');
    buffer.write(rightConn);

    buffer.write(border.top * rightDash);
    buffer.write(
      '${border.topRight}$reset\n',
    ); // \n direto (sem sombra na linha 1)

    // --- B. CAMPOS ---
    if (_title != null) {
      drawLine('Title', _title!);
      drawSeparator();
    }
    drawLine('Log Time', timeFull);
    drawSeparator();
    if (_sourcePath != null) {
      drawLine('Source path', _sourcePath!);
      drawSeparator();
    }
    drawLine('Message', _message);

    if (_linkUrl != null) {
      drawSeparator();
      drawLine('Link', _linkText ?? _linkUrl!, isLink: true);
    }

    if (_stackTrace != null) {
      drawSeparator();
      final lines = _stackTrace!.split('\n');
      final stackDisplay = lines.length > 20
          ? '${lines.take(20).join('\n')}\n... (+${lines.length - 20} more lines)'
          : _stackTrace!;
      drawLine('StackTrace', stackDisplay);
    }

    // --- C. BASE ---
    buffer.write('$borderColor${border.bottomLeft}');
    buffer.write(border.bottom * innerWidth);
    buffer.write('${border.bottomRight}$reset');

    buffer.write(lineEnd());

    // --- D. SOMBRA INFERIOR ---
    if (hasShadow) {
      buffer.write(' ' * shadowCharWidth);

      final pattern = shadow.char;
      final int repeats = (finalBoxWidth / pattern.length).ceil();
      String rawShadow = pattern * repeats;

      if (rawShadow.length > finalBoxWidth) {
        rawShadow = rawShadow.substring(0, finalBoxWidth);
      }

      if (shadow.isGradient) {
        final gradientChars = ColorUtils.generateGradient(
          shadow.gradientStart!,
          shadow.gradientEnd!,
          rawShadow.length,
        );
        for (int i = 0; i < rawShadow.length; i++) {
          if (i < gradientChars.length) buffer.write(gradientChars[i]);
          buffer.write(rawShadow[i]);
        }
        buffer.write(reset);
      } else {
        buffer.write('${shadow.color}$rawShadow$reset');
      }
    }

    return buffer.toString();
  }
}
