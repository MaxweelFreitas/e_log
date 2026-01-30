import 'dart:math';

// --- Imports Base ---
import '../../base/x_term/x_term_style.dart';

// --- Imports Compartilhados (Style/Utils) ---
import '../../shared/border_set.dart';
import '../box/style/shadow_style.dart';
import '../../utils/string_utils.dart';
import '../../core/terminal/terminal_info.dart';

// --- Imports de Outros Módulos (Tree) ---
import '../tree/e_tree_builder.dart';
import '../tree/style/tree_style.dart';

// --- Imports Locais ---
import 'style/e_api_style.dart';

enum ApiStyle { boxed, simple, filled }

class EApiBuilder {
  String _timestamp = DateTime.now().toString().split('.')[0];
  String _level = 'INFO';
  String _tag = 'API';

  String _method = 'GET';
  String _url = '';
  String? _ip;
  String? _userAgent;
  Map<String, dynamic>? _headers;
  Map<String, dynamic>? _params;

  int _statusCode = 200;
  String _timeTaken = '0ms';
  Map<String, dynamic>? _resHeaders;
  dynamic _resBody;

  ApiStyle _style = ApiStyle.boxed;
  ShadowStyle? _shadow;
  EApiStyle? _customTheme;

  int? _fixedWidth;
  bool _autoWidth = true;
  int? _paddingOverride;

  bool _isTitleCompact = false;

  // ===========================================================================
  // SETTERS (Builder Pattern)
  // ===========================================================================

  EApiBuilder timestamp(DateTime dt) {
    _timestamp = dt.toString().split('.')[0];
    return this;
  }

  EApiBuilder info(String tag) {
    _level = 'INFO';
    _tag = tag;
    return this;
  }

  EApiBuilder warning(String tag) {
    _level = 'WARN';
    _tag = tag;
    return this;
  }

  EApiBuilder error(String tag) {
    _level = 'ERROR';
    _tag = tag;
    return this;
  }

  EApiBuilder request({
    required String method,
    required String url,
    String? ip,
    String? userAgent,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? bodyOrParams,
  }) {
    _method = method;
    _url = url;
    _ip = ip;
    _userAgent = userAgent;
    _headers = headers;
    _params = bodyOrParams;
    return this;
  }

