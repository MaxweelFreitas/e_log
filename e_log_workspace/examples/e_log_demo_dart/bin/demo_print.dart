import '../../../elog/lib/elog.dart';

void main() async {
  // Limpa tela (opcional) ou dá um espaço
  print('\n');

  // ===========================================================================
  // 1. HEADER (Estilo Cyberpunk com Sombra)
  // ===========================================================================
  Elog.panel
      .style(
        BoxPresets.double.copyWith(
          borderColor: XTermColor.hexFg('3D9E60'), // Borda Neon
          titleColor: XTermStyle.bold + XTermColor.brightWhite,
        ),
      )
      .title('Logs NÃO precisam ser', align: BoxTitleAlign.center)
      .content(
        '${XTermColor.white} - ${XTermColor.orange}Feios\n'
        '${XTermColor.white} - ${XTermColor.cyan}Pobres\n'
        '${XTermColor.white} - ${XTermColor.magenta}Descartáveis',
      )
      .width(40) // Largura compacta solicitada
      .withShadow() // Sombra automática
      .print();

  // ===========================================================================
  // 2. SPINNER (Simulando Conexão Segura)
  // ===========================================================================
  // Usando um conjunto de caracteres mais bonito se disponível, ou padrão
  final spinner = Elog.spinner(
    text: '${XTermColor.white}Authenticating...${XTermColor.reset}',
  );

  spinner.start();
  await Future.delayed(Duration(seconds: 2));
  spinner.done(
    text: '${XTermStyle.bold}Auth Success${XTermColor.reset}',
    icon: '🔐',
  );

  print('');

  // ===========================================================================
  // 3. API LOGS (Com Presets e Sombras)
  // ===========================================================================

  // Sucesso - Estilo Clean/Neon
  Elog.api
      .style(ApiStyle.filled)
      .setTheme(EApiPresets.neon) // Usa o preset Neon que criamos
      .method('POST')
      .url('/v1/deploy/init')
      .statusCode(201)
      .timeTaken('145ms')
      .width(40) // Compacto
      .withShadow()
      .print();

  // Erro - Estilo Boxed com tema Dracula/Error
  Elog.api
      .style(ApiStyle.boxed)
      .setTheme(EApiPresets.fire)
      .method('GET')
      .url('/health-check')
      .statusCode(503)
      .timeTaken('5.2s')
      .width(40)
      .shadow(ShadowStyle.dense) // Sombra pesada para erro
      .print();

  print('');

  // ===========================================================================
  // 4. PROGRESS BAR (Gradiente RGB Real)
  // ===========================================================================

  // Aqui usamos o poder do RGB! Gradiente de Roxo para Ciano
  final progress = Elog.progress(
    label: 'Uploading',
    total: 100,
    style: ProgressPresets.shade, // Estilo sombreado
    width: 40, // Largura total da linha
    startColor: Rgb(128, 0, 255), // Roxo
    endColor: Rgb(0, 255, 255), // Ciano
    showPercentage: true,
  );

  for (int i = 0; i <= 100; i += 4) {
    // Passamos null na mensagem para manter o layout limpo ou uma msg curta
    progress.update(i);
    await Future.delayed(Duration(milliseconds: 25));
  }

  progress.finish(message: 'Assets Uploaded');

  print('');

  // ===========================================================================
  // 5. CHART (Gradiente Global)
  // ===========================================================================

  Elog.chart
      .title('🔥 Server Load')
      .type(ChartType.bar)
      .style(ChartPresets.block) // Blocos sólidos
      .width(40) // Compacto
      // Gradiente de Vermelho para Amarelo (Heatmap)
      .gradient(Rgb(255, 0, 0), Rgb(255, 255, 0))
      .data({'DB': 45, 'Redis': 80, 'Web': 35})
      .print();

  print('');

  // ===========================================================================
  // 6. FINAL STATUS (Cyberpunk Style)
  // ===========================================================================

  Elog.log
      .layout(ELogLayout.boxed)
      .style(ELogPresets.neon) // O preset mais bonito
      .width(40) // Forçando largura
      .tagAlign(ELogTagAlign.center)
      .level(ELogLevel.success)
      .title('SYSTEM LIVE')
      .message('Deployment finished successfully in 4.2s.')
      .shadow(ShadowStyle.light) // Sombra suave
      .print();

  print('\n');
}
