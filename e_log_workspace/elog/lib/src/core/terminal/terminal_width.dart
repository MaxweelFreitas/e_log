import 'terminal_info.dart';

class TerminalWidthResolver {
  static int resolve({
    int? userWidth,
    int? minWidth,
    int? maxWidth,
    required int contentWidth,
  }) {
    int width;

    if (userWidth != null && userWidth > 0) {
      width = userWidth;
    } else {
      final terminalWidth = TerminalInfo.width;
      if (terminalWidth != null && terminalWidth > 0) {
        width = terminalWidth;
      } else {
        width = contentWidth;
      }
    }

    if (minWidth != null) {
      width = width < minWidth ? minWidth : width;
    }

    if (maxWidth != null) {
      width = width > maxWidth ? maxWidth : width;
    }

    return width;
  }
}
