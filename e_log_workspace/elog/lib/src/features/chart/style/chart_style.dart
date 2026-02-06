import '../../../base/x_term/x_term_color.dart';
import '../../../utils/color_utils.dart';

enum ChartOrientation { horizontal, vertical }

/// Define o estilo visual de um gráfico de barras.
class ChartStyle {
  /// Caractere usado para desenhar a barra. Ex: '█', '━', '#'
  final String barChar;

  /// Caractere usado para o fundo da barra (parte vazia). Ex: '░', ' '
  final String emptyChar;

  /// Cor padrão da barra (se não houver gradiente).
  final String barColor;

  /// Cor do texto do rótulo (Label).
  final String labelColor;

  /// Cor do valor numérico exibido.
  final String valueColor;

  /// Cor do caractere vazio (o fundo da barra).
  final String emptyColor;

  /// Se deve exibir o valor numérico ao lado da barra.
  final bool showValue;

  /// Largura máx (para Horizontal) ou Altura fixa (para Vertical).
  final int? size;

  /// Largura fixa da coluna (apenas Vertical).
  /// Se null, ajusta-se ao tamanho do Label.
  final int? columnWidth;

  /// Espaço entre barras/colunas.
  final int itemGap;

  // --- NOVOS CAMPOS PARA GRADIENTE NATIVO ---
  final Rgb? gradientStart;
  final Rgb? gradientEnd;

  const ChartStyle({
    this.barChar = '█',
    this.emptyChar = '', // Padrão vazio para ficar limpo
    this.barColor = XTermColor.green,
    this.labelColor = XTermColor.reset,
    this.valueColor = XTermColor.brightWhite,
    // Define o padrão como cinza escuro (comportamento anterior)
    this.emptyColor = XTermColor.brightBlack,
    this.showValue = true,
    this.size,
    this.columnWidth,
    this.itemGap = 2,
    this.gradientStart,
    this.gradientEnd,
  });

  /// Cria uma cópia deste estilo com os campos alterados.
  ChartStyle copyWith({
    String? barChar,
    String? emptyChar,
    String? barColor,
    String? labelColor,
    String? valueColor,
    String? emptyColor,
    bool? showValue,
    int? size,
    int? columnWidth,
    int? itemGap,
    Rgb? gradientStart,
    Rgb? gradientEnd,
  }) {
    return ChartStyle(
      barChar: barChar ?? this.barChar,
      emptyChar: emptyChar ?? this.emptyChar,
      barColor: barColor ?? this.barColor,
      labelColor: labelColor ?? this.labelColor,
      valueColor: valueColor ?? this.valueColor,
      emptyColor: emptyColor ?? this.emptyColor,
      showValue: showValue ?? this.showValue,
      size: size ?? this.size,
      columnWidth: columnWidth ?? this.columnWidth,
      itemGap: itemGap ?? this.itemGap,
      gradientStart: gradientStart ?? this.gradientStart,
      gradientEnd: gradientEnd ?? this.gradientEnd,
    );
  }
}
