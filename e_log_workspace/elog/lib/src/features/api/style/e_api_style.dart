import '../../../base/x_term/x_term_color.dart';

class EApiStyle {
  final String borderColor;
  final String headerColor;
  final String treeStructureColor;
  final String keyColor;
  final String separatorColor; // <--- NOVO CAMPO
  final String valueColor;

  // Cores de Fundo Específicas
  final String backgroundColor;
  final String titleBackgroundColor;
  final String contentBackgroundColor;

  const EApiStyle({
    required this.borderColor,
    required this.headerColor,
    required this.treeStructureColor,
    required this.keyColor,
    required this.valueColor,
    this.separatorColor = XTermColor.white, // Default: Branco
    this.backgroundColor = '',
    this.titleBackgroundColor = '',
    this.contentBackgroundColor = '',
  });

  /// Tema Padrão: Azul no Título, Cinza Escuro no Conteúdo
  factory EApiStyle.standard() {
    return const EApiStyle(
      borderColor: XTermColor.blue,
      headerColor: XTermColor.brightWhite,
      treeStructureColor: XTermColor.brightCyan,
      keyColor: XTermColor.cyan,
      valueColor: XTermColor.white,

      // Configuração Filled:
      titleBackgroundColor: '\x1B[44m', // Fundo Azul
      contentBackgroundColor: '\x1B[100m', // Fundo Cinza Escuro
    );
  }

  /// Tema Erro: Vermelho no Título, Vermelho Escuro no Conteúdo
  factory EApiStyle.error() {
    return const EApiStyle(
      borderColor: XTermColor.red,
      headerColor: XTermColor.brightWhite,
      treeStructureColor: XTermColor.yellow,
      keyColor: XTermColor.yellow,
      // Separador Amarelo ou Branco para contraste no vermelho
      separatorColor: XTermColor.brightYellow,
      valueColor: XTermColor.white,

      // Configuração Filled:
      titleBackgroundColor: '\x1B[41m', // Fundo Vermelho
      contentBackgroundColor: '\x1B[48;5;52m', // Fundo Vermelho Vinho
    );
  }
}
