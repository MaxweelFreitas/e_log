import '../core/base/e_log.dart';
import '../core/base/x_term/x_term_color.dart';
import '../core/base/x_term/x_term_style.dart';
import '../core/dtos/border_box.dart';
import '../core/dtos/log_entry_color.dart';
import '../core/dtos/log_entry_content.dart';
import '../core/dtos/log_level.dart';
import '../helpers/tools/converter.dart';
import '../helpers/tools/draw_functions.dart';
import '../services/save_log_service.dart';
import '../theme/elegant_icons.dart';

class ElegantLog {
  static const lineLength = 75;

// '${ElegantBox.middleRight}$emoji Error ${ElegantBox.middleLeft}'
  static void error({
    LogLevel logLevel = const LogLevel(
      icon: ElegantIcons.errorIcon,
      name: ' Error',
      nameColor: XTermColor.red,
    ),
    BorderBox borders = const BorderBox(),
    LogEntryContent logEntryContent = const LogEntryContent(),
    LogEntryColor logEntryColor = const LogEntryColor(
      dividerColor: XTermColor.red,
      labelTimeColor: XTermColor.red,
      timeColor: XTermColor.white,
      labelTitleColor: XTermColor.red,
      labelMessageColor: XTermColor.red,
    ),
    int lineLength = 75,
    bool isDated = true,
    bool isDashed = false,
    bool forcePrint = false,
    bool printLogToFile = true,
    LevelAlignment levelAlignment = LevelAlignment.left,
  }) {
    _box(
      logLevel: logLevel,
      levelAlignment: levelAlignment,
      borders: borders,
      dividerColor: logEntryColor.dividerColor,
      divider: logEntryContent.divider,
      labelTitleColor: logEntryColor.labelTitleColor,
      labelTitle: logEntryContent.labelTitle,
      titleColor: logEntryColor.titleColor,
      title: logEntryContent.title,
      labelTimeColor: logEntryColor.labelTimeColor,
      labelTime: logEntryContent.labelTime,
      timeColor: logEntryColor.timeColor,
      time: logEntryContent.time,
      labelMessageColor: logEntryColor.labelMessageColor,
      labelMessage: logEntryContent.labelMessage,
      messageColor: logEntryColor.messageColor,
      message: logEntryContent.message,
      sourceColor: logEntryColor.sourceColor,
      source: logEntryContent.source,
      lineLength: lineLength,
      url: logEntryContent.url,
      linkText: logEntryContent.linkText,
      isDated: isDated,
      isDashed: isDashed,
      forcePrint: forcePrint,
      printLogToFile: printLogToFile,
      traceMessage: logEntryContent.traceMessage,
    );
  }

  static void warning({
    LogLevel logLevel = const LogLevel(
      icon: ElegantIcons.warningIcon,
      name: ' Warning ',
      nameColor: XTermColor.yellow,
    ),
    bool printLogToFile = true,
    BorderBox borders = const BorderBox(),
    int lineLength = 75,
    LogEntryContent logEntryContent = const LogEntryContent(),
    LogEntryColor logEntryColor = const LogEntryColor(
      dividerColor: XTermColor.yellow,
      labelTimeColor: XTermColor.yellow,
      timeColor: XTermColor.white,
      labelTitleColor: XTermColor.yellow,
      labelMessageColor: XTermColor.yellow,
    ),
    LevelAlignment levelAlignment = LevelAlignment.left,
    bool isDated = true,
    bool isDashed = false,
    bool forcePrint = false,
  }) {
    _box(
      logLevel: logLevel,
      levelAlignment: levelAlignment,
      borders: borders,
      dividerColor: logEntryColor.dividerColor,
      divider: logEntryContent.divider,
      labelTitleColor: logEntryColor.labelTitleColor,
      labelTitle: logEntryContent.labelTitle,
      titleColor: logEntryColor.titleColor,
      title: logEntryContent.title,
      labelTimeColor: logEntryColor.labelTimeColor,
      labelTime: logEntryContent.labelTime,
      timeColor: logEntryColor.timeColor,
      time: logEntryContent.time,
      labelMessageColor: logEntryColor.labelMessageColor,
      labelMessage: logEntryContent.labelMessage,
      messageColor: logEntryColor.messageColor,
      message: logEntryContent.message,
      sourceColor: logEntryColor.sourceColor,
      source: logEntryContent.source,
      lineLength: lineLength,
      url: logEntryContent.url,
      linkText: logEntryContent.linkText,
      isDated: isDated,
      isDashed: isDashed,
      forcePrint: forcePrint,
      printLogToFile: printLogToFile,
    );
  }

