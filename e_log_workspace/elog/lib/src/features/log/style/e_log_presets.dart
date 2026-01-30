import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import '../../box/style/shadow_style.dart'; // Import necessário para sombras
import 'e_log_style.dart';

/// Predefinições de estilo para ELog.
///
/// Contém estilos Estruturais (apenas bordas) e Temáticos (cores, bordas e sombras).
class ELogPresets {
  const ELogPresets._();

  // ===========================================================================
  // 1. ESTRUTURAIS (Cores definidas pelo ELogLevel)
  // ===========================================================================

  /// Padrão: Bordas arredondadas (╭─╮).
  static const ELogStyle rounded = ELogStyle(
    border: BorderSet.rounded,
  );

  /// Alias para [rounded].
  static const ELogStyle standard = rounded;

  /// Simples: Bordas finas retas (┌─┐).
  static const ELogStyle simple = ELogStyle(
    border: BorderSet.single,
  );

  /// Pesado: Bordas grossas (┏━┓). Ideal para erros fatais.
  static const ELogStyle heavy = ELogStyle(
    border: BorderSet.heavy,
    shadow: ShadowStyle.light, // Sombra leve para dar peso
  );

  /// Duplo: Bordas duplas (╔═╗). Visual clássico/retro.
  static const ELogStyle double = ELogStyle(
    border: BorderSet.double,
  );

  /// Híbrido: Horizontal duplo, Vertical simples (╒═╕).
  static const ELogStyle mixed = ELogStyle(
    border: BorderSet.mixed,
  );

  /// ASCII: Caracteres compatíveis (+=+). Para terminais antigos.
  static const ELogStyle ascii = ELogStyle(
    border: BorderSet.ascii,
    bracketColor: XTermColor.white,
  );

  // ===========================================================================
  // 2. MINIMALISTAS
  // ===========================================================================

  /// Clean: Sem bordas visíveis. Foca no conteúdo.
  static const ELogStyle clean = ELogStyle(
    border: BorderSet.none,
    bracketColor: XTermColor.blue,
  );

  /// Pontilhado: Bordas discretas (····).
  static const ELogStyle dotted = ELogStyle(
    border: BorderSet.dotted,
  );

  /// Tracejado: Bordas tracejadas (╌╌╌).
  static const ELogStyle dashed = ELogStyle(
    border: BorderSet.dashed,
  );

  // ===========================================================================
  // 3. TEMÁTICOS (Cores fixas que sobrescrevem o Level, exceto a mensagem)
  // ===========================================================================

  /// Matrix: Estilo Hacker (Verde Terminal).
  static const ELogStyle matrix = ELogStyle(
    border: BorderSet.ascii,
    borderColor: XTermColor.green,
    messageColor: XTermColor.brightGreen,
    labelColor: XTermColor.green,
    timestampColor: XTermColor.green,
    bracketColor: XTermColor.green,
  );

  /// Dracula: Tema escuro famoso (Roxo/Rosa/Ciano).
  static const ELogStyle dracula = ELogStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.magenta, // Roxo
    labelColor: XTermColor.brightCyan,
    timestampColor: XTermColor.cyan,
    bracketColor: XTermColor.brightMagenta,
    messageColor: XTermColor.white,
  );

  /// Cyberpunk: Alto contraste (Amarelo/Azul).
  static const ELogStyle cyberpunk = ELogStyle(
    border: BorderSet.heavy,
    borderColor: XTermColor.brightYellow,
    labelColor: XTermColor.brightBlue, // Fundo preto, texto azul
    timestampColor: XTermColor.yellow,
    bracketColor: XTermColor.brightYellow,
    shadow: ShadowStyle.solid, // Sombra sólida e forte
  );

  /// Monokai: Tema clássico de IDE (Amarelo/Verde/Laranja).
  static const ELogStyle monokai = ELogStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.brightYellow,
    labelColor: XTermColor.brightGreen,
    timestampColor: XTermColor.white,
  );

  /// Solarized: Tons terrosos e azulados.
  static const ELogStyle solarized = ELogStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.blue,
    labelColor: XTermColor.cyan,
    timestampColor: XTermColor.brightBlue,
    bracketColor: XTermColor.blue,
  );

  /// Neon: Cores vibrantes (Ciano brilhante).
  static const ELogStyle neon = ELogStyle(
    border: BorderSet.rounded,
    borderColor: XTermColor.brightCyan,
    labelColor: XTermColor.brightMagenta,
    timestampColor: XTermColor.brightCyan,
    bracketColor: XTermColor.cyan,
    shadow: ShadowStyle.light, // Sombra suave
  );

  /// Monochrome: Tudo escala de cinza (para logs em arquivo ou terminais p/b).
  static const ELogStyle monochrome = ELogStyle(
    border: BorderSet.ascii,
    borderColor: XTermColor.white,
    messageColor: XTermColor.white, // Força branco mesmo se for erro
    labelColor: XTermColor.white,
  );
}
