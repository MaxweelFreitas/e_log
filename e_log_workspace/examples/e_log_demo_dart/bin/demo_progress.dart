import 'dart:async';
import 'package:elog/elog.dart';
import 'package:elog/src/utils/color_utils.dart'; // Idealmente, exporte Rgb no elog.dart para evitar importar src

void main() async {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║           ELOG - DEMONSTRAÇÃO DE PROGRESS BAR                ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // Configuração global de velocidade para a demo não demorar muito
  const int defaultStep = 5; // Avança 5% por vez
  const int defaultDelay = 25; // Espera 25ms (Muito rápido e fluido)

  // ===========================================================================
  // 1. ESTILOS BÁSICOS
  // ===========================================================================
  _printSection('1. ESTILOS BÁSICOS & CLÁSSICOS');

  await _simulateProgress(
    ProgressPresets.classic,
    'Classic Style',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.block,
    'Block Style (Default)',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.clean,
    'Clean (No Border)',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.hash,
    'Hash Style',
    step: defaultStep,
    delayMs: defaultDelay,
  );

  // ===========================================================================
  // 2. GEOMÉTRICOS
  // ===========================================================================
  _printSection('2. FORMAS GEOMÉTRICAS');

  await _simulateProgress(
    ProgressPresets.rect,
    'Rectangles',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.shade,
    'Shaded Block',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.circle,
    'Circles',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.square,
    'Squares',
    step: defaultStep,
    delayMs: defaultDelay,
  );

  // ===========================================================================
  // 3. CRIATIVOS & FUN
  // ===========================================================================
  _printSection('3. CRIATIVOS & DIVERTIDOS');

  await _simulateProgress(
    ProgressPresets.hearts,
    'Sending Love...',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.star,
    'Rating/Stars...',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.dots,
    'Dots Loader',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.arrow,
    'Directional',
    step: defaultStep,
    delayMs: defaultDelay,
  );

  // Pacman fica melhor um pouco mais lento para ver a animação da boca
  await _simulateProgress(
    ProgressPresets.pacman,
    'Eating dots...',
    step: 2,
    delayMs: 40,
  );

  // ===========================================================================
  // 4. ESTILIZADOS (Temáticos)
  // ===========================================================================
  _printSection('4. TEMAS ESTILIZADOS');

  await _simulateProgress(
    ProgressPresets.matrix,
    'Matrix Upload',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.neon,
    'Neon Lights',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.fire,
    'Burning Process',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.forest,
    'Growing Forest',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.amber,
    'Retro Monitor',
    step: defaultStep,
    delayMs: defaultDelay,
  );

  // ===========================================================================
  // 5. RGB / TRUECOLOR
  // ===========================================================================
  _printSection('5. TEMAS RGB (TRUECOLOR)');

  await _simulateProgress(
    ProgressPresets.dracula,
    'Dracula Theme',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.cyberpunk,
    'Cyberpunk 2077',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.yaru,
    'Ubuntu Yaru',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.oceanic,
    'Oceanic Deep',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.monokai,
    'Monokai Code',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.vercel,
    'Vercel Deploy',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.solarized,
    'Solarized Light',
    step: defaultStep,
    delayMs: defaultDelay,
  );
  await _simulateProgress(
    ProgressPresets.candy,
    'Cotton Candy',
    step: defaultStep,
    delayMs: defaultDelay,
  );

  // ===========================================================================
  // 6. GRADIENTES & RAINBOW
  // ===========================================================================
  _printSection('6. GRADIENTES & RAINBOW ASPECTS');
  print(
    '${XTermColor.brightBlack}Demonstração de interpolação de cores RGB.${XTermColor.reset}\n',
  );

  await _runGradientDemo(
    'Rainbow Linear (Vaporwave)',
    ProgressPresets.rainbowLinear,
    Rgb(0, 255, 255), // Cyan
    Rgb(255, 0, 255), // Magenta
  );

  await _runGradientDemo(
    'Rainbow Flow (Heatmap)',
    ProgressPresets.rainbowFlow,
    Rgb(255, 0, 0), // Red
    Rgb(255, 255, 0), // Yellow
  );

  await _runGradientDemo(
    'Rainbow Dots (Deep Sea)',
    ProgressPresets.rainbowDots,
    Rgb(0, 0, 139), // Dark Blue
    Rgb(0, 255, 127), // Spring Green
  );

  await _runGradientDemo(
    'Rainbow Bar (Sunset)',
    ProgressPresets.rainbowBar,
    Rgb(128, 0, 128), // Purple
    Rgb(255, 165, 0), // Orange
  );

  // ===========================================================================
  // 7. SIMULAÇÃO MANUAL
  // ===========================================================================
  _printSection('7. SIMULAÇÃO MANUAL');

  final downloadBar = Elog.interactive.progress(
    label: 'Downloading update...',
    style: ProgressPresets.block,
  );

  // Acelerado também
  for (int i = 0; i <= 100; i += 2) {
    downloadBar.update(i);
    await Future.delayed(const Duration(milliseconds: 10));
  }
  downloadBar.finish(message: 'File verified');

  print('\n🏁 Fim da Demo');
}

// --- Helpers ---

void _printSection(String title) {
  // Adiciona uma linha em branco antes do título para separar visualmente as seções
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}

Future<void> _simulateProgress(
  ProgressStyle style,
  String label, {
  int step = 1,
  int delayMs = 100,
}) async {
  final progress = Elog.interactive.progress(label: label, style: style);

  for (int i = 0; i <= 100; i += step) {
    progress.update(i);
    await Future.delayed(Duration(milliseconds: delayMs));
  }
  progress.finish(message: 'Done');
}

Future<void> _runGradientDemo(
  String label,
  ProgressStyle style,
  Rgb start,
  Rgb end,
) async {
  final progress = Elog.interactive.progress(
    label: label,
    style: style,
    startColor: start,
    endColor: end,
  );

  // Demo de gradiente um pouco mais rápida que o padrão anterior
  for (int i = 0; i <= 100; i += 4) {
    progress.update(i);
    await Future.delayed(const Duration(milliseconds: 20));
  }
  progress.finish(message: 'Completed');
}