  static void info({
    BorderBox borders = const BorderBox(),
    bool printLogToFile = true,
    LogEntryColor logEntryColor = const LogEntryColor(
      dividerColor: XTermColor.blue,
      labelTimeColor: XTermColor.blue,
      timeColor: XTermColor.white,
      labelTitleColor: XTermColor.blue,
      labelMessageColor: XTermColor.blue,
    ),
    LogEntryContent logEntryContent = const LogEntryContent(),
    LogLevel logLevel = const LogLevel(
      icon: ElegantIcons.infoIcon,
      name: 'Info ',
      nameColor: XTermColor.blue,
    ),
    LevelAlignment levelAlignment = LevelAlignment.left,
    int lineLength = 75,
    bool isDated = true,
    bool isDashed = false,
    bool forcePrint = false,
  }) {
    _box(
      logLevel: logLevel,
      levelAlignment: levelAlignment,
      borders: borders,
      dividerColor: logEntryColor.dividerColor,
      divider: logEntryContent.divider,
      labelTitleColor: logEntryColor.labelTitleColor,
      labelTitle: logEntryContent.labelTitle,
      titleColor: logEntryColor.titleColor,
      title: logEntryContent.title,
      labelTimeColor: logEntryColor.labelTimeColor,
      labelTime: logEntryContent.labelTime,
      timeColor: logEntryColor.timeColor,
      time: logEntryContent.time,
      labelMessageColor: logEntryColor.labelMessageColor,
      labelMessage: logEntryContent.labelMessage,
      messageColor: logEntryColor.messageColor,
      message: logEntryContent.message,
      sourceColor: logEntryColor.sourceColor,
      source: logEntryContent.source,
      lineLength: lineLength,
      url: logEntryContent.url,
      linkText: logEntryContent.linkText,
      isDated: isDated,
      isDashed: isDashed,
      forcePrint: forcePrint,
      printLogToFile: printLogToFile,
    );
  }

  static void debug({
    BorderBox borders = const BorderBox(),
    bool printLogToFile = true,
    LogEntryContent logEntryContent = const LogEntryContent(),
    LogEntryColor logEntryColor = const LogEntryColor(
      dividerColor: XTermColor.magenta,
      labelTimeColor: XTermColor.magenta,
      timeColor: XTermColor.white,
      labelTitleColor: XTermColor.magenta,
      labelMessageColor: XTermColor.magenta,
    ),
    LogLevel logLevel = const LogLevel(
      icon: ElegantIcons.debugIcon,
      name: ' Debug ',
      nameColor: XTermColor.magenta,
    ),
    LevelAlignment levelAlignment = LevelAlignment.left,
    int lineLength = 75,
    bool isDated = true,
    bool isDashed = false,
    bool forcePrint = false,
  }) {
    _box(
      logLevel: logLevel,
      levelAlignment: levelAlignment,
      borders: borders,
      dividerColor: logEntryColor.dividerColor,
      divider: logEntryContent.divider,
      labelTitleColor: logEntryColor.labelTitleColor,
      labelTitle: logEntryContent.labelTitle,
      titleColor: logEntryColor.titleColor,
      title: logEntryContent.title,
      labelTimeColor: logEntryColor.labelTimeColor,
      labelTime: logEntryContent.labelTime,
      timeColor: logEntryColor.timeColor,
      time: logEntryContent.time,
      labelMessageColor: logEntryColor.labelMessageColor,
      labelMessage: logEntryContent.labelMessage,
      messageColor: logEntryColor.messageColor,
      message: logEntryContent.message,
      sourceColor: logEntryColor.sourceColor,
      source: logEntryContent.source,
      lineLength: lineLength,
      url: logEntryContent.url,
      linkText: logEntryContent.linkText,
      isDated: isDated,
      isDashed: isDashed,
      forcePrint: forcePrint,
      printLogToFile: printLogToFile,
    );
  }
}

