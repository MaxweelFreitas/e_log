import 'e_log_box.dart';

const Map<String, dynamic> elogApresentacaoJson = {
  'colunas': ['Recurso', 'Descrição'],
  'dados': [
    ['eLog', 'Biblioteca de logs ASCII customizáveis para terminal'],
    [
      'Estilos',
      'ascii, double, rounded, heavy, bold, clean, compact, markdown, entre outros'
    ],
    ['Formatos', 'Checklist, tabela, árvore, debug, hierarquia e mais'],
    ['Cores', 'Suporte a RGB e HEX com conversão para ANSI'],
    ['Exemplo', 'eLog.table(json, style: ELogBoxStyle.rounded)'],
    ['GitHub', 'github.com/seu_usuario/elog']
  ]
};

String buildTableFromJson({
  Map<String, dynamic> json = elogApresentacaoJson,
  EBoxStyle? style,
}) {
  final usedStyle = style ?? EBoxStyle.heavy;

  final colunas = List<String>.from(json['colunas']);
  final dados = List<List<dynamic>>.from(json['dados']);

  final larguras = List<int>.generate(colunas.length, (i) {
    return dados.map((linha) => linha[i].toString().length).fold(
        colunas[i].length,
        (anterior, atual) => anterior > atual ? anterior : atual);
  });

  String horizontalLine(String left, String middle, String right) {
    String line = left;
    for (int i = 0; i < larguras.length; i++) {
      line += usedStyle.horizontal * (larguras[i] + 2);
      if (i < larguras.length - 1) {
        line += middle;
      }
    }
    line += right;
    return line;
  }

  String buildLine(List<dynamic> valores) {
    return usedStyle.vertical +
        List.generate(valores.length, (i) {
          final valor = valores[i].toString();
          final padding = ' ' * (larguras[i] - valor.length);
          return ' $valor$padding ';
        }).join(usedStyle.vertical) +
        usedStyle.vertical;
  }

  final buffer = StringBuffer();
  buffer.writeln(horizontalLine(
      usedStyle.topLeft, usedStyle.middleTop, usedStyle.topRight));
  buffer.writeln(buildLine(colunas));
  buffer.writeln(horizontalLine(
      usedStyle.middleLeft, usedStyle.cross, usedStyle.middleRight));
  for (final linha in dados) {
    buffer.writeln(buildLine(linha));
  }
  buffer.writeln(horizontalLine(
      usedStyle.bottomLeft, usedStyle.middleBottom, usedStyle.bottomRight));

  return buffer.toString();
}

// Exemplo de uso:
void main() {
  final json = {
    'colunas': ['Produto', 'Quantidade', 'Preço'],
    'dados': [
      ['Maçã', 10, 'R\$ 5,00'],
      ['Banana', 8, 'R\$ 4,00']
    ]
  };

  // Usando o estilo ASCII (padrão)
  print(buildTableFromJson());

  // Alternativamente, usando um outro estilo, por exemplo, o "double"
  print(buildTableFromJson(json: json, style: EBoxStyle.ascii));
}

//TODO: Implementar a coloração personalizada
