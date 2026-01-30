// Imports dos Controladores
import '../features/spinner/spinner.dart';
import '../features/spinner/spinner_set.dart'; // <--- Importante: Adicione este import
import '../features/progress/e_progress_builder.dart';
import '../features/progress/style/progress_style.dart';

// Imports do Stepper
import '../features/stepper/elog_step.dart';
import '../features/stepper/elog_stepper.dart';
import '../features/stepper/elog_stepper_renderer.dart';
import '../utils/color_utils.dart';

/// Definição da função de escrita (ex: stdout.write)
typedef ELogEmit = void Function(String output);

/// Gerenciador Interativo do Ascy.
class EInteractive {
  final ELogEmit emit;

  ELogStepper? _stepper;
  ELogStepperRenderer? _stepperRenderer;

  EInteractive({required this.emit});

  // ===========================================================================
  // SPINNER (Loading Indeterminado)
  // ===========================================================================

  /// Cria e inicia um Spinner.
  ///
  /// [text]: Texto exibido ao lado do spinner.
  /// [spinner]: (Opcional) Um preset de spinner (Ex: SpinnerPresets.dots).
  /// [frames]: (Opcional) Lista manual de frames (se [spinner] não for informado).
  /// [interval]: (Opcional) Intervalo manual (se [spinner] não for informado).
  Spinner spinner({
    String text = 'Loading...',
    SpinnerSet? spinner, // <--- NOVO PARÂMETRO
    List<String>? frames,
    Duration? interval,
  }) {
    List<String> actualFrames;
    Duration actualInterval;

    if (spinner != null) {
      // 1. Prioridade: Se passou um Preset (SpinnerSet)
      // Extraímos o texto de cada frame
      actualFrames = spinner.frames.map((f) => f.value).toList();
      // Convertemos o int (ms) para Duration
      actualInterval = Duration(milliseconds: spinner.intervalMs);
    } else {
      // 2. Fallback: Se passou frames manuais ou usa o padrão
      actualFrames = frames ?? ['.', '..', '...'];
      actualInterval = interval ?? const Duration(milliseconds: 100);
    }

    final spinnerController = Spinner(
      text: text,
      output: emit,
      frames: actualFrames,
      interval: actualInterval,
    );

    spinnerController.start();
    return spinnerController;
  }

  // ===========================================================================
  // PROGRESS BAR (Loading Determinado)
  // ===========================================================================

  /// Cria e inicia uma Barra de Progresso.
  ProgressBuilder progress({
    String label = 'Progress',
    int total = 100,
    ProgressStyle style = ProgressStyle.block,
    int? width, // Novo: Forçar largura ou null para auto
    Rgb? startColor, // Novo
    Rgb? endColor,
  }) {
    final progressController = ProgressBuilder(
      label: label,
      total: total,
      style: style,
      output: emit,
      width: width,
      gradientStart: startColor,
      gradientEnd: endColor,
    );

    emit(progressController.render());

    return progressController;
  }

  // ===========================================================================
  // STEPPER (Passo a Passo)
  // ===========================================================================

  /// Inicia uma lista de passos (Stepper).
  EInteractive stepper(List<ELogStep> steps, {ELogStepperRenderer? renderer}) {
    _stepper = ELogStepper(steps);
    _stepperRenderer = renderer ?? ELogStepperRenderer();

    _renderStepper();
    return this;
  }

  /// Avança para o próximo passo.
  EInteractive nextStep() {
    if (_stepper == null) return this;

    _stepper!.next();
    _renderStepper();
    return this;
  }

  /// Marca o passo atual como falha.
  EInteractive failStep() {
    if (_stepper == null) return this;

    _stepper!.failCurrent();
    _renderStepper();
    return this;
  }

  /// Reinicia todos os passos para 'pendente'.
  EInteractive resetStepper() {
    if (_stepper == null) return this;

    _stepper!.reset();
    _renderStepper();
    return this;
  }

  void _renderStepper() {
    if (_stepper == null || _stepperRenderer == null) return;

    final lines = _stepperRenderer!.render(_stepper!.steps);
    for (final line in lines) {
      emit(line);
    }
  }
}
