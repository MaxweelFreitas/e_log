import 'package:e_log/core/base/e_log.dart';
import 'package:e_log/core/base/x_term/x_term_color.dart';
import 'package:e_log/core/base/x_term/x_term_style.dart';
import 'package:e_log/core/dtos/log_entry_content.dart';
import 'package:e_log/core/dtos/log_level.dart';
import 'package:e_log/helpers/system.dart';
import 'package:e_log/helpers/tools/converter.dart';
import 'package:e_log/src/elegant_log.dart';
import 'package:test/test.dart';

void main() {
  group('Log Levels Model ⇒', () {
    test('Error', () {
      String fileName;
      List<String> resultLinks;
      try {
        throw ArgumentError('Invalid argument');
      } on Exception catch (e, stacktrace) {
        fileName = System.getFileName(stacktrace);
        resultLinks = System.getStackTraceLinks(stacktrace);
      }

      final stopwatch = Stopwatch()..start();
      ElegantLog.error(
        logEntryContent: LogEntryContent(
          labelTitle: 'Title:',
          title: 'Title of my error',
          labelMessage:
              'Message pasdakdsnm asd asdmasm as dasdnmasmdkaskd a dasda:',
          message: 'Lorem Ipsum is simply dummy text of the .',
          source: fileName,
          linkText: 'GoogleLinkGrande',
          url:
              'https://www.google.com/search?sca_esv=c1c83ae130d39436&sxsrf=ADLYWIJd-re6y0p4FKchn5C5AJFQNIk4yg:1722989539438&q=nado+sincronizado+olimpíadas&oi=ddle&ct=348045984&hl=pt-BR&sa=X&ved=0ahUKEwjx68mbzOGHAxXhpJUCHeifNNgQPQgL&biw=1516&bih=981&dpr=1',
          traceMessage: resultLinks.join(' '),
        ),
        isDashed: true,
        lineLength: 70,
      );

      stopwatch.stop();

      eLog(elapsedToHMS(stopwatch.elapsed));
    });

    test('Warning', () {
      final stopwatch = Stopwatch()..start();
      ElegantLog.warning(
        logLevel: const LogLevel(
          icon: '🚧',
          name: ' Warning',
          nameColor: XTermColor.yellow,
        ),
        logEntryContent: const LogEntryContent(
          labelTitle: 'Title:',
          title: 'Title of my warning',
          labelMessage: 'Message pasdakdsnm asd asdmasm:',
          message: 'Lorem Ipsum is simply dummy text of the  warning.',
          source: r'lib\n_z_log.dart',
          linkText: 'GoogleLinkGrande',
          url: 'https://www.google.com/',
        ),
        isDashed: true,
        lineLength: 70,
      );

      stopwatch.stop();

      eLog(elapsedToHMS(stopwatch.elapsed));
    });

    test('Info', () {
      final stopwatch = Stopwatch()..start();
      ElegantLog.info(
        logLevel: const LogLevel(
          icon: '📢',
          name: ' Info',
          nameColor: XTermColor.yellow,
        ),
        logEntryContent: const LogEntryContent(
          labelTitle: 'Title:',
          title: 'Title of my warning',
          labelMessage: 'Message pasdakdsnm asd asdmasm:',
          message: 'Lorem Ipsum is simply dummy text of the  warning.',
          source: r'lib\n_z_log.dart',
          linkText: 'GoogleLinkGrande',
          url: 'https://www.google.com/',
        ),
        isDashed: true,
        lineLength: 70,
      );

      stopwatch.stop();

      eLog(elapsedToHMS(stopwatch.elapsed));
    });

    test('Debug', () {
      final stopwatch = Stopwatch()..start();
      ElegantLog.debug(
        logLevel: const LogLevel(
          icon: '🐜',
          name: ' Debug',
          nameColor: XTermColor.magenta,
        ),
        logEntryContent: const LogEntryContent(
          labelTitle: 'Title:',
          title: 'Title of my warning',
          labelMessage: 'Message pasdakdsnm asd asdmasm:',
          message: 'Lorem Ipsum is simply dummy text of the  warning.',
          source: r'lib\n_z_log.dart',
          linkText: 'GoogleLinkGrande',
          url: 'https://www.google.com/',
        ),
        isDashed: true,
        lineLength: 70,
      );

      stopwatch.stop();

      eLog(elapsedToHMS(stopwatch.elapsed));
    });
  });

  test('n z log a', () async {
    final stopwatch = Stopwatch()..start();
    final a = drawText(
      labelColor: XTermColor.cyan,
      label:
          'Comentários utilizado para facilitar o entendimento em ambiente de debug de código:',
      messageColor: XTermColor.white,
      message:
          'Lorem ipsum dolor Amet. Explicabo iusto magni consectetur casamento et perspiciatis. deleniti qui tenetur expedita. Ut omnis aperiam aut neque perferendis', // et voluptatum nulla ab harum consequatur.',
      dividerColor: XTermColor.red,
      maxCharsPerLine: 70,
    );

    stopwatch.stop();

    eLog(a);
    eLog(elapsedToHMS(stopwatch.elapsed));
  });

  test('n z log b', () {
    final stopwatch = Stopwatch()..start();
    final a = drawText(
      labelColor: XTermColor.cyan,
      label:
          'Comentários utilizado para facilitar o entendimento em ambiente de debug de código:',
      messageColor: XTermColor.white,
      message: removeEscapedANSI(XTermStyle.link(
          url: r'lib\n_z_log.dart', linkText: r'lib\n_z_log.dart')),
      dividerColor: XTermColor.red,
    );

    stopwatch.stop();

    print(a);
    eLog(elapsedToHMS(stopwatch.elapsed));
    print(XTermStyle.link(
        url: r'lib\n_z_log.dart', linkText: r'lib\n_z_log.dart'));
  });
}
