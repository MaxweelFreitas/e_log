import 'dart:async';
import 'dart:io';
import 'dart:convert';

class KeyResult {
  final KeyAction action;
  final String? char;

  const KeyResult(this.action, [this.char]);
}

enum KeyAction {
  up,
  down,
  left,
  right,
  space,
  enter,
  backspace,
  char,
  cancel,
  other,
  ignore
}

class InputReader {
  StreamSubscription<List<int>>? _subscription;
  final List<int> _buffer = [];
  Completer<void>? _dataAvailable;

  bool _isDisposed = false;

  void init() {
    _isDisposed = false;
    _buffer.clear();
    try {
      stdin.echoMode = false;
      stdin.lineMode = false;
    } on Exception catch (_) {}

    _subscription = stdin.listen((bytes) {
      if (_isDisposed) return;
      _buffer.addAll(bytes);
      if (_dataAvailable != null && !_dataAvailable!.isCompleted) {
        _dataAvailable!.complete();
      }
    });
  }

  /// Limpeza síncrona para não bloquear a saída
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;

    // Cancela a assinatura sem esperar o Future (Fire-and-forget)
    _subscription?.cancel();
    _subscription = null;

    // Tenta restaurar configurações do Dart
    try {
      if (!stdin.echoMode) stdin.echoMode = true;
      if (!stdin.lineMode) stdin.lineMode = true;
    } on Exception catch (_) {}
  }

  Future<KeyResult> readKey() async {
    if (_isDisposed) return const KeyResult(KeyAction.cancel);

    while (_buffer.isEmpty) {
      if (_isDisposed) return const KeyResult(KeyAction.cancel);
      _dataAvailable = Completer<void>();
      await _dataAvailable!.future;
    }

    int byte = _buffer.removeAt(0);

    // Ctrl+C (3), Ctrl+D (4), EOF (-1)
    if (byte == 3 || byte == 4 || byte == -1) {
      return const KeyResult(KeyAction.cancel);
    }

    if (byte == 10 || byte == 13) return const KeyResult(KeyAction.enter);
    if (byte == 127 || byte == 8) return const KeyResult(KeyAction.backspace);

    if (byte == 27) {
      if (_buffer.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 20));
      }
      if (_buffer.isNotEmpty && _buffer.first == 91) {
        _buffer.removeAt(0);
        if (_buffer.isNotEmpty) {
          final dir = _buffer.removeAt(0);
          if (dir == 65) return const KeyResult(KeyAction.up);
          if (dir == 66) return const KeyResult(KeyAction.down);
          if (dir == 67) return const KeyResult(KeyAction.right);
          if (dir == 68) return const KeyResult(KeyAction.left);
        }
      }
      return const KeyResult(KeyAction.ignore);
    }

    if (byte >= 32 && byte <= 126) {
      if (byte == 32) return const KeyResult(KeyAction.space, ' ');
      return KeyResult(KeyAction.char, String.fromCharCode(byte));
    }

    if (byte > 127) {
      if (_buffer.isEmpty) {
        await Future.delayed(const Duration(milliseconds: 5));
      }
      if (_buffer.isNotEmpty) {
        final next = _buffer.removeAt(0);
        try {
          return KeyResult(KeyAction.char, utf8.decode([byte, next]));
        } on Exception catch (_) {}
      }
      return const KeyResult(KeyAction.other);
    }

    return const KeyResult(KeyAction.other);
  }
}
