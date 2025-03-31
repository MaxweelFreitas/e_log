import '../base/elegant_box.dart';

final class BorderBox {
  final String boxTopLeftBorder;
  final String boxTopRightBorder;
  final String boxMiddleRight;
  final String boxMiddleLeft;
  final String boxBottomLeftBorder;
  final String boxBottomRightBorder;

  const BorderBox({
    this.boxTopLeftBorder = ElegantBox.topLeftArc,
    this.boxTopRightBorder = ElegantBox.topRightArc,
    this.boxBottomLeftBorder = ElegantBox.bottomLeftArc,
    this.boxBottomRightBorder = ElegantBox.bottomRightArc,
    this.boxMiddleLeft = ElegantBox.middleLeft,
    this.boxMiddleRight = ElegantBox.middleRight,
  });
}
