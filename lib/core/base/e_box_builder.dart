import 'e_log_box.dart';

enum EBoxShadow {
  none,
  light,
  medium,
  heavy,
}

class EBoxBuilder {
  final EBoxStyle style;
  final String title;
  final List<String> content;
  final int? width;
  final bool shadow;
  final EBoxShadow shadowLevel;

  EBoxBuilder({
    required this.style,
    required this.title,
    required this.content,
    this.width,
    this.shadow = false,
    this.shadowLevel = EBoxShadow.light,
  });

  String get _shadowChar => switch (shadowLevel) {
        EBoxShadow.none => ' ',
        EBoxShadow.light => '▒',
        EBoxShadow.medium => '▓',
        EBoxShadow.heavy => '█',
      };

  String build() {
    int contentMax = content.fold(
      title.length,
      (max, line) => line.length > max ? line.length : max,
    );

    int maxWidth = width != null
        ? (width! < title.length + 4 ? title.length + 4 : width!)
        : contentMax + 4;

    final buffer = StringBuffer();

    // Top line
    final rightPadding = maxWidth - title.length - 5;
    buffer.writeln(
      '${style.topLeft}${style.horizontal}${style.middleRight} $title ${style.middleLeft}${style.horizontal * rightPadding}${style.topRight}',
    );

    // Content lines
    for (final line in content) {
      final lineContent =
          '${style.vertical} ${line.padRight(maxWidth - 2)} ${style.vertical}';
      buffer.writeln(shadow ? '$lineContent$_shadowChar' : lineContent);
    }

    // Bottom line
    final bottomLine =
        '${style.bottomLeft}${style.horizontal * maxWidth}${style.bottomRight}';
    buffer.writeln(shadow ? '$bottomLine$_shadowChar' : bottomLine);

    // Sombra inferior
    if (shadow) {
      final shadowLine = '  ${_shadowChar * (maxWidth + 1)}';
      buffer.writeln(shadowLine);
    }

    return buffer.toString();
  }
}

void main() {
  final logs = [
    EBoxBuilder(
      width: 40,
      style: EBoxStyle.single,
      title: 'Single Box',
      content: [
        'This is a single-lined box.',
        'It supports multiline content.',
        'Borders adjust dynamically.',
      ],
    ),
    EBoxBuilder(
      width: 60,
      style: EBoxStyle.double,
      title: 'Double Box',
      content: [
        'This is a double-lined box.',
        'More elegant and professional.',
      ],
    ),
    EBoxBuilder(
      width: 80,
      style: EBoxStyle.rounded,
      title: 'Rounded Box',
      content: [
        'This is a rounded-edge box.',
        'Good for smooth UI elements.',
      ],
    ),
    EBoxBuilder(
      width: 100,
      style: EBoxStyle.mixed,
      title: 'Mixed Box',
      content: [
        'This is a mixed-style box.',
        'Combines double and single lines.',
      ],
    ),
    EBoxBuilder(
      width: 50,
      style: EBoxStyle.lightDouble,
      title: 'Light Double Box',
      content: [
        'Uses light double-line corners.',
        'Feels airy and elegant.',
      ],
    ),
    EBoxBuilder(
      width: 50,
      style: EBoxStyle.heavy,
      title: 'Heavy Box',
      content: [
        'Strong, bold, heavy borders.',
        'Stands out in terminal UIs.',
      ],
    ),
    EBoxBuilder(
      width: 45,
      style: EBoxStyle.ascii,
      title: 'ASCII Box',
      content: [
        'Plain ASCII style.',
        'Simple and universal.',
      ],
    ),
    EBoxBuilder(
      width: 40,
      style: EBoxStyle.single,
      title: 'Box with Shadow',
      content: [
        'This box has a drop shadow!',
        'Looks more 3D, doesn\'t it?',
      ],
      shadow: true,
    ),
  ];

  for (var box in logs) {
    print(box.build());
  }
}
