import 'dart:async';

import '../../../elog/lib/elog.dart';

void main() async {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║           ELOG - DEMONSTRAÇÃO COMPLETA DE SPINNERS           ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // ===========================================================================
  // 1. NOVIDADES (Highlight)
  // ===========================================================================
  _printSection('1. NOVIDADES & DESTAQUES');

  // ROBOT (O novo destaque)
  await _runDemo(
    SpinnerPresets.robot,
    'Inicializando IA...',
    'IA Online e pronta.',
  );

  // DANCE
  await _runDemo(
    SpinnerPresets.dance,
    'Processando diversão...',
    'Festa concluída!',
  );

  // CRAB
  await _runDemo(
    SpinnerPresets.crab,
    'Procurando no fundo do mar...',
    'Tesouro encontrado!',
  );

  // ===========================================================================
  // 2. CLÁSSICOS & LINHAS
  // ===========================================================================
  _printSection('2. CLÁSSICOS & LINHAS');

  await _runDemo(SpinnerPresets.dots, 'Carregando (Dots)...');
  await _runDemo(SpinnerPresets.dots2, 'Carregando (Dots 2)...');
  await _runDemo(SpinnerPresets.dots3, 'Carregando (Dots 3)...');
  await _runDemo(SpinnerPresets.line, 'Processando (Line)...');
  await _runDemo(SpinnerPresets.bar, 'Renderizando (Bar)...');
  await _runDemo(SpinnerPresets.pulse, 'Aguardando (Pulse)...');
  await _runDemo(SpinnerPresets.heavy, 'Compilando (Heavy)...');
  await _runDemo(SpinnerPresets.minimal, 'Aguarde (Minimal)...');

  // ===========================================================================
  // 3. FORMAS & MOVIMENTO
  // ===========================================================================
  _printSection('3. FORMAS & MOVIMENTO');

  await _runDemo(SpinnerPresets.circle, 'Girando (Circle)...');
  await _runDemo(SpinnerPresets.arc, 'Carregando (Arc)...');
  await _runDemo(SpinnerPresets.square, 'Montando (Square)...');
  await _runDemo(SpinnerPresets.arrow, 'Redirecionando (Arrow)...');
  await _runDemo(SpinnerPresets.bounce, 'Saltando (Bounce)...');
  await _runDemo(SpinnerPresets.jumpingDots, 'Pulando (Jumping)...');

  // ===========================================================================
  // 4. NATUREZA & TEMPO
  // ===========================================================================
  _printSection('4. NATUREZA & TEMPO');

  await _runDemo(SpinnerPresets.moon, 'Sincronizando fases (Moon)...');
  await _runDemo(SpinnerPresets.earth, 'Conectando globalmente (Earth)...');
  await _runDemo(SpinnerPresets.clock, 'Aguardando tempo (Clock)...');

  // ===========================================================================
  // 5. TESTE DE ERRO
  // ===========================================================================
  _printSection('5. TESTE DE FALHA');

  final sError = Elog.interactive.spinner(
    spinner: SpinnerPresets.dots,
    text: 'Tentando conexão crítica...',
  );
  await Future.delayed(const Duration(seconds: 2));
  sError.fail('Falha na conexão: Timeout (Erro simulado)');

  print('\n🏁 Fim da Demo');
}

// --- Helpers ---

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}

/// Helper para rodar um spinner por alguns segundos e finalizar
Future<void> _runDemo(
  SpinnerSet preset,
  String text, [
  String? successText,
]) async {
  // Inicia o spinner
  final spinner = Elog.interactive.spinner(
    spinner: preset,
    text: '${XTermStyle.bold}$text${XTermColor.reset}',
  );

  // Aguarda um pouco para vermos a animação
  await Future.delayed(const Duration(milliseconds: 2000));

  // Finaliza
  spinner.success(successText ?? '$text [OK]');

  // Pequena pausa entre eles para não atropelar visualmente
  await Future.delayed(const Duration(milliseconds: 200));
}
