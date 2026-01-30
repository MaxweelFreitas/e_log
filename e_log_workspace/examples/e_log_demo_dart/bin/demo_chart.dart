import 'package:elog/elog.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║             ELOG - DEMONSTRAÇÃO COMPLETA DE GRÁFICOS         ║');
  print('╚══════════════════════════════════════════════════════════════╝\n');

  // --- DADOS DE EXEMPLO ---
  final languages = {'Dart': 90.0, 'Rust': 75.0, 'Go': 60.0, 'C++': 45.0};
  final serverLoad = {'CPU': 45.0, 'RAM': 80.0, 'Disk': 30.0};
  final retroStats = {'8-Bit': 20.0, '16-Bit': 50.0, '32-Bit': 95.0};
  final themes = {'UI': 80.0, 'UX': 65.0, 'DX': 90.0};

  // ===========================================================================
  // 1. ESTILOS BÁSICOS & ESTRUTURAIS
  // ===========================================================================
  _printSection('1. BÁSICOS & ESTRUTURAIS');

  print('► Classic (Padrão):');
  Elog.chart.style(ChartPresets.classic).addMap(languages).print();

  print('\n► Block (Minimalista):');
  Elog.chart.style(ChartPresets.block).addMap(languages).print();

  print('\n► Thin (Elegante):');
  Elog.chart.style(ChartPresets.thin).addMap(languages).print();

  print('\n► Round (Moderno):');
  Elog.chart.style(ChartPresets.round).addMap(languages).print();

  print('\n► Heavy (Destacado):');
  Elog.chart.style(ChartPresets.heavy).addMap(languages).print();

  print('\n► Double (Borda Dupla):');
  Elog.chart.style(ChartPresets.double).addMap(languages).print();

  // ===========================================================================
  // 2. RETRO / ASCII / MINIMAL
  // ===========================================================================
  _printSection('2. RETRO & ASCII');

  print('► ASCII (Hash & Dot):');
  Elog.chart.style(ChartPresets.ascii).addMap(retroStats).print();

  print('\n► Pipe (Terminal Antigo):');
  Elog.chart.style(ChartPresets.pipe).addMap(retroStats).print();

  print('\n► Clean (Sem fundo):');
  Elog.chart.style(ChartPresets.clean).addMap(retroStats).print();

  print('\n► Minimal (Linha Simples):');
  Elog.chart.style(ChartPresets.minimal).addMap(retroStats).print();

  // ===========================================================================
  // 3. SEMÂNTICOS (Contexto)
  // ===========================================================================
  _printSection('3. SEMÂNTICOS');

  print('► Success (Verde):');
  Elog.chart
      .style(ChartPresets.success)
      .add('Tests Passed', 100)
      .add('Coverage', 95)
      .print();

  print('\n► Warning (Amarelo):');
  Elog.chart
      .style(ChartPresets.warning)
      .add('Disk Usage', 85)
      .add('Memory', 70)
      .print();

  print('\n► Error (Vermelho):');
  Elog.chart
      .style(ChartPresets.error)
      .add('Errors', 50)
      .add('Failures', 30)
      .print();

  // ===========================================================================
  // 4. TEMAS ESTILIZADOS (Visual Rico)
  // ===========================================================================
  _printSection('4. TEMAS ESTILIZADOS');

  print('► Matrix (Hacker Style):');
  Elog.chart
      .style(ChartPresets.matrix)
      .add('Encryption', 100)
      .add('Decryption', 60)
      .add('Breach', 20)
      .print();

  print('\n► Fire (Textura Quente):');
  Elog.chart
      .style(ChartPresets.fire)
      .add('Core 1 Temp', 85)
      .add('Core 2 Temp', 92)
      .add('GPU Temp', 70)
      .print();

  print('\n► Neon (Vibrante):');
  Elog.chart.style(ChartPresets.neon).add('Glow', 90).add('Shine', 50).print();

  print('\n► Forest (Natural):');
  Elog.chart.style(ChartPresets.forest).addMap(themes).print();

  print('\n► Amber (Monitor Antigo):');
  Elog.chart.style(ChartPresets.amber).addMap(retroStats).print();

  // ===========================================================================
  // 5. RGB / TRUECOLOR (Temas de IDE)
  // ===========================================================================
  _printSection('5. TEMAS RGB (TRUECOLOR)');

  // Vamos mostrar estes lado a lado (um após o outro) para economizar espaço
  print('► Dracula:');
  Elog.chart.style(ChartPresets.dracula).addMap(serverLoad).print();

  print('\n► Cyberpunk:');
  Elog.chart.style(ChartPresets.cyberpunk).addMap(serverLoad).print();

  print('\n► Yaru (Ubuntu):');
  Elog.chart.style(ChartPresets.yaru).addMap(serverLoad).print();

  print('\n► Oceanic:');
  Elog.chart.style(ChartPresets.oceanic).addMap(serverLoad).print();

  print('\n► Monokai:');
  Elog.chart.style(ChartPresets.monokai).addMap(serverLoad).print();

  print('\n► Vercel (Black & White):');
  Elog.chart.style(ChartPresets.vercel).addMap(serverLoad).print();

  print('\n► Solarized:');
  Elog.chart.style(ChartPresets.solarized).addMap(serverLoad).print();

  print('\n► Candy (Cotton Candy):');
  Elog.chart
      .style(ChartPresets.candy)
      .add('Sweetness', 100)
      .add('Fluff', 80)
      .print();

  // ===========================================================================
  // 6. RECURSOS AVANÇADOS (Vertical & Gradientes)
  // ===========================================================================
  _printSection('6. RECURSOS AVANÇADOS');

  // VERTICAL
  print('► Vertical (Dracula Theme):');
  Elog.chart
      .orientation(ChartOrientation.vertical)
      .style(ChartPresets.dracula) // Herda cores
      .style(
        ChartStyle(
          // Sobrescreve layout
          size: 10,
          // columnWidth: 4,
          barChar: '███',
          barColor: XTermColor.rgb(189, 147, 249), // Reaplica cor do dracula
        ),
      )
      .addMap(languages)
      .print();

  // GRADIENTE GLOBAL
  print('\n► Gradiente Global (Matrix Palette):');
  Elog.chart
      .style(ChartPresets.matrix)
      .gradient(
        Rgb(0, 50, 0), // Verde Escuro
        Rgb(0, 255, 0), // Verde Neon
        type: ChartGradientType.global,
      )
      .addMap(languages)
      .print();

  // GRADIENTE NA BARRA (INTENSIDADE)
  print('\n► Gradiente na Barra (Intensidade de Carga):');
  Elog.chart
      .style(ChartPresets.block)
      .gradient(
        Rgb(0, 255, 0), // Seguro
        Rgb(255, 0, 0), // Perigo
        type: ChartGradientType.bar,
      )
      .add('Safe Load', 30)
      .add('Warning', 65)
      .add('Critical', 95)
      .print();

  // EQUALIZADOR
  print('\n► Equalizador Vertical (Cyberpunk Gradient):');
  Elog.chart
      .orientation(ChartOrientation.vertical)
      .style(
        const ChartStyle(
          barChar: '█████',
          size: 8,
          // columnWidth: 5,
          itemGap: 2,
          showValue: false,
        ),
      )
      .gradient(
        Rgb(0, 0, 255), // Base Azul
        Rgb(0, 255, 255), // Topo Ciano
        type: ChartGradientType.bar,
      )
      .add('ola mundo', 40)
      .add('2', 80)
      .add('3', 60)
      .add('4', 90)
      .add('5', 30)
      .add('6', 70)
      .print();

  print('\n🏁 Fim da Demo');
}

// --- Helpers ---

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}
