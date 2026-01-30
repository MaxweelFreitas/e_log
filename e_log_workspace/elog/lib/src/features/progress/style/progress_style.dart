import '../../../utils/color_utils.dart';

/// Define o estilo visual de uma barra de progresso.
class ProgressStyle {
  final String filledChar;
  final String emptyChar;
  final String startBorder;
  final String endBorder;

  /// Caractere opcional para a "cabeça" da barra
  /// Ex: Se filled='=' e tip='>', fica [===>   ]
  final String? tip;

  /// Cor da parte preenchida (Ex: XTermColor.green)
  /// Se null, usará o padrão (Verde) ou Gradient se informado.
  final String? filledColor;

  /// Cor da parte vazia (Ex: XTermColor.brightBlack)
  final String? emptyColor;

  /// Cor das bordas
  final String? borderColor;

  final String? textStyle;

  final String? underlineColor;
  // --- NOVOS CAMPOS DE GRADIENTE ---
  final Rgb? gradientStart;
  final Rgb? gradientEnd;

  const ProgressStyle({
    required this.filledChar,
    required this.emptyChar,
    this.startBorder = '[',
    this.endBorder = ']',
    this.tip,
    this.filledColor,
    this.emptyColor,
    this.borderColor,
    this.textStyle,
    this.underlineColor,
    this.gradientStart,
    this.gradientEnd,
  });

  /// Estilo Clássico: [====      ]
  static const classic = ProgressStyle(
    filledChar: '=',
    emptyChar: ' ',
  );

  /// Estilo Bloco: [████░░░░░░]
  static const block = ProgressStyle(
    filledChar: '█',
    emptyChar: '░',
  );

  /// Estilo Clean: ▰▰▰▱▱▱▱
  static const clean = ProgressStyle(
    filledChar: '▰',
    emptyChar: '▱',
    startBorder: '',
    endBorder: '',
  );

  /// Estilo Minimal: ────🔘─────
  /// (Este requer lógica diferente, vamos focar nos de preenchimento primeiro)

  /// Estilo Hash: [#.........]
  static const hash = ProgressStyle(
    filledChar: '#',
    emptyChar: '.',
  );
}
