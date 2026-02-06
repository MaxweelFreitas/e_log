library;

import 'dart:async';
import 'dart:io';

// --- IMPORTS INTERNOS ---
import 'src/features/api/e_api_builder.dart';
import 'src/features/table/e_table_builder.dart';
import 'src/features/tree/e_tree_builder.dart';
import 'src/features/tree/style/tree_style.dart';
import 'src/features/wizard/e_wizard_builder.dart';
import 'src/manager/e_interactive.dart';
import 'src/features/log/elog_level.dart';
import 'src/features/wizard/steps/e_wizard_step.dart';
import 'src/features/wizard/style/e_wizard_style.dart';

// Retorno tipado
import 'src/features/spinner/spinner.dart';
import 'src/features/spinner/spinner_set.dart';
import 'src/features/progress/e_progress_builder.dart';
import 'src/features/progress/style/progress_style.dart';

import 'src/base/x_term/x_term_color.dart';
import 'src/utils/color_utils.dart';
import 'src/utils/terminal_utils.dart';
import 'src/features/box/e_box_builder.dart';

// Imports de Log e Block
import 'src/features/log/builder/e_log_builder.dart';
import 'src/features/block/e_block_builder.dart';
import 'src/features/chart/e_chart_builder.dart';

// =============================================================================
// EXPORTS PÚBLICOS
// =============================================================================

// 1. Core & Configuração
export 'src/features/log/elog_level.dart';
export 'src/features/log/config/elog_config.dart';
export 'src/utils/terminal_utils.dart';
export 'src/utils/color_utils.dart';

// 2. Builders
export 'src/features/api/e_api_builder.dart';
export 'src/features/box/e_box_builder.dart';
export 'src/features/log/builder/e_log_builder.dart';

// 3. Estilos
export 'src/base/x_term/x_term_color.dart';
export 'src/base/x_term/x_term_style.dart';
export 'src/shared/border_set.dart';
export 'src/shared/icon_set.dart';
export 'src/features/box/style/box_style.dart';
export 'src/features/box/style/box_presets.dart';
export 'src/features/api/style/e_api_presets.dart';
export 'src/features/api/style/e_api_style.dart';
export 'src/features/box/style/shadow_style.dart';

// 4. Wizard
export 'src/features/wizard/e_wizard_builder.dart';
export 'src/features/wizard/steps/future_step.dart';
export 'src/features/wizard/steps/info_steps.dart';
export 'src/features/wizard/steps/multi_select_step.dart';
export 'src/features/wizard/steps/select_step.dart';
export 'src/features/wizard/steps/input_text_step.dart';
export 'src/features/wizard/steps/message_step.dart';
export 'src/features/wizard/steps/toggle_step.dart';
export 'src/features/wizard/steps/e_wizard_step.dart';
export 'src/features/wizard/style/e_wizard_style.dart';
export 'src/features/wizard/style/step_presets.dart';
export 'src/features/wizard/style/e_wizard_presets.dart';

// 5. Interativos
export 'src/manager/e_interactive.dart';
export 'src/features/stepper/elog_step.dart';
export 'src/features/spinner/spinner.dart';
export 'src/features/spinner/spinner_set.dart';
export 'src/features/spinner/spinner_frame.dart';
export 'src/features/spinner/style/spinner_presets.dart';
export 'src/features/progress/e_progress_builder.dart';
export 'src/features/progress/style/progress_style.dart';
export 'src/features/progress/style/progress_presets.dart';

// 6. Tree
export 'src/features/tree/e_tree_builder.dart';
export 'src/features/tree/style/tree_style.dart';
export 'src/features/tree/style/tree_presets.dart';

// 7. Table
export 'src/features/table/e_table_builder.dart';
export 'src/features/table/style/table_style.dart';
export 'src/features/table/style/table_presets.dart';
export 'src/features/table/model/e_cell_text_align.dart';
export 'src/features/table/model/e_cell.dart';

// 8. Block
export 'src/features/block/e_block_builder.dart';
export 'src/features/block/style/block_presets.dart';
export 'src/features/block/style/block_style.dart';