  EApiBuilder response({
    required int status,
    String time = '0ms',
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    _statusCode = status;
    _timeTaken = time;
    _resHeaders = headers;
    _resBody = body;
    return this;
  }

  EApiBuilder style(ApiStyle style) {
    _style = style;
    return this;
  }

  EApiBuilder shadow(ShadowStyle shadow) {
    _shadow = shadow;
    return this;
  }

  EApiBuilder withShadow() {
    _shadow = ShadowStyle.light;
    return this;
  }

  EApiBuilder width(int width) {
    _fixedWidth = width;
    _autoWidth = false;
    return this;
  }

  EApiBuilder autoWidth() {
    _autoWidth = true;
    _fixedWidth = null;
    return this;
  }

  EApiBuilder setTheme(EApiStyle theme) {
    _customTheme = theme;
    return this;
  }

  EApiBuilder compact() {
    _autoWidth = false;
    _fixedWidth = null;
    _paddingOverride = 0;
    return this;
  }

  EApiBuilder compactTitle() {
    _isTitleCompact = true;
    return this;
  }

  // ===========================================================================
  // HELPER METHODS (Simplificados usando StringUtils)
  // ===========================================================================

  static const String _ansiClean = '\x1B[0m\x1B[39m';

  // Usando StringUtils em vez de reimplementar
  int _visualLen(String text) => StringUtils.visualLength(text);

  // ===========================================================================
  // BUILDERS
  // ===========================================================================

  String build() {
    switch (_style) {
      case ApiStyle.simple:
        return _buildSimple();
      case ApiStyle.filled:
        return _buildFilled();
      case ApiStyle.boxed:
        return _buildBoxed();
    }
  }

  // --- FILLED STYLE ---
  String _buildFilled() {
    final isError = _statusCode >= 400 || _level == 'ERROR';
    final int padding = _paddingOverride ?? 1;
    final EApiStyle activeTheme =
        _customTheme ?? (isError ? EApiStyle.error() : EApiStyle.standard());

    final titleBlockBg = activeTheme.titleBackgroundColor.isNotEmpty
        ? activeTheme.titleBackgroundColor
        : activeTheme.backgroundColor;
    final contentBlockBg = activeTheme.contentBackgroundColor.isNotEmpty
        ? activeTheme.contentBackgroundColor
        : activeTheme.backgroundColor;

    final hasShadow = _shadow != null;
    final int shadowCharWidth = hasShadow ? _visualLen(_shadow!.char) : 0;
    final shadowStr =
        hasShadow ? '${_shadow!.color}${_shadow!.char}$_ansiClean' : '';
    final emptyShadowStr = hasShadow ? ' ' * shadowCharWidth : '';

    final headerStr = '[$_timestamp] [$_level] [$_tag]';

    final treeStyle = _mapApiStyleToTreeStyle(activeTheme);
    final reqTree = ETreeBuilder(_buildReqMap(), style: treeStyle).build();
    final resTree = ETreeBuilder(_buildResMap(), style: treeStyle).build();

    int measureBlock(String block) =>
        block.split('\n').fold(0, (maxW, line) => max(maxW, _visualLen(line)));

    int contentMaxWidth = max(_visualLen(headerStr),
        max(measureBlock(reqTree), measureBlock(resTree)));

    int idealWidth = contentMaxWidth + (padding * 2) + shadowCharWidth;
    int terminalWidth = TerminalInfo.width ?? 100;
    int finalWidth = _fixedWidth ??
        (_autoWidth ? min(idealWidth, terminalWidth) : idealWidth);

    final boxWidth = finalWidth - shadowCharWidth;
    final drawContentWidth = boxWidth - (padding * 2);
    final buffer = StringBuffer();

    String patchContentBg(String content, String bg) {
      return content.replaceAll('\x1B[0m', '\x1B[0m$bg');
    }

    void drawFilledLine(String content, String currentBlockBg) {
      // 1. Wrap do conteúdo para caber na largura disponível
      final wrappedLines = StringUtils.wrap(content, width: drawContentWidth);

      for (var line in wrappedLines) {
        // Aplica o fundo ao conteúdo já com cores
        final patchedSafe = patchContentBg(line, currentBlockBg);

        // Calcula espaço restante para preencher com cor de fundo
        final int contentLen = _visualLen(line);
        final int rightSpace = max(0, drawContentWidth - contentLen);
        final pad = ' ' * padding;

        buffer.write(
            '$currentBlockBg$pad$patchedSafe$currentBlockBg${' ' * rightSpace}$pad$_ansiClean$shadowStr\n');
      }
    }

    final bool hasTopPadding = padding > 0 && !_isTitleCompact;

    // Header Background Block
    if (hasTopPadding) {
      buffer
          .write('$titleBlockBg${' ' * boxWidth}$_ansiClean$emptyShadowStr\n');
    }

    final hPadded = StringUtils.padRight(headerStr, drawContentWidth);
    final headerShadow = hasTopPadding ? shadowStr : emptyShadowStr;
    final patchedHeader = patchContentBg(hPadded, titleBlockBg);

    buffer.write(
        '$titleBlockBg${' ' * padding}${activeTheme.headerColor}$patchedHeader$_ansiClean$titleBlockBg${' ' * padding}$_ansiClean$headerShadow\n');

    if (padding > 0 && !_isTitleCompact) {
      buffer.write('$titleBlockBg${' ' * boxWidth}$_ansiClean$shadowStr\n');
    }

    // Body
    if (!_isTitleCompact) {
      buffer.write('$contentBlockBg${' ' * boxWidth}$_ansiClean$shadowStr\n');
    }

    // Title Request
    drawFilledLine('${XTermStyle.bold}Request:', contentBlockBg);
    // Body Request
    for (var line in reqTree.split('\n')) {
      drawFilledLine(line, contentBlockBg);
    }

    buffer.write('$contentBlockBg${' ' * boxWidth}$_ansiClean$shadowStr\n');

    // Title Response
    drawFilledLine('${XTermStyle.bold}Response:', contentBlockBg);
    // Body Response
    for (var line in resTree.split('\n')) {
      drawFilledLine(line, contentBlockBg);
    }

    if (padding > 0) {
      buffer.write('$contentBlockBg${' ' * boxWidth}$_ansiClean');
    }

    if (hasShadow) {
      buffer.write('$shadowStr\n');
      buffer.write(' ' * shadowCharWidth);
      final pattern = _shadow!.char;
      if (pattern.isNotEmpty) {
        final int repeats = (boxWidth / pattern.length).ceil();
        String rawShadow = pattern * repeats;
        if (rawShadow.length > boxWidth) {
          rawShadow = rawShadow.substring(0, boxWidth);
        }
        buffer.write('${_shadow!.color}$rawShadow$_ansiClean');
      }
    }

    return buffer.toString();
  }

  // --- BOXED STYLE ---
  String _buildBoxed() {
    final isError = _statusCode >= 400 || _level == 'ERROR';
    final BorderSet border = isError ? BorderSet.heavy : BorderSet.rounded;
    final int padding = _paddingOverride ?? 1;
    final EApiStyle activeTheme =
        _customTheme ?? (isError ? EApiStyle.error() : EApiStyle.standard());
    final borderColor = activeTheme.borderColor;
    final headerColor = activeTheme.headerColor;

    final hasShadow = _shadow != null;
    final int shadowCharWidth = hasShadow ? _visualLen(_shadow!.char) : 0;
    final shadowStr =
        hasShadow ? '${_shadow!.color}${_shadow!.char}$_ansiClean' : '';
    String lineEnd() => hasShadow ? '$shadowStr\n' : '\n';

    final headerStr = '[$_timestamp] [$_level] [$_tag]';
    final treeStyle = _mapApiStyleToTreeStyle(activeTheme);
    final reqTree = ETreeBuilder(_buildReqMap(), style: treeStyle).build();
    final resTree = ETreeBuilder(_buildResMap(), style: treeStyle).build();

    int measureBlock(String block) =>
        block.split('\n').fold(0, (maxW, line) => max(maxW, _visualLen(line)));

    int contentMaxWidth = max(_visualLen(headerStr),
        max(measureBlock(reqTree), measureBlock(resTree)));

    int idealWidth = contentMaxWidth + (padding * 2) + 2 + shadowCharWidth;
    int terminalWidth = TerminalInfo.width ?? 100;
    int finalWidth = _fixedWidth ??
        (_autoWidth ? min(idealWidth, terminalWidth) : idealWidth);

    final boxWidth = finalWidth - shadowCharWidth;
    final drawContentWidth = boxWidth - 2 - (padding * 2);
    final buffer = StringBuffer();

    void drawLine(String content) {
      // Usa StringUtils.wrap para quebrar linhas longas corretamente
      final wrappedLines = StringUtils.wrap(content, width: drawContentWidth);

      for (var line in wrappedLines) {
        final spacesNeeded = drawContentWidth - _visualLen(line);
        final padSize = max(0, spacesNeeded);
        final pad = ' ' * padding;
        buffer.write(
            '$borderColor${border.left}$_ansiClean$pad$line${' ' * padSize}$pad$borderColor${border.right}$_ansiClean${lineEnd()}');
      }
    }

    // Topo
    buffer.write(
        '$borderColor${border.topLeft}${border.top * (boxWidth - 2)}${border.topRight}$_ansiClean\n');

    // Header
    final hPadded = StringUtils.padRight(headerStr, drawContentWidth);
    final pad = ' ' * padding;
    buffer.write(
        '$borderColor${border.left}$_ansiClean$pad$headerColor$hPadded$_ansiClean$pad$borderColor${border.right}$_ansiClean${lineEnd()}');

    // Conector do meio
    buffer.write(
        '$borderColor${border.midLeft}${border.middle * (boxWidth - 2)}${border.midRight}$_ansiClean${lineEnd()}');

    // Request
    drawLine('${XTermStyle.bold}Request:$_ansiClean');
    for (var line in reqTree.split('\n')) {
      drawLine(line);
    }

    // Conector do meio
    buffer.write(
        '$borderColor${border.midLeft}${border.middle * (boxWidth - 2)}${border.midRight}$_ansiClean${lineEnd()}');

    // Response
    drawLine('${XTermStyle.bold}Response:$_ansiClean');
    for (var line in resTree.split('\n')) {
      drawLine(line);
    }

    // Base
    buffer.write(
        '$borderColor${border.bottomLeft}${border.bottom * (boxWidth - 2)}${border.bottomRight}$_ansiClean');

    // Sombra Base
    if (hasShadow) {
      buffer.write('$shadowStr\n');
      buffer.write(' ' * shadowCharWidth);
      final pattern = _shadow!.char;
      if (pattern.isNotEmpty) {
        final int repeats = (boxWidth / pattern.length).ceil();
        String rawShadow = pattern * repeats;
        if (rawShadow.length > boxWidth) {
          rawShadow = rawShadow.substring(0, boxWidth);
        }
        buffer.write('${_shadow!.color}$rawShadow$_ansiClean');
      }
    }
    return buffer.toString();
  }

  // --- SIMPLE STYLE ---
  String _buildSimple() {
    final isError = _statusCode >= 400 || _level == 'ERROR';
    final EApiStyle activeTheme =
        _customTheme ?? (isError ? EApiStyle.error() : EApiStyle.standard());
    final headerStr = '[$_timestamp] [$_level] [$_tag]';

    final treeStyle = _mapApiStyleToTreeStyle(activeTheme);
    final reqTree = ETreeBuilder(_buildReqMap(), style: treeStyle).build();
    final resTree = ETreeBuilder(_buildResMap(), style: treeStyle).build();

    int measureBlock(String block) =>
        block.split('\n').fold(0, (maxW, line) => max(maxW, _visualLen(line)));

    int contentMaxWidth = max(_visualLen(headerStr),
        max(measureBlock(reqTree), measureBlock(resTree)));

    int terminalWidth = TerminalInfo.width ?? 100;
    int idealWidth = contentMaxWidth;
    int finalWidth = _fixedWidth ??
        (_autoWidth ? min(idealWidth, terminalWidth) : idealWidth);

    final divider =
        '${activeTheme.treeStructureColor}${'-' * finalWidth}$_ansiClean';
    final buffer = StringBuffer();

    buffer.writeln(divider);
    buffer.writeln('${activeTheme.headerColor}$headerStr$_ansiClean');
    buffer.writeln(divider);

    buffer.writeln('${XTermStyle.bold}Request:$_ansiClean');
    for (var line in reqTree.split('\n')) {
      // Wrap simples para evitar overflow
      for (var l in StringUtils.wrap(line, width: finalWidth)) {
        buffer.writeln(l);
      }
    }

    buffer.writeln(divider);

    buffer.writeln('${XTermStyle.bold}Response:$_ansiClean');
    for (var line in resTree.split('\n')) {
      for (var l in StringUtils.wrap(line, width: finalWidth)) {
        buffer.writeln(l);
      }
    }

    buffer.writeln(divider);
    return buffer.toString();
  }

  // ===========================================================================
  // DATA HELPERS
  // ===========================================================================

  TreeStyle _mapApiStyleToTreeStyle(EApiStyle apiStyle) {
    return TreeStyle(
      border: BorderSet.single,
      structureColor: apiStyle.treeStructureColor,
      keyColor: apiStyle.keyColor,
      valueColor: apiStyle.valueColor,
      separatorColor: apiStyle.separatorColor,
    );
  }

  Map<String, dynamic> _buildReqMap() => {
        'Method': _method,
        'URL': _url,
        if (_ip != null) 'IP': _ip,
        if (_userAgent != null) 'User-Agent': _userAgent,
        if (_headers != null && _headers!.isNotEmpty) 'Headers': _headers,
        if (_params != null && _params!.isNotEmpty) 'Parameters': _params
      };

  Map<String, dynamic> _buildResMap() => {
        'Status Code': _statusCode,
        'Time Taken': _timeTaken,
        if (_resHeaders != null && _resHeaders!.isNotEmpty)
          'Headers': _resHeaders,
        if (_resBody != null) 'Response Body': _resBody
      };
}
