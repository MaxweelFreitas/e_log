import 'dart:convert';

/// Utilitário para renderização elegante de JSON.
///
/// - Stateless
/// - Sem dependência de logs ou terminal
/// - Seguro para qualquer `dynamic`
final class ElegantJson {
  const ElegantJson._();

  /// Converte qualquer valor em JSON formatado.
  ///
  /// Se o valor não for serializável, faz fallback para `toString()`.
  static String stringify(
    dynamic value, {
    int indent = 2,
    bool sortKeys = true,
  }) {
    try {
      final normalized = _normalize(value, sortKeys: sortKeys);
      final encoder = JsonEncoder.withIndent(' ' * indent);
      return encoder.convert(normalized);
    } on Exception catch (_) {
      return value?.toString() ?? 'null';
    }
  }

  /// Normaliza estruturas recursivamente.
  static dynamic _normalize(dynamic value, {required bool sortKeys}) {
    if (value is Map) {
      final entries = value.entries.map((e) {
        return MapEntry(
          e.key.toString(),
          _normalize(e.value, sortKeys: sortKeys),
        );
      });

      final map = Map<String, dynamic>.fromEntries(entries);

      if (!sortKeys) return map;

      final sortedKeys = map.keys.toList()..sort();
      return {for (final key in sortedKeys) key: map[key]};
    }

    if (value is Iterable) {
      return value.map((e) => _normalize(e, sortKeys: sortKeys)).toList();
    }

    // Valores primitivos ou desconhecidos
    if (_isJsonSafe(value)) {
      return value;
    }

    return value.toString();
  }

  static bool _isJsonSafe(dynamic value) {
    return value == null || value is num || value is bool || value is String;
  }
}
