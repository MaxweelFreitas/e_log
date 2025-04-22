//Models
// ┌─┬─┐    ╔═╦═╗    ╓─╥─╖    ╒═╤═╕    ╭─┬─╮    ┏━┳━┓    ╔═╦═╗     +─+─+
// │ │ │    ║ ║ ║    ║ ║ ║    │ │ │    │ │ │    ┃ ┃ ┃    ║ ║ ║     | | |
// ├─┼─┤    ╠═╬═╣    ╟─╫─╢    ╞═╪═╡    ├─┼─┤    ┣━╋━┫    ╟─╫─╢     +-+-+
// └─┴─┘    ╚═╩═╝    ╙─╨─╜    ╘═╧═╛    ╰─┴─╯    ┗━┻━┛    ╙─╨─╜     +─+─+
// Single   Double   LightD   Mixed    Rounded  Heavy    L+Double  ASCII

// ┌───────────────────┐
// │  ╔═══╗ Some Text  │▒
// │  ╚═╦═╝ in the box │▒
// ╞═╤══╩══╤═══════════╡▒
// │ ├──┬──┤           │▒
// │ └──┴──┘           │▒
// └───────────────────┘▒
//  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

class ELogBoxStyle {
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

  const ELogBoxStyle({
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
}

class EBoxStyle {
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

  const EBoxStyle({
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

  factory EBoxStyle.from(ELogBoxStyle style) {
    return EBoxStyle(
      topLeft: style.topLeft,
      topRight: style.topRight,
      bottomLeft: style.bottomLeft,
      bottomRight: style.bottomRight,
      vertical: style.vertical,
      horizontal: style.horizontal,
      middleLeft: style.middleLeft,
      middleRight: style.middleRight,
      middleTop: style.middleTop,
      middleBottom: style.middleBottom,
      cross: style.cross,
    );
  }

  static final single = EBoxStyle.from(ELogBox.single);
  static final double = EBoxStyle.from(ELogBox.double);
  static final rounded = EBoxStyle.from(ELogBox.rounded);
  static final mixed = EBoxStyle.from(ELogBox.mixed);
  static final heavy = EBoxStyle.from(ELogBox.heavy);
  static final lightDouble = EBoxStyle.from(ELogBox.lightDouble);
  static final ascii = EBoxStyle.from(ELogBox.ascii);
}

class ELogBox {
  static const single = ELogBoxStyle(
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

  static const double = ELogBoxStyle(
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

  static const rounded = ELogBoxStyle(
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

  static const mixed = ELogBoxStyle(
    topLeft: '╓',
    topRight: '╖',
    bottomLeft: '╙',
    bottomRight: '╜',
    vertical: '│',
    horizontal: '═',
    middleLeft: '╟',
    middleRight: '╢',
    middleTop: '╥',
    middleBottom: '╨',
    cross: '╫',
  );

  static const heavy = ELogBoxStyle(
    topLeft: '┏',
    topRight: '┓',
    bottomLeft: '┗',
    bottomRight: '┛',
    vertical: '┃',
    horizontal: '━',
    middleLeft: '┣',
    middleRight: '┫',
    middleTop: '┳',
    middleBottom: '┻',
    cross: '╋',
  );

  static const lightDouble = ELogBoxStyle(
    topLeft: '╒',
    topRight: '╕',
    bottomLeft: '╘',
    bottomRight: '╛',
    vertical: '║',
    horizontal: '─',
    middleLeft: '╞',
    middleRight: '╡',
    middleTop: '╤',
    middleBottom: '╧',
    cross: '╪',
  );

  static const ascii = ELogBoxStyle(
    topLeft: '+',
    topRight: '+',
    bottomLeft: '+',
    bottomRight: '+',
    vertical: '|',
    horizontal: '-',
    middleLeft: '+',
    middleRight: '+',
    middleTop: '+',
    middleBottom: '+',
    cross: '+',
  );
}
