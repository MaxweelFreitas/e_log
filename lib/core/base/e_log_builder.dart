import 'e_log.dart';
import 'x_term/x_term_color.dart';
import 'x_term/x_term_style.dart';

class ELogBuilder {
  final StringBuffer _buffer = StringBuffer();
  final String prefix;
  final String suffix;
  final bool autoReset;
  final Map<String, String> _presets = {};
  final Map<String, String> _placeholders;

  ELogBuilder(
      {this.prefix = '',
      this.suffix = '',
      this.autoReset = true,
      Map<String, String>? placeholders})
      : _placeholders = placeholders ?? {};

  /// Adiciona texto ao buffer
  ELogBuilder add(String text) {
    _buffer.write(_replacePlaceholders(text));
    return this;
  }

  /// Adiciona texto formatado com cor e estilo
  ELogBuilder addFormatted(String text, {String? color, String? style}) {
    final formattedText =
        '${color ?? ''}${style ?? ''}${_replacePlaceholders(text)}${autoReset ? XTermColor.reset : ''}';
    _buffer.write(formattedText);
    return this;
  }

  /// Adiciona uma nova linha
  ELogBuilder addLine([String text = '']) {
    _buffer.writeln(_replacePlaceholders(text));
    return this;
  }

  /// Adiciona múltiplos textos formatados
  ELogBuilder addMultiple(List<Map<String, String>> texts) {
    for (var item in texts) {
      addFormatted(item['text'] ?? '',
          color: item['color'], style: item['style']);
    }
    return this;
  }

  /// Define um preset de formatação reutilizável
  void setPreset(String name, String color, [String? style]) {
    _presets[name] = '$color${style ?? ''}';
  }

  /// Aplica um preset de formatação
  ELogBuilder addPreset(String name, String text) {
    final format = _presets[name] ?? '';
    return addFormatted(text, color: format);
  }

  /// Substitui placeholders `{chave}` pelo valor correspondente
  String _replacePlaceholders(String input) {
    String result = input;
    _placeholders.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }

  @override
  String toString() {
    return '$prefix$_buffer$suffix';
  }

  void clear() {
    _buffer.clear();
  }

  /// Método estático para uso rápido
  static String log(String message, {String? color, String? style}) {
    return '${color ?? ''}${style ?? ''}$message${XTermColor.reset}';
  }
}

void main() {
  final builder = ELogBuilder(
    prefix: XTermColor.red,
    suffix: XTermColor.reset,
    placeholders: {'usuario': 'João', 'acao': 'logado no sistema'},
  );

  // Definir presets de estilo para facilitar
  builder.setPreset('alerta', XTermColor.yellow, XTermStyle.bold);
  builder.setPreset('sucesso', XTermColor.green, XTermStyle.underlined);
  builder.setPreset('bold', XTermColor.green, XTermStyle.bold);
  builder.setPreset('inverse', XTermColor.white, XTermStyle.inverse);
  builder.setPreset('faint', XTermColor.white, XTermStyle.faint);
  builder.setPreset(
      'strikethrough', XTermColor.white, XTermStyle.strikethrough);

  builder
      .add('Bem-vindo, {usuario}! ')
      .addFormatted('{acao}', color: XTermColor.blue)
      .addLine()
      .addPreset('alerta', 'Atenção! Isso é um alerta.')
      .addLine()
      .addPreset('sucesso', 'Operação concluída com sucesso!')
      .addLine()
      .addPreset('bold', 'texto Bold!')
      .addLine()
      .addPreset('inverse', 'texto inverse!')
      .addLine()
      .addPreset('faint', 'texto faint!')
      .addLine()
      .addPreset('strikethrough', 'texto strikethrough!');

  eLog('$builder\n');

  // Uso do método estático para logs rápidos
  eLog(
    ELogBuilder.log('Log!', color: XTermColor.green, style: XTermStyle.bold),
  );
}
