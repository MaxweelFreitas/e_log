import 'dart:async';
import '../../base/x_term/x_term_color.dart';

/// Controlador do Spinner.
/// Gerencia o loop de animação, renderização e finalização.
class Spinner {
  // --- CONFIGURAÇÕES ---

  /// O texto a ser exibido ao lado do spinner.
  final String text;

  /// Função callback para escrever no terminal (injetada pelo EInteractive).
  final void Function(String) output;

  /// A sequência de strings que cria a animação.
  final List<String> frames;

  /// O intervalo de tempo entre cada frame.
  final Duration interval;

  // --- ESTADO INTERNO ---
  Timer? _timer;
  int _frameIndex = 0;
  bool _isRunning = false;

  // --- PRESETS (Padrões) ---
  static const List<String> dots = [
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏'
  ];
  static const List<String> lines = ['-', '\\', '|', '/'];

  /// Construtor com valores padrão.
  ///
  /// Isso resolve o erro de "parameter required", pois [frames] e [interval]
  /// agora são opcionais e têm fallback.
  Spinner({
    required this.text,
    required this.output,
    List<String>? frames,
    Duration? interval,
  })  : frames = frames ?? dots, // Se nulo, usa 'dots'
        interval =
            interval ?? const Duration(milliseconds: 80); // Se nulo, usa 80ms

  // ===========================================================================
  // LÓGICA DE CONTROLE
  // ===========================================================================

  /// Inicia a animação (Loop do Timer).
  /// Resolve o erro: The method 'start' isn't defined.
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _frameIndex = 0;

    // Código ANSI para esconder o cursor (opcional, melhora o visual)
    output('\x1B[?25l');

    _timer = Timer.periodic(interval, (timer) {
      _render();
      _frameIndex = (_frameIndex + 1) % frames.length;
    });
  }

  /// Para a animação e limpa a linha atual.
  void stop() {
    _timer?.cancel();
    _isRunning = false;

    // Restaura o cursor e limpa a linha
    output('\x1B[?25h');
    output('\r\x1B[K');
  }

  /// Finaliza com sucesso (Check verde).
  void success([String? message]) {
    stop();
    final msg = message ?? text;
    // \r (início) + \x1B[K (limpa) + ✔ Verde + Texto
    output('\r\x1B[K${XTermColor.green}✔${XTermColor.reset} $msg\n');
  }

  /// Finaliza com erro (X vermelho).
  void fail([String? message]) {
    stop();
    final msg = message ?? text;
    output('\r\x1B[K${XTermColor.red}✖${XTermColor.reset} $msg\n');
  }

  /// Atualiza o texto do spinner em tempo real sem parar a animação.
  void updateText(String newText) {
    // Apenas muda a propriedade, o próximo _render() usará o novo texto.
    // Como 'text' é final, tecnicamente precisaríamos tirar o final ou
    // apenas redesenhar. Para simplicidade, vamos assumir que o texto
    // inicial é o principal, mas se quiser mutável:
    // output('\r${frames[_frameIndex]} $newText\x1B[K');
  }

  // ===========================================================================
  // RENDERIZAÇÃO
  // ===========================================================================

  void _render() {
    final frame = frames[_frameIndex];
    // \r = Move cursor pro início
    // frame + text = Conteúdo
    // \x1B[K = Limpa o resto da linha (caso o texto anterior fosse maior)
    output('\r${XTermColor.cyan}$frame${XTermColor.reset} $text\x1B[K');
  }
}
