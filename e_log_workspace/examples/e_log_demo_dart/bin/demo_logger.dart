import '../../../elog/lib/elog.dart';

void main() {
  print('\n=== DEMO: LOGGER & CONFIGURAÇÃO ===\n');

  // 1. Configuração Global (Data)
  ELogConfig().setDateType(EDateType.ptBr);

  // ===========================================================================
  // 1. FUNCIONALIDADE BÁSICA
  // ===========================================================================
  print(
    '${XTermColor.bgBlue}${XTermColor.white} 1. NÍVEIS PADRÃO (INLINE) ${XTermColor.reset}\n',
  );

  Elog.info('Sistema iniciado.');
  Elog.success('Banco de dados conectado.');
  Elog.warn('Uso de memória alto (85%).');
  Elog.error('Falha na requisição HTTP.');

  // ===========================================================================
  // 2. EXTENSIBILIDADE
  // ===========================================================================
  print(
    '\n${XTermColor.bgBlue}${XTermColor.white} 2. NÍVEL CUSTOMIZADO ${XTermColor.reset}\n',
  );

  final hackerLevel = ELogLevel.custom(
    id: 'hacker',
    label: 'HACK',
    icon: '👾',
    color: XTermColor.brightGreen,
  );

  Elog.log
      .level(hackerLevel)
      .message('Injeção de dependência detectada.')
      .print();

  // ===========================================================================
  // 3. LAYOUT BOXED (DETALHADO)
  // ===========================================================================
  print(
    '\n${XTermColor.bgBlue}${XTermColor.white} 3. LAYOUT BOXED (DETALHADO) ${XTermColor.reset}\n',
  );

  Elog.log
      .layout(ELogLayout.boxed)
      .level(ELogLevel.fatal)
      .title('CRITICAL KERNEL PANIC')
      .tagAlign(ELogTagAlign.center)
      .message(
        'O núcleo do sistema parou de responder. Reinicie o servidor imediatamente.',
      )
      .source('lib/core/kernel.dart')
      .link(url: 'https://stackoverflow.com', text: 'Ver solução')
      .print();

  // ===========================================================================
  // 4. TRATAMENTO DE ERRO (STACKTRACE)
  // ===========================================================================
  print(
    '\n${XTermColor.bgBlue}${XTermColor.white} 4. ERRO COM STACKTRACE ${XTermColor.reset}\n',
  );

  try {
    throw Exception('Null Pointer Exception');
  } on Exception catch (e, s) {
    Elog.log
        .layout(ELogLayout.boxed)
        .level(ELogLevel.error)
        .message('Erro capturado no bloco try/catch.')
        .error(e, s)
        .print();
  }

  // ===========================================================================
  // 5. PRESETS VISUAIS - ESTRUTURAIS
  // ===========================================================================
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} 5. PRESETS ESTRUTURAIS (BORDAS) ${XTermColor.reset}\n',
  );
  print(
    'Estes estilos herdam a cor do nível (Info=Azul, Erro=Vermelho, etc).\n',
  );

  _demoPreset('Standard (Rounded)', ELogPresets.standard);
  _demoPreset('Simple (Single)', ELogPresets.simple);
  _demoPreset('Double (Retro)', ELogPresets.double);
  _demoPreset('Mixed (H:Double V:Single)', ELogPresets.mixed);

  // Exemplo de Heavy com Sombra (Simulando um erro para mostrar cor)
  Elog.log
      .layout(ELogLayout.boxed)
      .style(ELogPresets.heavy)
      .level(ELogLevel.error)
      .title('Preset: Heavy')
      .message('Este preset é ótimo para destacar erros graves.')
      .print();

  _demoPreset('ASCII (Compatibilidade)', ELogPresets.ascii);

  // ===========================================================================
  // 6. PRESETS VISUAIS - MINIMALISTAS
  // ===========================================================================
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} 6. PRESETS MINIMALISTAS ${XTermColor.reset}\n',
  );

  _demoPreset('Clean (Sem bordas)', ELogPresets.clean);
  _demoPreset('Dotted (Pontilhado)', ELogPresets.dotted);
  _demoPreset('Dashed (Tracejado)', ELogPresets.dashed);

  // ===========================================================================
  // 7. PRESETS VISUAIS - TEMAS (CORES FIXAS)
  // ===========================================================================
  print(
    '\n${XTermColor.bgMagenta}${XTermColor.white} 7. TEMAS VISUAIS (CORES FIXAS) ${XTermColor.reset}\n',
  );
  print(
    'Estes temas sobrescrevem as cores do nível para criar uma identidade visual.\n',
  );

  _demoPreset('Dracula', ELogPresets.dracula);
  _demoPreset('Cyberpunk', ELogPresets.cyberpunk);
  _demoPreset('Matrix', ELogPresets.matrix);
  _demoPreset('Monokai', ELogPresets.monokai);
  _demoPreset('Solarized', ELogPresets.solarized);
  _demoPreset('Neon', ELogPresets.neon);
  _demoPreset('Monochrome', ELogPresets.monochrome);

  print('\n');
}

// --- Helper para demonstrar presets ---
void _demoPreset(String name, ELogStyle style) {
  Elog.log
      .layout(ELogLayout.boxed)
      .style(style)
      .level(ELogLevel.info)
      .title(name)
      .message('Lorem ipsum dolor sit amet, Emojis: 🚀 📦 ✅')
      .print();
}