// 9. Chart
export 'src/features/chart/e_chart_builder.dart';
export 'src/features/chart/style/chart_presets.dart';
export 'src/features/chart/style/chart_style.dart';

// 10. Log
export 'src/features/log/style/e_log_style.dart';
export 'src/features/log/style/e_log_presets.dart';

/// Fachada Principal
class Elog {
  Elog._();

  // --- SINGLETON INTERACTIVE ---
  // Usa stdout.write para suportar animações na mesma linha (\r)
  static final EInteractive _interactive =
      EInteractive(emit: (s) => stdout.write(s));

  // --- SEGURANÇA ---
  static void run(Future<void> Function() app) {
    runZonedGuarded(() async {
      try {
        await app();
      } catch (e) {
        throw _ElogCrash(e);
      }
    }, (error, stack) {
      Terminal.restore();
      stdout.writeln();
      stdout.writeln(
          '${XTermColor.bgRed}${XTermColor.white} ERRO FATAL ${XTermColor.reset}');
      if (error is _ElogCrash) {
        stdout.writeln(
            '${XTermColor.red}${error.originalError}${XTermColor.reset}');
      } else {
        stdout.writeln('${XTermColor.red}$error${XTermColor.reset}');
      }
      exit(1);
    });
  }

  // --- LOGS RÁPIDOS ---
  static void info(String message) {
    ELogBuilder().level(ELogLevel.info).message(message).print();
  }

  static void success(String message) {
    ELogBuilder().level(ELogLevel.success).message(message).print();
  }

  static void warn(String message) {
    ELogBuilder().level(ELogLevel.warning).message(message).print();
  }

  static void error(String message, {Object? error, StackTrace? stack}) {
    final builder = ELogBuilder().level(ELogLevel.error).message(message);
    if (error != null) builder.error(error, stack);
    builder.print();
  }

  // --- BUILDERS ---
  static ELogBuilder get log => ELogBuilder();

  static ELogBuilder box({String? title, String? message}) {
    final builder = ELogBuilder().layout(ELogLayout.boxed);
    if (title != null) builder.title(title);
    if (message != null) builder.message(message);
    return builder;
  }

  // --- COMPONENTES ---
  static EBoxBuilder get panel => EBoxBuilder();
  static EApiBuilder get api => EApiBuilder();
  static EChartBuilder get chart => EChartBuilder();
  static EBlockBuilder get block => EBlockBuilder();

  static ETreeBuilder tree(Map<String, dynamic> data, {TreeStyle? style}) {
    return ETreeBuilder(data, style: style);
  }

  static ETableBuilder table(List<dynamic> headers) {
    return ETableBuilder().headers(headers);
  }

  // --- WIZARD ---
  static EWizardBuilder wizard({
    required String title,
    required List<EWizardStep> steps,
    EWizardStyle? style,
  }) {
    return EWizardBuilder(title: title, steps: steps, style: style);
  }

  // --- INTERACTIVE ---

  static EInteractive get interactive => _interactive;

  static Spinner spinner({
    String text = 'Loading...',
    SpinnerSet? spinner,
  }) {
    return _interactive.spinner(text: text, spinner: spinner);
  }

  static ProgressBuilder progress({
    int total = 100,
    String label = 'Progress',
    ProgressStyle style = ProgressStyle.block,
    int? width,
    Rgb? startColor,
    Rgb? endColor,
    bool showPercentage = true,
  }) {
    return _interactive.progress(
      label: label,
      total: total,
      style: style,
      width: width,
      startColor: startColor,
      endColor: endColor,
      showPercentage: showPercentage,
    );
  }
}

class _ElogCrash {
  final Object originalError;
  _ElogCrash(this.originalError);
}

// --- EXTENSIONS VISUAIS ---
extension ETreeBuilderPrintExt on ETreeBuilder {
  void print() => stdout.writeln(build());
}

extension ETableBuilderPrintExt on ETableBuilder {
  void print() => stdout.writeln(build());
}

extension EBoxBuilderPrintExt on EBoxBuilder {
  void print() => stdout.writeln(build());
}