String _showDateTime(DateTime dateTime) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String year = dateTime.year.toString().padLeft(4, '0');
  String month = twoDigits(dateTime.month);
  String day = twoDigits(dateTime.day);
  String hour = twoDigits(dateTime.hour);
  String minute = twoDigits(dateTime.minute);
  String second = twoDigits(dateTime.second);

  return '$year-$month-$day $hour:$minute:$second';
}

Future<void> _box({
  BorderBox borders = const BorderBox(),
  LogLevel logLevel = const LogLevel(),
  LevelAlignment levelAlignment = LevelAlignment.middle,
  String dividerColor = '',
  String divider = '',
  String labelTitleColor = '',
  String labelTitle = '',
  String titleColor = '',
  String title = '',
  String labelTimeColor = '',
  String labelTime = '',
  String timeColor = '',
  String time = '',
  String labelMessageColor = '',
  String labelMessage = '',
  String messageColor = '',
  String message = '',
  String sourceColor = '',
  String source = '',
  int lineLength = 75,
  String url = '',
  String linkText = '',
  String traceMessage = '',
  bool isDated = true,
  bool isDashed = false,
  bool forcePrint = false,
  bool printLogToFile = true,
}) async {
  String logPath = '';
  final SaveLogService saveService = JsonSaveLogService();
  // final SaveLogService saveService = TxtSaveLogService();
  if (forcePrint) {
    DrawFunctions.drawTop(
      levelAlignment: levelAlignment,
      logLevel: logLevel,
      borderColor: dividerColor,
      boxTopLeftBorder: borders.boxTopLeftBorder,
      boxTopRightBorder: borders.boxTopRightBorder,
      lineLength: lineLength,
    );

    if (title.isNotEmpty) {
      final titleLog = drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: labelTitleColor,
        label: labelTitle,
        messageColor: titleColor,
        message: title,
        maxCharsPerLine: lineLength,
        printLogToFile: printLogToFile,
      );
      logPath =
          printLogFile(printLogToFile, logPath, saveService, titleLog, divider);
    }

    DrawFunctions.drawMedium(
      borderColor: dividerColor,
      boxMiddleRight: borders.boxMiddleRight,
      boxMiddleLeft: borders.boxMiddleLeft,
      lineLength: lineLength,
      isDashed: isDashed,
    );

    if (isDated) {
      final titleLog = drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: labelTimeColor,
        label: labelTime.isEmpty ? 'Log Time:' : labelTime,
        messageColor: timeColor,
        message: time.isEmpty ? _showDateTime(DateTime.now()) : time,
        printLogToFile: printLogToFile,
        maxCharsPerLine: lineLength,
      );
      logPath =
          printLogFile(printLogToFile, logPath, saveService, titleLog, divider);
    }

    DrawFunctions.drawMedium(
      borderColor: dividerColor,
      boxMiddleRight: borders.boxMiddleRight,
      boxMiddleLeft: borders.boxMiddleLeft,
      lineLength: lineLength,
      isDashed: isDashed,
    );

    if (source.isNotEmpty) {
      final messageLog = drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: dividerColor,
        label: 'Source path:',
        messageColor: sourceColor,
        message: source,
        // XTermStyle.link(
        //   linkText: sourceColor + source,
        //   url: source,
        // ),
        maxCharsPerLine: lineLength,
        printLogToFile: printLogToFile,
      );
      logPath = printLogFile(
          printLogToFile, logPath, saveService, messageLog, divider);
    }

    DrawFunctions.drawMedium(
      borderColor: dividerColor,
      boxMiddleRight: borders.boxMiddleRight,
      boxMiddleLeft: borders.boxMiddleLeft,
      lineLength: lineLength,
      isDashed: isDashed,
    );

    if (message.isNotEmpty) {
      final messageLog = drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: dividerColor,
        label: labelMessage,
        messageColor: messageColor,
        message: message,
        maxCharsPerLine: lineLength,
        printLogToFile: printLogToFile,
      );
      logPath = printLogFile(
          printLogToFile, logPath, saveService, messageLog, divider);
    }
    DrawFunctions.drawMedium(
      borderColor: dividerColor,
      boxMiddleRight: borders.boxMiddleRight,
      boxMiddleLeft: borders.boxMiddleLeft,
      lineLength: lineLength,
      isDashed: isDashed,
    );

    if (url.isNotEmpty) {
      final linkMessage = XTermStyle.link(url: url, linkText: linkText);

      drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: dividerColor,
        label: 'Link:',
        messageColor: messageColor,
        message: linkMessage,
        maxCharsPerLine: lineLength,
        printLogToFile: printLogToFile,
      );
      logPath = printLogFile(printLogToFile, logPath, saveService,
          'Link: $linkText - $url', divider);
    }

    DrawFunctions.drawMedium(
      borderColor: dividerColor,
      boxMiddleRight: borders.boxMiddleRight,
      boxMiddleLeft: borders.boxMiddleLeft,
      lineLength: lineLength,
      isDashed: isDashed,
    );

    if (url.isNotEmpty) {
      // final linkMessage = XTermStyle.link(url: url, linkText: linkText);

      drawText(
        dividerColor: dividerColor,
        divider: divider,
        labelColor: dividerColor,
        label: 'StackTrace:',
        messageColor: messageColor,
        message: traceMessage,
        maxCharsPerLine: lineLength,
        printLogToFile: printLogToFile,
      );
      logPath = printLogFile(printLogToFile, logPath, saveService,
          'Link: $linkText - $url', divider);
    }

    DrawFunctions.drawBottom(
      borderColor: dividerColor,
      boxBottomLeftBorder: borders.boxBottomLeftBorder,
      boxBottomRightBorder: borders.boxBottomRightBorder,
      lineLength: lineLength,
    );
  }
  if (printLogToFile) {
    eLog('View logFile in $logPath');
  }
}

