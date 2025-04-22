final class BorderBox {
  final String boxTopLeftBorder;
  final String boxTopRightBorder;
  final String boxMiddleRight;
  final String boxMiddleLeft;
  final String boxBottomLeftBorder;
  final String boxBottomRightBorder;

  const BorderBox({
    this.boxTopLeftBorder = '╭',
    this.boxTopRightBorder = '╮',
    this.boxBottomLeftBorder = '╰',
    this.boxBottomRightBorder = '╯',
    this.boxMiddleLeft = '├',
    this.boxMiddleRight = '┤',
  });
}
