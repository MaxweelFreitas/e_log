class AnsiState {
  final List<String> _stack = [];

  static final _ansiRegex = RegExp(r'\x1B\[[\d;]*m');

  void feed(String text) {
    for (final m in _ansiRegex.allMatches(text)) {
      final code = m.group(0)!;

      if (code == '\x1B[0m') {
        _stack.clear();
      } else {
        _stack.add(code);
      }
    }
  }

  String get current => _stack.join();

  void reset() => _stack.clear();
}
