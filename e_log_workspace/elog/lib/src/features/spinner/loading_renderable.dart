import '../../core/contracts/elog_renderable.dart';
import 'spinner_renderable.dart';

/// Loader renderizável composto por:
/// - Spinner
/// - Texto principal
/// - Status opcional (ok, erro, warning, etc)
///
/// NÃO controla tempo
/// NÃO escreve no terminal
///
/// Apenas descreve a linha atual do loader.
class LoadingRenderable implements ELogRenderable {
  final SpinnerRenderable spinner;

  /// Texto principal do loading
  final String message;

  /// Status opcional exibido ao final
  ///
  /// Ex: ✔, ✖, ⚠, DONE
  final String? status;

  /// Separadores configuráveis
  final String messageSeparator;
  final String statusSeparator;

  const LoadingRenderable({
    required this.spinner,
    required this.message,
    this.status,
    this.messageSeparator = ' ',
    this.statusSeparator = ' ',
  });

  @override
  String render() {
    final buffer = StringBuffer();

    buffer.write(spinner.render());
    buffer.write(messageSeparator);
    buffer.write(message);

    if (status != null && status!.isNotEmpty) {
      buffer.write(statusSeparator);
      buffer.write(status);
    }

    return buffer.toString();
  }

  @override
  bool get isEmpty =>
      spinner.isEmpty && message.isEmpty && status?.isEmpty != false;
}
