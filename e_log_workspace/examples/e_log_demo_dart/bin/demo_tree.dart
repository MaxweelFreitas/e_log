import 'package:elog/elog.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║             ELOG - DEMONSTRAÇÃO DE ÁRVORES (TREE)            ║');
  print('╚══════════════════════════════════════════════════════════════╝');

  // ===========================================================================
  // DADOS DE EXEMPLO
  // ===========================================================================

  // 1. Estrutura Simples
  final simpleStructure = {
    'src': {
      'core': {'auth.dart': null, 'http.dart': null},
      'ui': {'widgets': null, 'pages': null},
    },
    'main.dart': null,
  };

  // 2. Estrutura Rica (Metadados)
  final richStructure = {
    'Project': 'SuperApp',
    'Version': '1.0.0',
    'Dependencies': {'flutter': 'sdk', 'elog': '^1.0.0', 'dio': '^5.0.0'},
    'Environment': {'OS': 'Ubuntu 22.04', 'Dart': '3.4.0'},
  };

  // 3. Estrutura de Status (Para temas semânticos)
  final statusStructure = {
    'System Check': {
      'Database': 'Online',
      'API Gateway': 'Connected',
      'Cache': 'Warm',
    },
    'Modules': {'Auth': 'Ready', 'Payment': 'Idle'},
  };

  // 4. Estrutura DevOps (Para temas Cloud/Vercel)
  final devOpsStructure = {
    'Deployment': {
      'Region': 'us-east-1',
      'Build ID': 'af34-9981',
      'Status': 'Deployed',
    },
    'Resources': {'CPU': '24%', 'Memory': '512MB'},
  };

  // ===========================================================================
  // 1. CLÁSSICOS & ESTRUTURAIS
  // ===========================================================================
  _printSection('1. ESTILOS CLÁSSICOS & ESTRUTURAIS');

  _demoStyle('Classic (Padrão)', TreePresets.classic, simpleStructure);
  _demoStyle('Rounded (Arredondado)', TreePresets.rounded, simpleStructure);
  _demoStyle('Heavy (Negrito)', TreePresets.heavy, simpleStructure);
  _demoStyle('Double (Retro)', TreePresets.double, simpleStructure);

  // ===========================================================================
  // 2. HÍBRIDOS & ESPECIAIS
  // ===========================================================================
  _printSection('2. HÍBRIDOS & ESPECIAIS');

  _demoStyle('ASCII (Compatibilidade)', TreePresets.ascii, simpleStructure);
  _demoStyle('Mixed (H:Duplo V:Simples)', TreePresets.mixed, simpleStructure);
  _demoStyle(
    'Light Double (H:Simples V:Duplo)',
    TreePresets.lightDouble,
    simpleStructure,
  );

  // ===========================================================================
  // 3. MINIMALISTAS (Clean)
  // ===========================================================================
  _printSection('3. MINIMALISTAS');

  _demoStyle('Clean (Sem guias)', TreePresets.clean, simpleStructure);
  _demoStyle('Dotted (Pontilhado)', TreePresets.dotted, simpleStructure);
  _demoStyle('Dashed (Tracejado)', TreePresets.dashed, simpleStructure);

  // ===========================================================================
  // 4. TEMAS SEMÂNTICOS (Status & Feedback)
  // ===========================================================================
  _printSection('4. TEMAS SEMÂNTICOS');

  _demoStyle('Success (Verde)', TreePresets.success, statusStructure);
  _demoStyle('Warning (Amarelo)', TreePresets.warning, statusStructure);
  _demoStyle('Error (Vermelho)', TreePresets.error, statusStructure);
  _demoStyle('Critical (Alerta)', TreePresets.critical, statusStructure);

  // ===========================================================================
  // 5. TEMAS ESTILIZADOS (Visual FX)
  // ===========================================================================
  _printSection('5. TEMAS ESTILIZADOS');

  _demoStyle('Matrix (Tech/Hacker)', TreePresets.matrix, richStructure);
  _demoStyle('Neon (Vibrante)', TreePresets.neon, richStructure);
  _demoStyle('Highlight (Marca-texto)', TreePresets.highlight, richStructure);
  _demoStyle('Amber (Monitor Antigo)', TreePresets.amber, richStructure);
  _demoStyle('Forest (Natureza)', TreePresets.forest, simpleStructure);

  // ===========================================================================
  // 6. TEMAS RGB / TRUECOLOR (IDE & System)
  // ===========================================================================
  _printSection('6. TEMAS RGB (TRUECOLOR)');
  print(
    '${XTermColor.brightBlack}Temas inspirados em IDEs e Sistemas Operacionais.${XTermColor.reset}\n',
  );

  _demoStyle('Dracula', TreePresets.dracula, richStructure);
  _demoStyle('Cyberpunk', TreePresets.cyberpunk, richStructure);
  _demoStyle('Meltdown', TreePresets.meltdown, statusStructure);
  _demoStyle('Yaru (Ubuntu)', TreePresets.yaru, richStructure);
  _demoStyle('Monokai', TreePresets.monokai, richStructure);
  _demoStyle('Oceanic', TreePresets.oceanic, richStructure);

  // Novos Adicionados
  _demoStyle('Cloud (Sky Blue)', TreePresets.cloud, devOpsStructure);
  _demoStyle('Vercel (Clean B&W)', TreePresets.vercel, devOpsStructure);
  _demoStyle('Solarized (Areia)', TreePresets.solarized, richStructure);
  _demoStyle('Candy (Pastel)', TreePresets.candy, richStructure);

  // ===========================================================================
  // 7. CASOS DE USO REAL (Combinando com BOXES)
  // ===========================================================================
  _printSection('7. CASOS DE USO REAL (COM BOXES)');

  // DADOS: File System com metadados
  final fileSystem = {
    '.vscode': {'settings.json': null},
    'bin': {'main.dart': '4kb'},
    'lib': {
      'src': {
        'features': {
          'auth': {'login.dart': null, 'register.dart': null},
        },
        'shared': {'styles.dart': null},
      },
    },
    'pubspec.yaml': 'v1.2.0',
    'README.md': 'Markdown',
  };

  // EXEMPLO A: VS CODE STYLE
  // Usando EBoxBuilder para o painel e ETreeBuilder para o conteúdo
  print(
    EBoxBuilder()
        .title(' PROJECT EXPLORER ', align: BoxTitleAlign.left)
        .style(BoxPresets.rounded) // Corrigido: BoxPresets
        .content(
          ETreeBuilder(fileSystem) // Builder da Tree
              .style(TreePresets.rounded)
              .rootLabel('FLUTTER-APP')
              .showRoot(true)
              .build(),
        )
        .build(),
  );

  print('');

  // EXEMPLO B: LINUX TERMINAL STYLE
  // Criando um estilo customizado baseado no ASCII
  final linuxStyle = TreePresets.ascii.copyWith(
    rootColor: XTermStyle.bold + XTermColor.green,
    keyColor: XTermColor.blue,
  );

  print(
    EBoxBuilder()
        .title(' bash: tree ', align: BoxTitleAlign.left)
        .style(BoxPresets.ascii) // Corrigido: BoxPresets
        .content(
          ETreeBuilder(
            fileSystem,
          ).style(linuxStyle).rootLabel('.').showRoot(true).build(),
        )
        .build(),
  );

  print('\n');
}

// --- Helpers ---

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}

void _demoStyle(String name, TreeStyle style, Map<String, dynamic> data) {
  print('${XTermStyle.bold}► $name:${XTermColor.reset}');
  print(
    ETreeBuilder(data).style(style).rootLabel('root').showRoot(true).build(),
  );
  print('');
}
