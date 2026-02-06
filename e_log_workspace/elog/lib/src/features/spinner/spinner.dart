import 'dart:async';
import '../../base/x_term/x_term_color.dart';

/// Controlador do Spinner.
/// Gerencia o loop de animação, renderização e finalização.
class Spinner {
  // --- CONFIGURAÇÕES ---

  /// Texto atual do spinner (Privado para permitir mutabilidade via update).
  String _text;

  /// Função callback para escrever no terminal.
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

  // Construtor
  Spinner({
    required String text,
    required this.output,
    List<String>? frames,
    Duration? interval,
  })  : _text = text,
        frames = frames ?? dots,
        interval = interval ?? const Duration(milliseconds: 80);

  // ===========================================================================
  // LÓGICA DE CONTROLE
  // ===========================================================================

  /// Inicia a animação.
  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _frameIndex = 0;

    // Esconde o cursor para visual mais limpo
    output('\x1B[?25l');

    _render(); // Renderiza o primeiro frame imediatamente
    _timer = Timer.periodic(interval, (timer) {
      _frameIndex = (_frameIndex + 1) % frames.length;
      _render();
    });
  }

  /// Para a animação (interno).
  void stop() {
    _timer?.cancel();
    _isRunning = false;
    // Restaura o cursor
    output('\x1B[?25h');
  }

  /// Atualiza o texto do spinner em tempo real.
  void update(String newText) {
    _text = newText;
    // Força renderização imediata para feedback instantâneo
    if (_isRunning) _render();
  }

  // ===========================================================================
  // FINALIZAÇÃO
  // ===========================================================================

  /// Finaliza o spinner com um estado genérico (usado na Demo).
  void done({String? text, String? icon}) {
    stop();
    final finalText = text ?? _text;
    final finalIcon = icon ?? '${XTermColor.green}✔${XTermColor.reset}';

    // \r = Início da linha
    // \x1B[K = Limpa a linha inteira (remove o spinner anterior)
    output('\r\x1B[K$finalIcon $finalText\n');
  }

  /// Atalho para sucesso.
  void success([String? message]) {
    done(
      text: message,
      icon: '${XTermColor.green}✔${XTermColor.reset}',
    );
  }

  /// Atalho para falha.
  void fail([String? message]) {
    done(
      text: message,
      icon: '${XTermColor.red}✖${XTermColor.reset}',
    );
  }

  /// Atalho para aviso.
  void warning([String? message]) {
    done(
      text: message,
      icon: '${XTermColor.yellow}⚠${XTermColor.reset}',
    );
  }

  // ===========================================================================
  // RENDERIZAÇÃO
  // ===========================================================================

  void _render() {
    final frame = frames[_frameIndex];
    // \r       : Volta o cursor para o início da linha
    // \x1B[K   : Limpa a linha a partir do cursor (evita lixo de textos longos anteriores)
    output('\r${XTermColor.cyan}$frame${XTermColor.reset} $_text\x1B[K');
  }
}