String printLogFile(
  bool printLogToFile,
  String logPath,
  SaveLogService saveService,
  String titleLog,
  String divider,
) {
  if (printLogToFile) {
    // _logPath = await saveService.saveLog(titleLog, filePath: _logPath);
    return saveService.saveLog(
        removeEscapedANSI(titleLog).replaceAll(divider, '').trim(),
        filePath: logPath);
  }
  return '';
}

String drawText({
  String label = '',
  String message = '',
  String divider = '|',
  String dividerColor = '',
  String labelColor = '',
  String messageColor = '',
  int maxCharsPerLine = 60,
  bool printLogToFile = true,
}) {
  List<List<String>> corpus = [];
  List<String> labelWords = label.split(' ');
  List<String> messageWords = message.split(' ');
  List<String> lineList = [];

  int lastUsedWord = 0;

  final setOfWords = labelWords + messageWords;

  do {
    final (b, logLine) = fillText(
      lastIndex: lastUsedWord,
      dividerColor: dividerColor,
      divider: divider,
      labelColor: labelColor,
      labelWords: labelWords,
      messageColor: messageColor,
      messageWords: messageWords,
      maxCharsPerLine: maxCharsPerLine - 3,
    );

    if (b.isNotEmpty) {
      corpus.add(b);
      if (b.last.isEmpty || b.last.contains(' ')) {
        b.removeAt(b.length - 1);
      }
      lastUsedWord += b.length;
      lineList.add(logLine.replaceAll(divider, '').trim());
    } else {
      break;
    }
  } while (setOfWords.length > lastUsedWord);

  // print(corpus);

  return lineList.join(' ');
}

