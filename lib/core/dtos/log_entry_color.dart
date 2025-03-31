import '../base/x_term/x_term_color.dart';

final class LogEntryColor {
  final String dividerColor;
  final String labelTitleColor;
  final String titleColor;
  final String labelTimeColor;
  final String labelMessageColor;
  final String messageColor;
  final String sourceColor;
  final String timeColor;

  const LogEntryColor({
    this.dividerColor = XTermColor.white,
    this.labelTitleColor = XTermColor.white,
    this.titleColor = XTermColor.white,
    this.labelTimeColor = XTermColor.white,
    this.timeColor = '',
    this.labelMessageColor = XTermColor.white,
    this.messageColor = XTermColor.white,
    this.sourceColor = XTermColor.white,
  });
}
