import 'package:e_log/core/base/e_log.dart';
import 'package:e_log/core/dtos/log_level.dart';
import 'package:e_log/helpers/tools/draw_functions.dart';
import 'package:test/test.dart';

void main() {
  group('drawFunctions TOP ⇒', () {
    test('simple', () {
      final result = DrawFunctions.drawTop();
      eLog(result);
    });

    test('icon left', () {
      final result = DrawFunctions.drawTop(
        levelAlignment: LevelAlignment.left,
        logLevel: const LogLevel(
          icon: '🚨',
        ),
      );

      eLog(result);
    });

    test('icon right', () {
      final result = DrawFunctions.drawTop(
        levelAlignment: LevelAlignment.right,
        logLevel: const LogLevel(
          icon: '🚨',
        ),
      );

      eLog(result);
    });

    test('icon middle', () {
      final result = DrawFunctions.drawTop(
        logLevel: const LogLevel(
          icon: '🚨',
        ),
      );

      eLog(result);
    });

    test('icon + name left', () {
      final result = DrawFunctions.drawTop(
        levelAlignment: LevelAlignment.left,
        logLevel: const LogLevel(
          icon: '🚨',
          name: 'Teste',
        ),
      );

      eLog(result);
    });
    test('icon + name right', () {
      final result = DrawFunctions.drawTop(
        levelAlignment: LevelAlignment.right,
        logLevel: const LogLevel(
          icon: '🚨',
          name: 'Teste',
        ),
      );

      eLog(result);
    });
    test('icon + name middle', () {
      final result = DrawFunctions.drawTop(
        logLevel: const LogLevel(
          icon: '🚨',
          name: 'Teste',
        ),
      );

      eLog(result);
    });

    test('medium', () {
      final result = DrawFunctions.drawMedium(isDashed: true);

      eLog(result);
    });

    test('bottom', () {
      final result = DrawFunctions.drawBottom();

      eLog(result);
    });
  });
}
