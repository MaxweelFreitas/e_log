import 'dart:async';
import 'spinner_set.dart';

/// Controlador de estado para spinners.
///
/// Responsável apenas por:
/// - controlar frames
/// - controlar tempo
/// - expor frame atual (String)
class SpinnerController {
  final SpinnerSet spinner;

  /// Callback opcional chamado a cada tick (frame update)
  final void Function(String frame)? onTick;

  Timer? _timer;
  int _index = 0;
  bool _running = false;

  /// Construtor ajustado para receber SpinnerSet e onTick nomeados
  SpinnerController({
    required this.spinner,
    this.onTick,
  });

  /// Retorna o valor (String) do frame atual
  String get currentFrame =>
      spinner.frames[_index % spinner.frames.length].value;

  /// Indica se o spinner está ativo
  bool get isRunning => _running;

  /// Inicia o spinner
  void start() {
    if (_running) return;

    _running = true;

    // Emite o primeiro frame imediatamente
    _emitTick();

    _timer = Timer.periodic(Duration(milliseconds: spinner.intervalMs), (_) {
      _index++;
      _emitTick();
    });
  }

  void _emitTick() {
    onTick?.call(currentFrame);
  }

  /// Para o spinner
  void stop() {
    _timer?.cancel();
    _timer = null;
    _running = false;
    _index = 0;
  }

  /// Avança manualmente (modo síncrono / testes)
  void next() {
    _index++;
    _emitTick();
  }

  /// Reinicia o ciclo mantendo o estado ativo
  void reset() {
    _index = 0;
  }
}
