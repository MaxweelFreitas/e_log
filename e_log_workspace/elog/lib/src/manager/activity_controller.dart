import 'dart:async';
import 'dart:io';
import '../features/spinner/spinner_set.dart';
import '../features/spinner/style/spinner_presets.dart';

/// Controla interações dinâmicas no terminal (que precisam de update/rewrite).
class ActivityController {
  final void Function(String) _emit; // Output sink (ex: stdout.write)

  Timer? _timer;
  SpinnerSet _spinner = SpinnerPresets.dots;
  String _message = '';
  int _frameIndex = 0;
  bool _isActive = false;

  ActivityController({void Function(String)? emit})
      : _emit = emit ?? ((s) => stdout.write(s));

  /// Inicia um spinner indeterminado
  void startLoading(String message, {SpinnerSet? spinner}) {
    stop(); // Para anterior se houver
    _message = message;
    _spinner = spinner ?? SpinnerPresets.dots;
    _isActive = true;
    _frameIndex = 0;

    _timer = Timer.periodic(Duration(milliseconds: _spinner.intervalMs), (_) {
      _renderSpinner();
      _frameIndex++;
    });
  }

  void _renderSpinner() {
    if (!_isActive) return;
    final frame = _spinner.frames[_frameIndex % _spinner.frames.length];
    // \r volta pro inicio da linha para sobrescrever
    _emit('\r$frame $_message   ');
  }

  /// Finaliza com sucesso
  void success(String message) {
    stop();
    _emit('\r✔ $message\n');
  }

  /// Finaliza com erro
  void failure(String message) {
    stop();
    _emit('\r✖ $message\n');
  }

  /// Para o timer interno
  void stop() {
    _isActive = false;
    _timer?.cancel();
    _timer = null;
  }
}
