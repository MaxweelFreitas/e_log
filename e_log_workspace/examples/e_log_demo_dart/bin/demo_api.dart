import '../../../elog/lib/elog.dart';

void main() {
  print('\n╔══════════════════════════════════════════════════════════════╗');
  print('║             ELOG - DEMONSTRAÇÃO DE API LOGS                  ║');
  print('╚══════════════════════════════════════════════════════════════╝');

  // ===========================================================================
  // 1. ESTILOS DE LAYOUT (Estrutura)
  // ===========================================================================
  _printSection('1. ESTILOS DE LAYOUT (SIMPLE, BOXED, FILLED)');

  // Simple
  print(
    EApiBuilder()
        .style(ApiStyle.simple)
        .info('Simple Style')
        .request(method: 'GET', url: '/health')
        .response(status: 200, body: {'status': 'OK'})
        .build(),
  );

  // Boxed
  print(
    EApiBuilder()
        .style(ApiStyle.boxed)
        .info('Boxed Style')
        .request(method: 'GET', url: '/users')
        .response(status: 200, body: {'count': 5})
        .build(),
  );

  // Filled
  print(
    EApiBuilder()
        .style(ApiStyle.filled)
        .compactTitle() // Título colado fica melhor no Filled
        .info('Filled Style')
        .request(method: 'POST', url: '/data')
        .response(status: 201, body: {'created': true})
        .build(),
  );

  // ===========================================================================
  // 2. TEMAS CLÁSSICOS & SEMÂNTICOS
  // ===========================================================================
  _printSection('2. TEMAS SEMÂNTICOS');

  _printApi('Standard (Default)', EApiPresets.standard);
  _printApi('Classic (Blue)', EApiPresets.classic);
  _printApi('Minimal (Clean)', EApiPresets.minimal, style: ApiStyle.simple);
  _printApi('Success (Green)', EApiPresets.success, status: 200);
  _printApi('Warning (Yellow)', EApiPresets.warning, status: 429);
  _printApi('Error (Red)', EApiPresets.error, status: 500);
  _printApi('Info (Cyan)', EApiPresets.info);

  // ===========================================================================
  // 3. TEMAS ESTILIZADOS
  // ===========================================================================
  _printSection('3. TEMAS ESTILIZADOS');

  _printApi('Matrix (Digital)', EApiPresets.matrix);
  _printApi('Neon (Vibrant)', EApiPresets.neon);
  _printApi('Fire (Hot)', EApiPresets.fire, status: 500);
  _printApi('Forest (Nature)', EApiPresets.forest);
  _printApi('Amber (Retro)', EApiPresets.amber);

  // ===========================================================================
  // 4. TEMAS RGB / TRUECOLOR
  // ===========================================================================
  _printSection('4. TEMAS RGB (TRUECOLOR)');
  print(
    '${XTermColor.brightBlack}Recomendado usar com ApiStyle.filled para imersão total.${XTermColor.reset}\n',
  );

  _printApi('Dracula', EApiPresets.dracula, style: ApiStyle.filled);
  _printApi('Cyberpunk', EApiPresets.cyberpunk, style: ApiStyle.filled);
  _printApi('Yaru (Ubuntu)', EApiPresets.yaru, style: ApiStyle.filled);
  _printApi('Oceanic', EApiPresets.oceanic, style: ApiStyle.filled);
  _printApi('Monokai', EApiPresets.monokai, style: ApiStyle.filled);
  _printApi('Vercel', EApiPresets.vercel, style: ApiStyle.filled);
  _printApi('Solarized', EApiPresets.solarized, style: ApiStyle.filled);
  _printApi('Candy', EApiPresets.candy, style: ApiStyle.filled);

  // ===========================================================================
  // 5. TESTE DE DADOS COMPLEXOS
  // ===========================================================================
  _printSection('5. DADOS COMPLEXOS & SHADOW');

  print(
    EApiBuilder()
        .timestamp(DateTime.now())
        .setTheme(EApiPresets.dracula)
        .style(ApiStyle.filled)
        .info('Complex Data')
        .withShadow() // Adiciona sombra padrão
        .request(
          method: 'POST',
          url: '/api/v2/order',
          headers: {'Authorization': 'Bearer ...'},
          bodyOrParams: {
            'items': [
              {'id': 1, 'name': 'Item A', 'price': 10.50},
              {'id': 2, 'name': 'Item B', 'price': 5.00},
            ],
            'coupon': null,
          },
        )
        .response(
          status: 200,
          time: '340ms',
          body: {
            'success': true,
            'order_id': 'ORD-992-88',
            'meta': {'trace_id': 'abc-123-xyz'},
          },
        )
        .build(),
  );

  print('\n🏁 Fim da Demo');
}

// --- Helpers ---

void _printSection(String title) {
  print(
    '\n${XTermColor.bgCyan}${XTermColor.black} $title ${XTermColor.reset}\n',
  );
}

/// Helper para imprimir um card de API rapidamente
void _printApi(
  String name,
  EApiStyle theme, {
  int status = 200,
  ApiStyle style = ApiStyle.boxed,
}) {
  final builder = EApiBuilder()
      .style(style)
      .setTheme(theme)
      .request(method: 'GET', url: '/api/v1/resource');

  builder.response(
    status: status,
    body: {'id': 123, 'active': true, 'theme': name},
  );

  // Ajusta o label baseado no status para ativar cores automáticas se necessário
  if (status >= 500) {
    builder.error(name);
  } else if (status >= 400) {
    builder.warning(name);
  } else {
    builder.info(name);
  }

  if (style == ApiStyle.filled) {
    builder.compactTitle();
  }

  print(builder.build());
  print('\n');
}
