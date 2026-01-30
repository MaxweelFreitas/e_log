import 'spinner_set.dart';
import 'style/spinner_presets.dart';

/// Fábrica para resolver e instanciar Spinners.
class SpinnerFactory {
  const SpinnerFactory._();

  /// Resolve um input dinâmico para um SpinnerSet válido.
  ///
  /// - Se [input] for SpinnerSet: retorna ele mesmo.
  /// - Se [input] for String: busca nos Presets pelo nome.
  /// - Caso contrário: retorna o padrão (dots).
  static SpinnerSet resolve(dynamic input) {
    // 1. Se já for um objeto SpinnerSet, retorna direto
    if (input is SpinnerSet) {
      return input;
    }

    // 2. Se for string, tenta achar nos presets pelo nome (ex: "dots", "moon")
    if (input is String) {
      final preset = SpinnerPresets.byName(input);
      if (preset != null) return preset;
    }

    // 3. Fallback padrão
    return SpinnerPresets.dots;
  }
}
