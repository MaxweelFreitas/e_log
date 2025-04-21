import '../base/e_log_box.dart';

final class BorderBox {
  final String boxTopLeftBorder;
  final String boxTopRightBorder;
  final String boxMiddleRight;
  final String boxMiddleLeft;
  final String boxBottomLeftBorder;
  final String boxBottomRightBorder;

  const BorderBox({
    this.boxTopLeftBorder = ELogBox.topLeftArc,
    this.boxTopRightBorder = ELogBox.topRightArc,
    this.boxBottomLeftBorder = ELogBox.bottomLeftArc,
    this.boxBottomRightBorder = ELogBox.bottomRightArc,
    this.boxMiddleLeft = ELogBox.middleLeft,
    this.boxMiddleRight = ELogBox.middleRight,
  });
}
