import '../base/e_log_box.dart';
import '../base/x_term/x_term_color.dart';

/// ## Default [LogLevel] printed.
///
/// Output looks like this:
/// ```dart
///
/// ┤ ⎕ ◻◻◻◻◻ ├
///
/// ```
/// where:
/// ┤        ⇒ is the prefix
/// ⎕       ⇒ is the icon
/// ◻◻◻◻◻ ⇒ is the name
/// ├        ⇒ is the sufix
///
/// and they can all be replaced
final class LogLevel {
  /// @param prefix marcação gráfica apresentada antes do termo logLevel.
  final String prefix;
  final String icon;
  final String nameBgColor;
  final String nameColor;
  final String name;
  final String sufix;

  const LogLevel({
    this.prefix = ELogBox.middleRight,
    this.icon = '',
    this.nameBgColor = XTermColor.reset,
    this.nameColor = XTermColor.white,
    this.name = '',
    this.sufix = ELogBox.middleLeft,
  });
}