(List<String>, String) fillText({
  int lastIndex = 0,
  String labelColor = '',
  String messageColor = '',
  String dividerColor = '',
  List<String> labelWords = const [],
  List<String> messageWords = const [],
  String divider = '|',
  int maxCharsPerLine = 0,
  int indexStart = 0,
}) {
  List<String> content = [];
  int numOfChar = 0;

  // Considerando dois dividers e dois espaços
  final divSpace = divider.length * 2;

  final setOfWords = labelWords + messageWords;

  if (setOfWords.isNotEmpty) {
    for (var i = lastIndex; i < setOfWords.length; i++) {
      numOfChar = content.join(' ').length;
      int numCharWithSpaces = numOfChar + divSpace;

      final word = setOfWords[i];
      final currentWord = setOfWords[i].length;
      int lenNewWord = numCharWithSpaces + currentWord;

      // Adiciona espaço se não for a primeira palavra
      if (content.isNotEmpty) {
        lenNewWord += 1; // Espaco para separar palavras
      }

      if (lenNewWord < maxCharsPerLine) {
        content.add(word);
      } else if (currentWord > maxCharsPerLine) {
        List<String> chunks = splitString(word, maxCharsPerLine - 5);
        content.addAll(chunks);
        break;
      } else {
        break;
      }
    }

    // Adiciona o padding à direita para completar a linha
    // Adicionando o +1 pro calculo bater com o maxCharsPerLine, pois a linha tava ficando com tamanho igual ao maxCharsPerLine + 1

    final charsWithSpaces = removeEscapedANSI(content.join(' ')).length;
    int padRight = maxCharsPerLine - (charsWithSpaces + divSpace);

    if (padRight > 0) {
      content.add(''.padRight(padRight));
    }

    // Formatar a linha com os dividers
    String line = '$divider ${content.join(' ')} $divider';

    // Ajustar o comprimento da linha para garantir que seja exato
    if (line.length < maxCharsPerLine) {
      line = line.padRight(maxCharsPerLine - 1) + divider;
    }

    // Gerar linha colorida
    final coloredLine = _lineGenerator(
      labelColor: labelColor,
      messageColor: messageColor,
      dividerColor: dividerColor,
      divider: divider,
      labelWords: labelWords,
      messageWords: messageWords,
      content: content,
    );

    eLog(coloredLine);

    return (content, line);
  } else {
    return (<String>[], '');
  }
}

List<String> splitString(String text, int chunkSize) {
  List<String> chunks = [];
  for (int i = 0; i < text.length; i += chunkSize) {
    int endIndex = (i + chunkSize < text.length) ? i + chunkSize : text.length;
    chunks.add(text.substring(i, endIndex));
  }
  return chunks;
}

String _lineGenerator({
  String labelColor = '',
  String messageColor = '',
  String dividerColor = '',
  String reset = '\x1B[0m',
  String divider = '|',
  List<String> labelWords = const [],
  List<String> messageWords = const [],
  List<String> content = const [],
}) {
  final result = StringBuffer();
  if (content.isNotEmpty) {
    result.write('$dividerColor$divider ');

    for (var word in content) {
      if (labelWords.contains(word)) {
        result.write('$labelColor$word ');
      } else if (messageWords.contains(word)) {
        result.write('$messageColor$word ');
      } else {
        result.write('$word ');
      }
    }

    result.write('$dividerColor$divider$reset');
  }
  var string = result.toString();
  if (string.startsWith(r'[31m| [36mLink: ]8;;')) {
    string.replaceAll(' ', '').trim();
  }
  return string;
}
