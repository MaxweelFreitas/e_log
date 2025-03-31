final class LogEntryContent {
  final String divider;
  final String labelTitle;
  final String title;
  final String labelTime;
  final String time;
  final String labelMessage;
  final String message;
  final String source;
  final String linkText;
  final String url;
  final String traceMessage;

  const LogEntryContent({
    this.divider = '|',
    this.labelTitle = '',
    this.title = '',
    this.labelTime = '',
    this.time = '',
    this.labelMessage = '',
    this.message = '',
    this.source = '',
    this.linkText = '',
    this.url = '',
    this.traceMessage = '',
  });
}
