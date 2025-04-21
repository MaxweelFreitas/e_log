class BoxStyle {
  // Estilos básicos
  final String topLeft;
  final String topRight;
  final String bottomLeft;
  final String bottomRight;
  final String vertical;
  final String horizontal;
  final String middleLeft;
  final String middleRight;
  final String middleTop;
  final String middleBottom;
  final String cross;

  const BoxStyle({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.vertical,
    required this.horizontal,
    required this.middleLeft,
    required this.middleRight,
    required this.middleTop,
    required this.middleBottom,
    required this.cross,
  });

  // Estilos predefinidos
  static const BoxStyle single = BoxStyle(
    topLeft: '┌',
    topRight: '┐',
    bottomLeft: '└',
    bottomRight: '┘',
    vertical: '│',
    horizontal: '─',
    middleLeft: '├',
    middleRight: '┤',
    middleTop: '┬',
    middleBottom: '┴',
    cross: '┼',
  );

  static const BoxStyle double = BoxStyle(
    topLeft: '╔',
    topRight: '╗',
    bottomLeft: '╚',
    bottomRight: '╝',
    vertical: '║',
    horizontal: '═',
    middleLeft: '╠',
    middleRight: '╣',
    middleTop: '╦',
    middleBottom: '╩',
    cross: '╬',
  );

  static const BoxStyle rounded = BoxStyle(
    topLeft: '╭',
    topRight: '╮',
    bottomLeft: '╰',
    bottomRight: '╯',
    vertical: '│',
    horizontal: '─',
    middleLeft: '├',
    middleRight: '┤',
    middleTop: '┬',
    middleBottom: '┴',
    cross: '┼',
  );

  static const BoxStyle mixed = BoxStyle(
    topLeft: '╒',
    topRight: '╕',
    bottomLeft: '╘',
    bottomRight: '╛',
    vertical: '│',
    horizontal: '═',
    middleLeft: '╞',
    middleRight: '╡',
    middleTop: '╤',
    middleBottom: '╧',
    cross: '╪',
  );
}

class BoxBuilder {
  final BoxStyle style;
  final String title;
  final List<String> content;

  BoxBuilder({
    required this.style,
    required this.title,
    required this.content,
  });

  /// Constrói a caixa formatada
  String build() {
    int maxWidth = content.fold(
        title.length, (prev, line) => prev > line.length ? prev : line.length);
    maxWidth += 4; // Margem extra

    final buffer = StringBuffer();

    // Linha superior com título
    buffer.writeln(
      '${style.topLeft}${style.horizontal}${style.middleRight} $title ${style.middleLeft}${style.horizontal * (maxWidth - title.length - 5)}${style.topRight}',
    );

    // Adiciona o conteúdo
    for (var line in content) {
      buffer.writeln(
        '${style.vertical} ${line.padRight(maxWidth - 2)} ${style.vertical}',
      );
    }

    // Linha inferior
    buffer.writeln(
      '${style.bottomLeft}${style.horizontal * maxWidth}${style.bottomRight}',
    );

    return buffer.toString();
  }
}

void main() {
  var logSingle = BoxBuilder(
    style: BoxStyle.single,
    title: 'Single Box',
    content: [
      'This is a single-lined box.',
      'It supports multiline content.',
      'Borders adjust dynamically.',
    ],
  ).build();

  var logDouble = BoxBuilder(
    style: BoxStyle.double,
    title: 'Double Box',
    content: [
      'This is a double-lined box.',
      'More elegant and professional.',
    ],
  ).build();

  var logRounded = BoxBuilder(
    style: BoxStyle.rounded,
    title: 'Rounded Box',
    content: [
      'This is a rounded-edge box.',
      'Good for smooth UI elements.',
    ],
  ).build();

  var logMixed = BoxBuilder(
    style: BoxStyle.mixed,
    title: 'Mixed Box',
    content: [
      'This is a mixed-style box.',
      'Combines double and single lines.',
    ],
  ).build();

  print(logSingle);
  print(logDouble);
  print(logRounded);
  print(logMixed);
}
