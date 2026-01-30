import 'package:elog/elog.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║             ELOG - DEMONSTRAÇÃO DE BLOQUETES (BLOCK)         ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // ===========================================================================
  // 1. ESTILOS BÁSICOS & ESTRUTURAIS
  // ===========================================================================
  _printSection('1. BÁSICOS & ESTRUTURAIS');

  print('► Classic (Padrão):');
  Elog.block
      .style(BlockPresets.classic)
      .text('INFO LOG')
      .text('Estilo padrão com linha simples lateral.')
      .print();

  print('\n► Block (Sólido):');
  Elog.block
      .style(BlockPresets.block)
      .text('BLOCK STYLE')
      .text('Barra sólida para alto contraste.')
      .print();

  print('\n► Thin (Fino):');
  Elog.block
      .style(BlockPresets.thin)
      .text('Compact Log Entry')
      .text('Sem linhas de padding, ideal para logs densos.')
      .print();

  print('\n► Round (Arredondado):');
  Elog.block
      .style(BlockPresets.round)
      .text('MODERN UI')
      .text('Usa caracteres curvos para suavizar.')
      .print();

  print('\n► Heavy (Pesado):');
  Elog.block
      .style(BlockPresets.heavy)
      .text('IMPORTANT NOTICE')
      .text('Barra lateral espessa para destaque.')
      .print();

  print('\n► Double (DOS Style):');
  Elog.block
      .style(BlockPresets.double)
      .text('SYSTEM BOOT')
      .text('Loading kernel modules...')
      .print();

  // ===========================================================================
  // 2. RETRO / ASCII / MINIMAL
  // ===========================================================================
  _printSection('2. RETRO & ASCII');

  print('► ASCII (Pipe):');
  Elog.block
      .style(BlockPresets.ascii)
      .text('Simple Pipe')
      .text('Compatibilidade máxima.')
      .print();

  print('\n► Pipe (Gold):');
  Elog.block
      .style(BlockPresets.pipe)
      .text('RETRO GAME')
      .text('High Score: 999999')
      .print();

  print('\n► Clean (Foco no Texto):');
  Elog.block
      .style(BlockPresets.clean)
      .text('CLEAN DATA')
      .text('Apenas o essencial, sem ruído visual.')
      .print();

  print('\n► Minimal (Discreto):');
  Elog.block
      .style(BlockPresets.minimal)
      .text('debug_log.txt')
      .text('Verbose output enabled.')
      .print();

  // ===========================================================================
  // 3. SEMÂNTICOS (STYLES)
  // ===========================================================================
  _printSection('3. ESTILOS SEMÂNTICOS');

  print('► Success (Verde):');
  Elog.block
      .style(BlockPresets.success)
      .text('BUILD SUCCESSFUL')
      .text('Completed in 2.4s. No errors found.')
      .print();

  print('\n► Warning (Amarelo):');
  Elog.block
      .style(BlockPresets.warning)
      .text('DEPRECATION WARNING')
      .text("The method 'oldAPI()' will be removed soon.")
      .print();

  print('\n► Error (Vermelho):');
  Elog.block
      .style(BlockPresets.error)
      .text('FATAL EXCEPTION')
      .text('NullPointer at line 42.')
      .print();

  print('\n► Info (Azul):');
  Elog.block
      .style(BlockPresets.info)
      .text('SERVER STATUS')
      .text('Listening on port 8080...')
      .print();

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS
  // ===========================================================================
  _printSection('4. TEMAS ESTILIZADOS');

  print('► Quote (Citação):');
  Elog.block
      .style(BlockPresets.quote)
      .text('A simplicidade é o último grau de sofisticação.')
      .text('— Leonardo da Vinci')
      .print();

  print('\n► Matrix (Hacker):');
  Elog.block
      .style(BlockPresets.matrix)
      .text('MAINFRAME ACCESS')
      .text('Bypassing firewall security...')
      .print();

  print('\n► Neon (Cyber):');
  Elog.block
      .style(BlockPresets.neon)
      .text('NEURAL LINK')
      .text('Connection established.')
      .print();

  print('\n► Fire (Critical):');
  Elog.block
      .style(BlockPresets.fire)
      .text('CORE MELTDOWN')
      .text('Temperature exceeded 5000°C!')
      .print();

  print('\n► Forest (Eco):');
  Elog.block
      .style(BlockPresets.forest)
      .text('ECO SYSTEM')
      .text('Sustainability metrics valid.')
      .print();

  print('\n► Amber (Retro Monitor):');
  Elog.block
      .style(BlockPresets.amber)
      .text('BIOS CHECK')
      .text('Memory OK. Keyboard OK.')
      .print();

  // ===========================================================================
  // 5. RGB / TRUECOLOR
  // ===========================================================================
  _printSection('5. TEMAS RGB (TRUECOLOR)');

  print('► Dracula:');
  Elog.block
      .style(BlockPresets.dracula)
      .text('DRACULA THEME')
      .text('Dark mode for vampires.')
      .print();

  print('\n► Cyberpunk:');
  Elog.block
      .style(BlockPresets.cyberpunk)
      .text('NIGHT CITY')
      .text('Wake up, Samurai.')
      .print();

  print('\n► Yaru (Ubuntu):');
  Elog.block
      .style(BlockPresets.yaru)
      .text('LINUX KERNEL')
      .text('Ubuntu 24.04 LTS Ready.')
      .print();

  print('\n► Oceanic:');
  Elog.block
      .style(BlockPresets.oceanic)
      .text('DEEP DIVE')
      .text('Analyzing sub-surface data.')
      .print();

  print('\n► Monokai:');
  Elog.block
      .style(BlockPresets.monokai)
      .text('CODE SNIPPET')
      .text('void main() { run(); }')
      .print();

  print('\n► Vercel:');
  Elog.block
      .style(BlockPresets.vercel)
      .text('DEPLOYMENT')
      .text('Production build ready.')
      .print();

  print('\n► Solarized:');
  Elog.block
      .style(BlockPresets.solarized)
      .text('VIM EDITOR')
      .text('Mode: Insert')
      .print();

  print('\n► Candy:');
  Elog.block
      .style(BlockPresets.candy)
      .text('SWEET ALERT')
      .text('Have a nice day! ${XTermColor.red}♥')
      .print();

  // ===========================================================================
  // 6. DX & SHORTCUTS (NOVO!)
  // ===========================================================================
  _printSection('6. DEVELOPER EXPERIENCE (DX) & SHORTCUTS');

  print('► 1. One-Liner (Texto + Estilo direto no print):');
  Elog.block.print('Hello World (Candy Style)', BlockPresets.candy);
  print('');

  print('► 2. Semantic Shortcuts (Métodos diretos):');
  Elog.block.success('Deploy finalizado com sucesso!');
  Elog.block.error('Erro de conexão com o banco de dados.');
  Elog.block.warning('Uso de memória acima de 80%.');
  Elog.block.info('Serviço iniciado na porta 3000.');
  print('');

  print('► 3. List Support (Imprimindo Listas diretamente):');
  final items = [
    '• Item A: Processado',
    '• Item B: Pendente',
    '• Item C: Cancelado',
  ];
  Elog.block.print(items, BlockPresets.thin);

  print('\n🏁 Fim da Demo');
}

// --- Helpers ---

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}
