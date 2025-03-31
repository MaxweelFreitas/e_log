import '../../core/base/e_log.dart';
import '../../core/base/elegant_box.dart';
import '../../core/dtos/log_level.dart';
import '../../core/base/x_term/x_term_color.dart';
import '../../core/base/x_term/x_term_style.dart';

enum LevelAlignment { left, middle, right }

class DrawFunctions {
  static String drawTop({
    String borderColor = XTermColor.white,
    String boxTopLeftBorder = ElegantBox.topLeftArc,
    String boxTopRightBorder = ElegantBox.topRightArc,
    LogLevel logLevel = const LogLevel(),
    LevelAlignment levelAlignment = LevelAlignment.middle,
    int lineLength = 75,
  }) {
    final llRounded = lineLength % 2 == 0 ? 3 : 2;
    final icon = logLevel.icon.isNotEmpty
        ? logLevel.name.isEmpty
            ? '${logLevel.icon} '
            : logLevel.icon
        : '';
    final name = logLevel.name.isNotEmpty ? '${logLevel.name} ' : '';
    final content =
        '$borderColor${logLevel.prefix}${logLevel.nameBgColor}${logLevel.nameColor} $icon$name${XTermStyle.reset}$borderColor${logLevel.sufix}';
    final hdivLen = lineLength -
        boxTopLeftBorder.length +
        boxTopRightBorder.length -
        icon.length -
        name.length -
        llRounded;

    final hDivLenP2 = hdivLen ~/ 2;
    if (logLevel.icon.isNotEmpty && logLevel.name.isEmpty) {
      //Draw icon
      final String result = switch (levelAlignment) {
        //TypedTop ⇒ ╭┤ ⎕ ├──────────────────────────────────────────────────────╮
        LevelAlignment.left =>
          '$borderColor$boxTopLeftBorder$content${horizontalDivider(lineLength: hdivLen)}$boxTopRightBorder${XTermStyle.reset}',
        //TypedTop ⇒ ╭──────────────────────────────────────────────────────┤ ⎕ ├╮
        LevelAlignment.right =>
          '$borderColor$boxTopLeftBorder${horizontalDivider(lineLength: hdivLen)}$content$boxTopRightBorder${XTermStyle.reset}',
        //TypedTop ⇒ ╭──────────────────────┤ ⎕ ├────────────────────────────────╮
        LevelAlignment.middle =>
          '$borderColor$boxTopLeftBorder${horizontalDivider(lineLength: hDivLenP2 + 1)}$content$borderColor${horizontalDivider(lineLength: hDivLenP2 + 1)}$boxTopRightBorder${XTermStyle.reset}',
      };
      eLog(result);
      return result;
    } else if (logLevel.icon.isNotEmpty && logLevel.name.isNotEmpty) {
      //Draw both
      final String result = switch (levelAlignment) {
        //TypedTop ⇒ ╭┤ ⎕ ◻◻◻◻◻ ├──────────────────────────────────────────────╮
        LevelAlignment.left =>
          '$borderColor$boxTopLeftBorder$content${horizontalDivider(lineLength: hdivLen)}$boxTopRightBorder${XTermStyle.reset}',
        //TypedTop ⇒ ╭──────────────────────────────────────────────┤ ⎕ ◻◻◻◻◻ ├╮
        LevelAlignment.right =>
          '$borderColor$boxTopLeftBorder${horizontalDivider(lineLength: hdivLen)}$content$boxTopRightBorder${XTermStyle.reset}',
        //TypedTop ⇒ ╭──────────────────────┤ ⎕ ◻◻◻◻◻ ├────────────────────────╮
        LevelAlignment.middle =>
          '$borderColor$boxTopLeftBorder${horizontalDivider(lineLength: hDivLenP2 + 1)}$content$borderColor${horizontalDivider(lineLength: hDivLenP2 + 1)}$boxTopRightBorder${XTermStyle.reset}',
      };
      eLog(result);
      return result;
    } else {
      //TypedTop ⇒ ╭────────────────────────────────────────────────────────────╮
      final result =
          '$borderColor$boxTopLeftBorder${horizontalDivider(lineLength: lineLength)}$boxTopRightBorder${XTermStyle.reset}';
      eLog(result);
      return result;
    }
  }

  static String horizontalDivider(
      {int lineLength = 75, bool isDashed = false}) {
    late final String lineType;
    if (!isDashed) {
      lineType = ElegantBox.line;
    } else {
      lineType = ElegantBox.dashedRight;
    }
    return List.filled(lineLength - 2, lineType).join();
  }

  static String drawMedium({
    String borderColor = XTermColor.white,
    String boxMiddleRight = ElegantBox.middleRight,
    String boxMiddleLeft = ElegantBox.middleLeft,
    int lineLength = 75,
    bool isDashed = false,
  }) {
    //
    //Dashed ⇒ ├╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶╶┤
    //Lined  ⇒ ├──────────────────────────────────────────────────────────────────────────┤

    final result =
        '$borderColor$boxMiddleLeft${horizontalDivider(lineLength: lineLength, isDashed: isDashed)}$boxMiddleRight${XTermStyle.reset}';
    eLog(result);
    return result;
  }

  static String drawBottom({
    String borderColor = XTermColor.white,
    String boxBottomLeftBorder = ElegantBox.bottomLeftArc,
    String boxBottomRightBorder = ElegantBox.bottomRightArc,
    int lineLength = 75,
  }) {
    //Example
    //Lined  ⇒ ╰──────────────────────────────────────────────────────────────────────────╯
    final result =
        '$borderColor$boxBottomLeftBorder${horizontalDivider(lineLength: lineLength)}$boxBottomRightBorder${XTermStyle.reset}';
    eLog(result);
    return result;
  }
}
