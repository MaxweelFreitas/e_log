// IMPORTANTE: Mude o import de spinner.dart para spinner_set.dart
import 'spinner_set.dart';
import 'spinner_controller.dart';
import 'spinner_factory.dart';
import 'spinner_renderer.dart';

/// Representa um loading animado declarativo
///
/// Ex:
/// final loading = ELogLoading(
///   message: 'Carregando dados',
/// );
class ELogLoading {
  // CORREÇÃO: O tipo aqui deve ser SpinnerSet, não Spinner
  final SpinnerSet spinner;

  final String message;
  final bool overwrite;

  SpinnerController? _controller;
  SpinnerRenderer? _renderer;

  ELogLoading({dynamic spinner, required this.message, this.overwrite = true})
      // A Factory retorna um SpinnerSet, agora os tipos batem.
      : spinner = SpinnerFactory.resolve(spinner);

  /// Inicia o loading
  void start(void Function(String output) emit) {
    _renderer = SpinnerRenderer(
      overwrite: overwrite,
      suffix: ' $message', // O renderer cuida do espaço e texto
    );

    _controller = SpinnerController(
      spinner: spinner, // O Controller espera SpinnerSet, agora bate.
      onTick: (frame) {
        // frame já é uma String aqui, vindo do controller
        final output = _renderer!.render(frame);
        emit(output);
      },
    );

    _controller!.start();
  }

  /// Finaliza com sucesso
  void success(void Function(String output) emit, {String? message}) {
    _controller?.stop();
    final out = _renderer?.finish(finalText: message ?? '✔ ${this.message}');
    if (out != null) emit(out);
  }

  /// Finaliza com erro
  void error(void Function(String output) emit, {String? message}) {
    _controller?.stop();
    final out = _renderer?.finish(finalText: message ?? '✖ ${this.message}');
    if (out != null) emit(out);
  }

  /// Cancela silenciosamente
  void stop() {
    _controller?.stop();
  }
}
