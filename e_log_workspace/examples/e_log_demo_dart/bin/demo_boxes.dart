import 'package:elog/elog.dart';
import 'package:elog/src/base/x_term/x_term_color.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║           ASCY - DEMONSTRAÇÃO COMPLETA DE BOXES              ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // ===========================================================================
  // 1. ESTILOS BÁSICOS
  // ===========================================================================
  _printSection('1. ESTILOS BÁSICOS');

  _printBox('Standard', 'Padrão simples.', BoxPresets.standard, shadow: true);
  _printBox(
    'Rounded',
    'Cantos arredondados.',
    BoxPresets.rounded,
    shadow: true,
  );
  _printBox('Heavy', 'Borda pesada.', BoxPresets.heavy, shadow: true);
  _printBox('Double', 'Estilo clássico DOS.', BoxPresets.double, shadow: true);
  _printBox(
    'Light Double',
    'Hibrido elegante.',
    BoxPresets.lightDouble,
    shadow: true,
  );

  // ===========================================================================
  // 2. RETRO & ASCII
  // ===========================================================================
  _printSection('2. RETRO & ASCII');

  _printBox('ASCII', 'Compatibilidade total.', BoxPresets.ascii);
  _printBox('Dotted', 'Linha pontilhada.', BoxPresets.dotted);
  _printBox('Dashed', 'Linha tracejada.', BoxPresets.dashed);
  _printBox('Mixed', 'Borda composta.', BoxPresets.mixed);

  // ===========================================================================
  // 3. SEMÂNTICOS
  // ===========================================================================
  _printSection('3. SEMÂNTICOS');

  _printBox('Success', 'Operação concluída.', BoxPresets.success);
  _printBox('Warning', 'Atenção necessária.', BoxPresets.warning);
  _printBox('Error', 'Falha crítica.', BoxPresets.error);
  _printBox('Info', 'Informações gerais.', BoxPresets.info);

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS
  // ===========================================================================
  _printSection('4. TEMAS ESTILIZADOS');

  _printBox('Matrix', 'Wake up, Neo... (Sombra 0)', BoxPresets.matrix);
  _printBox('Neon', 'Cyberpunk vibes. (Sombra Ciano)', BoxPresets.neon);
  _printBox('Fire', 'Critical Meltdown!', BoxPresets.fire);
  _printBox('Forest', 'Sustainable code.', BoxPresets.forest);
  _printBox('Amber', 'Retro Monitor 1980.', BoxPresets.amber);

  // ===========================================================================
  // 5. TEMAS RGB / TRUECOLOR
  // ===========================================================================
  _printSection('5. TEMAS RGB (TRUECOLOR)');

  _printBox('Dracula', 'Dark theme favorite.', BoxPresets.dracula);
  _printBox('Cyberpunk', 'High contrast neon.', BoxPresets.cyberpunk);
  _printBox('Yaru', 'Ubuntu Linux style.', BoxPresets.yaru);
  _printBox('Oceanic', 'Deep sea blue.', BoxPresets.oceanic);
  _printBox('Monokai', 'Code editor classic.', BoxPresets.monokai);
  _printBox('Vercel', 'Clean deployment.', BoxPresets.vercel);
  _printBox('Solarized', 'Easy on the eyes.', BoxPresets.solarized);
  _printBox('Candy', 'Sweet pink theme. (Sombra ♥)', BoxPresets.candy);

  // ===========================================================================
  // 6. UTILITÁRIOS & LAYOUT
  // ===========================================================================
  _printSection('6. UTILITÁRIOS & LAYOUT');

  // Teste de Alinhamento
  print(
    EBoxBuilder()
        .title('Centered Title', align: BoxTitleAlign.center)
        .content('Este título foi centralizado automaticamente.')
        .style(BoxPresets.rounded)
        .width(50)
        .padding(1)
        .build(),
  );
  print('');

  // Borderless
  print(
    EBoxBuilder()
        .content('    Borderless Box (Apenas Texto Indentado)')
        .style(BoxPresets.borderless)
        .build(),
  );
  print('');

  // Elevated
  print(
    EBoxBuilder()
        .content('Elevated Box (Sem borda, com sombra)')
        .style(BoxPresets.elevated)
        .build(),
  );

  // ===========================================================================
  // 7. SPECIAL & WIDTH TESTS
  // ===========================================================================
  _printSection('7. SPECIAL & WIDTH TESTS');

  // A. Sunset (O preset que faltava)
  _printBox('Sunset', 'Vertical gradient style.', BoxPresets.sunset);

  // B. Rainbow com MinWidth (Testando preenchimento do gradiente em espaço vazio)
  print(
    EBoxBuilder()
        .title('Rainbow Fill', borderLeft: ' ', borderRight: ' ')
        .content('Texto Curto') // Texto menor que a largura mínima
        .style(BoxPresets.rainbow)
        // .autoWidth()
        .build(),
  );
  print('');

  // C. Teste de Largura Fixa + Quebra de Linha + Sombra Custom
  print(
    EBoxBuilder()
        .title('Fixed Width')
        .content(
          'Este texto é longo propositalmente para testar se a caixa respeita a largura fixa de 45 colunas e quebra a linha corretamente sobre o fundo vermelho.',
        )
        .style(BoxPresets.heavy)
        // Sobrescrevendo estilo para testar composição
        .style(
          BoxPresets.heavy.copyWith(
            backgroundColor: XTermColor.bgRed,
            borderColor: XTermColor.white,
          ),
        )
        .width(45) // Largura fixa
        .shadow(const ShadowStyle(char: '▓', color: XTermColor.brightBlack))
        .build(),
  );

  print('\n🏁 Demo Finalizada\n');
}

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}

void _printBox(
  String title,
  String content,
  BoxStyle style, {
  bool shadow = false,
}) {
  final builder = EBoxBuilder().title(title).content(content).style(style);

  if (shadow) {
    builder.withShadow();
  }

  print(builder.build());
  print(''); // Espaço entre boxes
}
