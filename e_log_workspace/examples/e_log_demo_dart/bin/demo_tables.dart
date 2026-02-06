import '../../../elog/lib/elog.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║            ELOG - DEMONSTRAÇÃO DE TABELAS (TABLES)           ║');
  print('╚══════════════════════════════════════════════════════════════╝');

  // ===========================================================================
  // DADOS DE EXEMPLO
  // ===========================================================================

  // Dataset 1: Genérico (Funcionários)
  final headersTeam = ['ID', 'Nome', 'Cargo'];
  final rowsTeam = [
    ['001', 'Alice Silva', 'Dev Flutter'],
    ['002', 'Bob Santos', 'Backend'],
    ['003', 'Carol Lima', 'Designer'],
  ];

  // Dataset 2: Status (Para temas Semânticos)
  final headersStatus = ['Módulo', 'Verificação', 'Resultado'];
  final rowsStatus = [
    ['Database', 'Conexão', 'OK'],
    ['Cache', 'Latência', '12ms'],
    ['Auth', 'Token', 'Válido'],
  ];

  // Dataset 3: Tech/Server (Para temas RGB)
  final headersServer = ['Servidor', 'IP', 'Status', 'Load'];
  final rowsServer = [
    ['AWS-East', '192.168.1.10', 'ONLINE', '45%'],
    ['Azure-Br', '10.0.0.5', 'MAINTENANCE', '0%'],
    ['GCP-West', '172.16.0.1', 'ONLINE', '82%'],
  ];

  // ===========================================================================
  // 1. ESTILOS ESTRUTURAIS & CLÁSSICOS
  // ===========================================================================
  _printSection('1. ESTILOS ESTRUTURAIS (Bordas)');

  _printTable('Classic (Padrão)', TablePresets.classic, headersTeam, rowsTeam);
  _printTable(
    'Rounded (Arredondado)',
    TablePresets.rounded,
    headersTeam,
    rowsTeam,
  );
  _printTable('Heavy (Negrito)', TablePresets.heavy, headersTeam, rowsTeam);
  _printTable('Double (Retro/DOS)', TablePresets.double, headersTeam, rowsTeam);
  _printTable(
    'ASCII (Compatibilidade)',
    TablePresets.ascii,
    headersTeam,
    rowsTeam,
  );
  _printTable('Minimal (Limpo)', TablePresets.minimal, headersTeam, rowsTeam);

  // ===========================================================================
  // 2. TEMAS SEMÂNTICOS (SOLID vs OUTLINE)
  // ===========================================================================
  _printSection('2. TEMAS SEMÂNTICOS (SOLID vs OUTLINE)');

  // Success
  _printTable(
    'Success (Sólido)',
    TablePresets.success,
    headersStatus,
    rowsStatus,
  );
  _printTable(
    'Success (Outline)',
    TablePresets.successOutline,
    headersStatus,
    rowsStatus,
  );

  // Warning
  _printTable(
    'Warning (Sólido)',
    TablePresets.warning,
    headersStatus,
    rowsStatus,
  );
  _printTable(
    'Warning (Outline)',
    TablePresets.warningOutline,
    headersStatus,
    rowsStatus,
  );

  // Error
  _printTable('Error (Sólido)', TablePresets.error, headersStatus, rowsStatus);
  _printTable(
    'Error (Outline)',
    TablePresets.errorOutline,
    headersStatus,
    rowsStatus,
  );

  // ===========================================================================
  // 3. TEMAS ESTILIZADOS (SOLID vs OUTLINE)
  // ===========================================================================
  _printSection('3. TEMAS ESTILIZADOS');

  // Matrix
  _printTable(
    'Matrix (Sólido - Background)',
    TablePresets.matrix,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Matrix (Outline - Bordas)',
    TablePresets.matrixOutline,
    headersServer,
    rowsServer,
  );

  // Neon
  _printTable('Neon (Sólido)', TablePresets.neon, headersServer, rowsServer);
  _printTable(
    'Neon (Outline)',
    TablePresets.neonOutline,
    headersServer,
    rowsServer,
  );

  // Fire
  _printTable('Fire (Sólido)', TablePresets.fire, headersServer, rowsServer);
  _printTable(
    'Fire (Outline)',
    TablePresets.fireOutline,
    headersServer,
    rowsServer,
  );

  // Forest
  _printTable('Forest (Sólido)', TablePresets.forest, headersTeam, rowsTeam);
  _printTable(
    'Forest (Outline)',
    TablePresets.forestOutline,
    headersTeam,
    rowsTeam,
  );

  // Amber
  _printTable('Amber (Sólido)', TablePresets.amber, headersServer, rowsServer);
  _printTable(
    'Amber (Outline)',
    TablePresets.amberOutline,
    headersServer,
    rowsServer,
  );

  // ===========================================================================
  // 4. TEMAS RGB / TRUECOLOR (COMPARATIVO COMPLETO)
  // ===========================================================================
  _printSection('4. TEMAS RGB (TRUECOLOR)');
  print(
    '${XTermColor.brightBlack}Comparando versões Imersivas (Solid) com Leves (Outline).${XTermColor.reset}\n',
  );

  // Dracula
  _printTable(
    'Dracula (Sólido)',
    TablePresets.dracula,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Dracula (Outline)',
    TablePresets.draculaOutline,
    headersServer,
    rowsServer,
  );

  // Cyberpunk
  _printTable(
    'Cyberpunk (Sólido)',
    TablePresets.cyberpunk,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Cyberpunk (Outline)',
    TablePresets.cyberpunkOutline,
    headersServer,
    rowsServer,
  );

  // Yaru
  _printTable('Yaru (Sólido)', TablePresets.yaru, headersServer, rowsServer);
  _printTable(
    'Yaru (Outline)',
    TablePresets.yaruOutline,
    headersServer,
    rowsServer,
  );

  // Oceanic
  _printTable(
    'Oceanic (Sólido)',
    TablePresets.oceanic,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Oceanic (Outline)',
    TablePresets.oceanicOutline,
    headersServer,
    rowsServer,
  );

  // Monokai
  _printTable(
    'Monokai (Sólido)',
    TablePresets.monokai,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Monokai (Outline)',
    TablePresets.monokaiOutline,
    headersServer,
    rowsServer,
  );

  // Vercel
  _printTable(
    'Vercel (Sólido)',
    TablePresets.vercel,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Vercel (Outline)',
    TablePresets.vercelOutline,
    headersServer,
    rowsServer,
  );

  // Solarized (Adicionado Outline)
  _printTable(
    'Solarized (Sólido)',
    TablePresets.solarized,
    headersServer,
    rowsServer,
  );
  _printTable(
    'Solarized (Outline)',
    TablePresets.solarizedOutline,
    headersServer,
    rowsServer,
  );

  // Candy (Adicionado Outline)
  _printTable('Candy (Sólido)', TablePresets.candy, headersServer, rowsServer);
  _printTable(
    'Candy (Outline)',
    TablePresets.candyOutline,
    headersServer,
    rowsServer,
  );

  // ===========================================================================
  // 5. MIXANDO CORES MANUAIS + PRESETS
  // ===========================================================================
  _printSection('5. CONTEÚDO COLORIDO MANUALMENTE & ECell');

  const statusOk = '${XTermColor.green}● ATIVO${XTermColor.reset}';
  const statusWarn = '${XTermColor.yellow}● ALERTA${XTermColor.reset}';
  const statusErr = '${XTermColor.red}● ERRO${XTermColor.reset}';

  print(
    '${XTermStyle.bold}► Custom content inside Rounded Preset:${XTermColor.reset}',
  );

  Elog.table([
        'Service',
        'Latency',
        // Títulos centralizados
        ECell('Status', align: ECellTextAlign.center),
      ])
      .align([
        ECellTextAlign.left,
        ECellTextAlign.center, // Dados da coluna 2 centralizados
        ECellTextAlign.left,
      ])
      .style(TablePresets.rounded)
      .row(['Auth', '24ms', statusOk])
      .row(['Database', '120ms', statusWarn])
      .row(['Payment', 'Timeout', statusErr])
      .print();

  print('\n🏁 Fim da Demo');
}

// --- Helper para exibir as tabelas ---
void _printTable(
  String title,
  TableStyle style,
  List<dynamic> headers,
  List<List<dynamic>> rows,
) {
  print('${XTermStyle.bold}► $title:${XTermColor.reset}');

  final builder = Elog.table(headers).style(style);

  for (final row in rows) {
    builder.row(row);
  }

  builder.print();
  print('');
}

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}
