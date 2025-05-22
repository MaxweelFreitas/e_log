import 'e_log_box.dart';
import 'x_term/x_term_color.dart';

enum EBoxShadow {
  none,
  light,
  medium,
  heavy,
}

class EApiBuilder {
  final EBoxStyle style;
  final int boxWidth;
  final Map<String, dynamic> data;
  final List<String>? headers;
  final EBoxShadow shadowLevel;

  EApiBuilder({
    required this.style,
    this.boxWidth = 80,
    required this.data,
    this.headers,
    this.shadowLevel = EBoxShadow.none,
  });

  String get _shadowChar => switch (shadowLevel) {
        EBoxShadow.none => ' ',
        EBoxShadow.light => '▒',
        EBoxShadow.medium => '▓',
        EBoxShadow.heavy => '█',
      };

  String build() {
    final buffer = StringBuffer();

    // Top border
    buffer
        .writeln(style.topLeft + style.horizontal * boxWidth + style.topRight);

    // Headers (if any)
    if (headers?.isNotEmpty == true) {
      _writeHeaders(buffer, headers!);
    }

    // Data Sections
    for (final entry in data.entries) {
      _writeSection(buffer, entry.key, () {
        if (entry.value is Map<String, dynamic>) {
          buffer.write(_renderMap(entry.value, hasMoreSiblings: []));
        } else {
          _writeField(buffer, '', entry.value.toString());
        }
      });
    }

    // Bottom border
    final bottom =
        style.bottomLeft + (style.horizontal * boxWidth) + style.bottomRight;
    buffer.writeln(
        shadowLevel != EBoxShadow.none ? '$bottom$_shadowChar' : bottom);

    // Bottom shadow
    if (shadowLevel != EBoxShadow.none) {
      buffer.writeln('  ${_shadowChar * (boxWidth + 1)}');
    }

    return buffer.toString();
  }

  void _writeHeaders(StringBuffer buffer, List<String> items) {
    const space = ' ';
    final prefix = '${style.vertical} ';
    final suffix = style.vertical;
    final maxWidth = boxWidth - 1;

    var line = StringBuffer();
    var length = 0;

    for (final item in items) {
      final itemLen = item.length + (line.isEmpty ? 0 : 1);
      if (length + itemLen > maxWidth) {
        _writeShadowLine(
            buffer, '$prefix${line.toString().padRight(maxWidth)}$suffix');
        line = StringBuffer(item);
        length = item.length;
      } else {
        if (line.isNotEmpty) {
          line.write(space);
          length++;
        }
        line.write(item);
        length += item.length;
      }
    }

    if (line.isNotEmpty) {
      _writeShadowLine(
          buffer, '$prefix${line.toString().padRight(maxWidth)}$suffix');
    }
  }

  void _writeSection(
      StringBuffer buffer, String title, void Function() content) {
    final line = '├${'─' * boxWidth}┤';
    _writeShadowLine(buffer, line);
    _writeShadowLine(buffer, '│ ${title.padRight(boxWidth - 1)}│');
    _writeShadowLine(buffer, line);
    content();
  }

  void _writeField(StringBuffer buffer, String label, String value,
      {bool isLast = false}) {
    final prefix = isLast ? '└─' : '├─';
    final text = '$prefix ${label.padRight(14)}$value';
    _writeLine(buffer, text);
  }

  void _writeLine(StringBuffer buffer, String content) {
    final text =
        content.length > boxWidth ? content.substring(0, boxWidth) : content;
    final line =
        '${style.vertical} ${text.padRight(boxWidth - 1)}${style.vertical}';
    _writeShadowLine(buffer, line);
  }

  String _renderMap(Map map,
      {int indent = 0, List<bool> hasMoreSiblings = const []}) {
    final buffer = StringBuffer();
    final keys = map.keys.toList();

    for (int i = 0; i < keys.length; i++) {
      final key = keys[i];
      final value = map[key];
      final isLast = i == keys.length - 1;

      final prefix = StringBuffer();
      for (int level = 0; level < indent; level++) {
        prefix.write((level < hasMoreSiblings.length && hasMoreSiblings[level])
            ? '│  '
            : '   ');
      }
      prefix.write(isLast ? '└─ ' : '├─ ');

      if (value is Map) {
        buffer.writeln(_mapLine('$prefix$key:'));
        final siblings = [...hasMoreSiblings];
        if (siblings.length > indent) {
          siblings[indent] = !isLast;
        } else {
          siblings.add(!isLast);
        }
        buffer.write(
            _renderMap(value, indent: indent + 1, hasMoreSiblings: siblings));
      } else {
        buffer.writeln(_mapLine('$prefix$key: ${value.toString()}'));
      }
    }

    return buffer.toString();
  }

  String _mapLine(String content) {
    final trimmed =
        content.length > boxWidth ? content.substring(0, boxWidth) : content;
    final line =
        '${style.vertical} ${trimmed.padRight(boxWidth - 1)}${style.vertical}';
    return shadowLevel != EBoxShadow.none ? '$line$_shadowChar' : line;
  }

  void _writeShadowLine(StringBuffer buffer, String line) {
    buffer.writeln(shadowLevel != EBoxShadow.none ? '$line$_shadowChar' : line);
  }
}

void main() {
  final box = EApiBuilder(
    style: EBoxStyle.rounded,
    shadowLevel: EBoxShadow.light,
    headers: [
      '[2025-05-21 12:00:00]',
      '[INFO]',
      '[Cadastro de Usuário]',
    ],
    data: {
      'Request': {
        'Method': 'POST',
        'URL': 'https://api.example.com/data',
        'IP': '192.168.1.1',
        'User-Agent': 'Dart/2.19',
        'Auth User ID': 'user123',
        'Headers': {
          'Accept': 'application/json',
          'Authorization': 'Bearer abc123',
        },
        'Parameters': {
          'q': 'search',
          'page': 1,
        },
      },
      'Response': {
        'Status Code': 200,
        'Time Taken': '150ms',
        'Headers': {
          'Content-Type': 'application/json',
        },
        'Response Body': {
          'result': 'success',
          'count': 10,
          'details': {
            'items': 3,
            'list': {
              'a': 1,
              'b': 2,
            },
          },
        },
      },
      'Performance': {
        'Memory Used': '120MB',
        'CPU Usage': '15%',
      },
    },
  );

  for (final line in box.build().split('\n')) {
    print('${XTermColor.main} $line');
  }
}
