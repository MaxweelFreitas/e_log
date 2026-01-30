class StringUtils {
  static final _ansiRegex = RegExp(r'\x1B\[[\d;]*m');

  /// Remove códigos ANSI da string.
  static String stripAnsi(String text) => text.replaceAll(_ansiRegex, '');

  /// Retorna a largura visual da string no terminal.
  /// Considera Emojis e CJK como largura 2.
  static int visualLength(String text) {
    final clean = stripAnsi(text);
    int width = 0;
    for (final rune in clean.runes) {
      width += _charWidth(rune);
    }
    return width;
  }

  /// Trunca o texto para caber na largura visual máxima, preservando ANSI.
  /// Adiciona "..." se necessário (opcional, mas o padrão aqui é corte seco).
  static String truncate(String text, int maxWidth) {
    if (visualLength(text) <= maxWidth) return text;

    // Iteramos manualmente para preservar ANSI e contar largura visual
    _ansiRegex.allMatches(text);

    // Mapa de posições ANSI para pularmos durante a iteração manual se quiséssemos,
    // mas uma abordagem de tokenização é mais segura.
    // Vamos usar uma abordagem híbrida simples: Strip para calcular, mas precisamos do índice raw.

    // Abordagem Robusta: Iterar caractere por caractere (runes) e detectar ANSI
    // Como detectar ANSI via Runes é chato, vamos simplificar:
    // O método findRawIndex já fazia isso bem, vamos atualizá-lo para suportar Wide Chars.

    final cutIndex = _findRawIndex(text, maxWidth);
    return '${text.substring(0, cutIndex)}\x1B[0m'; // Adiciona reset por segurança
  }

  /// Encontra o índice na string original (raw) que corresponde à largura visual desejada.
  static int _findRawIndex(String text, int targetVisualWidth) {
    int vCount = 0;
    final units = text.codeUnits;

    for (int i = 0; i < units.length; i++) {
      // Detecção de início de ANSI ESC (27)
      if (units[i] == 27) {
        int end = i;
        // Avança até encontrar o fim do comando ANSI 'm' (109)
        // Nota: Isso é uma heurística simples para ANSI colors comuns.
        while (end < units.length && units[end] != 109) {
          end++;
        }
        if (end < units.length) {
          i = end; // Pula todo o bloco ANSI
          continue;
        }
      }

      // Aqui precisamos lidar com Runes para saber se é WideChar.
      // Como estamos iterando codeUnits (UTF-16), emojis são pares de surrogate.
      // Vamos pegar o rune completo neste ponto.
      int charCode = units[i];
      int charLen = 1;

      // Se for um high surrogate, precisamos do próximo para formar o rune
      if (i + 1 < units.length && (charCode & 0xFC00) == 0xD800) {
        final next = units[i + 1];
        if ((next & 0xFC00) == 0xDC00) {
          charCode = 0x10000 + ((charCode & 0x3FF) << 10) + (next & 0x3FF);
          charLen = 2;
        }
      }

      final w = _charWidth(charCode);

      // Se adicionar esse caractere passar do limite, paramos aqui
      if (vCount + w > targetVisualWidth) {
        return i;
      }

      vCount += w;

      if (charLen == 2) i++; // Pula o segundo code unit do surrogate pair
    }

    return text.length;
  }

  /// Adiciona espaços à direita até atingir a largura visual desejada.
  static String padRight(String text, int width) {
    final vLen = visualLength(text);
    if (vLen >= width) return text;
    return text + (' ' * (width - vLen));
  }

  /// Quebra o texto em linhas respeitando a largura visual.
  static List<String> wrap(String text, {required int width}) {
    if (text.isEmpty) return [];

    // Se tiver quebras de linha explícitas, respeita elas
    if (text.contains('\n')) {
      return text.split('\n').expand((l) => wrap(l, width: width)).toList();
    }

    if (visualLength(text) <= width) return [text];

    final lines = <String>[];
    String remaining = text;

    while (remaining.isNotEmpty) {
      // Se o que sobrou cabe, adiciona e termina
      if (visualLength(remaining) <= width) {
        lines.add(remaining);
        break;
      }

      // Encontra onde cortar
      int cutIdx = _findRawIndex(remaining, width);

      // Proteção contra loop infinito se a largura for menor que 1 caractere largo
      if (cutIdx == 0 && remaining.isNotEmpty) {
        // Avança pelo menos 1 rune para não travar
        final firstRune = remaining.runes.first;
        cutIdx = (firstRune > 0xFFFF) ? 2 : 1;
      }

      lines.add(remaining.substring(0, cutIdx));
      remaining = remaining.substring(cutIdx);
    }
    return lines;
  }

  /// Determina se o caractere ocupa 2 espaços (Wide) ou 1 (Narrow).
  static int _charWidth(int rune) {
    // Remove caracteres nulos ou de controle de largura zero (opcional)
    if (rune == 0) return 0;

    // Faixas Unicode Largas (Heurística)
    if ((rune >= 0x1F300 && rune <= 0x1F9FF) || // Emojis modernos
            (rune >= 0x2600 && rune <= 0x27BF) || // Símbolos (Dingbats)
            (rune >= 0x2300 && rune <= 0x23FF) || // Símbolos Técnicos
            (rune >= 0x4E00 &&
                rune <= 0x9FFF) || // CJK Unificado (Chinês/Japonês)
            (rune >= 0xFF00 && rune <= 0xFFEF) // Fullwidth ASCII
        ) {
      return 2;
    }
    return 1;
  }
}
