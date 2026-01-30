// lib/src/utils/color_utils.dart

enum GradientDirection {
  vertical, // Top -> Bottom (Padrão)
  horizontal, // Left -> Right
  diagonal, // Top-Left -> Bottom-Right
  diagonalBack, // Bottom-Left -> Top-Right
}

/// Representa uma cor RGB para manipulação matemática.
class Rgb {
  final int r;
  final int g;
  final int b;

  const Rgb(this.r, this.g, this.b);

  factory Rgb.fromHex(int hex) {
    return Rgb((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF);
  }

  /// Retorna a string ANSI TrueColor.
  String toAnsi({bool isBackground = false}) {
    final type = isBackground ? '48' : '38';
    return '\x1b[$type;2;$r;$g;${b}m';
  }

  /// Interpola entre duas cores.
  /// [t] varia de 0.0 (start) a 1.0 (end).
  static Rgb interpolate(Rgb start, Rgb end, double t) {
    // Garante que t esteja entre 0 e 1
    final safeT = t.clamp(0.0, 1.0);

    return Rgb(
      (start.r + (end.r - start.r) * safeT).toInt(),
      (start.g + (end.g - start.g) * safeT).toInt(),
      (start.b + (end.b - start.b) * safeT).toInt(),
    );
  }
}

class ColorUtils {
  /// Gera lista linear (mantido para compatibilidade com Charts/Progress).
  static List<String> generateGradient(
    Rgb start,
    Rgb end,
    int steps, {
    bool isBackground = false,
  }) {
    if (steps <= 1) return [start.toAnsi(isBackground: isBackground)];

    final gradient = <String>[];
    for (var i = 0; i < steps; i++) {
      final t = i / (steps - 1);
      gradient.add(
          Rgb.interpolate(start, end, t).toAnsi(isBackground: isBackground));
    }
    return gradient;
  }
}
