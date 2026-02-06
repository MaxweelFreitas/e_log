import 'dart:io';
import 'package:elog/elog.dart';

class ZeroSizeFileGroup {
  final String baseName;
  final List<FileSystemEntity> files;

  ZeroSizeFileGroup(this.baseName, this.files);
}

String normalizeWindowsPath(String input) {
  var path = input.trim();

  // Remove aspas
  if ((path.startsWith('"') && path.endsWith('"')) ||
      (path.startsWith("'") && path.endsWith("'"))) {
    path = path.substring(1, path.length - 1);
  }

  // URI → path
  if (path.startsWith('file:/')) {
    path = Uri.parse(path).toFilePath(windows: true);
  }

  // Normaliza barras
  path = path.replaceAll('/', r'\');

  // Trata drive root (C: → C:\)
  final driveRoot = RegExp(r'^[a-zA-Z]:$');
  if (driveRoot.hasMatch(path)) {
    path = '$path\\';
  }

  return path;
}

Future<void> main() async {
  Elog.run(() async {
    // =========================================================
    // 1. WIZARD – COLETA DE DADOS
    // =========================================================
    final wizard = EWizardBuilder(
      title: 'LIMPEZA DE ARQUIVOS 0KB',
      style: EWizardPresets.candy,
      paddingTop: 2,
      steps: [
        MessageStep(
          'Introdução',
          id: 'intro',
          content:
              'Este assistente irá varrer um diretório em busca de arquivos\n'
              'com tamanho 0 KB e excluir todos os arquivos relacionados\n'
              'pelo mesmo prefixo base.\n\n'
              '⚠ A exclusão é IRREVERSÍVEL.',
          footer: 'Pressione Enter para continuar',
        ),

        InputTextStep(
          'Diretório para varredura',
          id: 'path',
          description: 'Informe o caminho absoluto.',
          placeholder: r'C:\Users\Usuario\Downloads',
          footer: 'Digite o caminho e pressione Enter',
          validator: (value) {
            final normalized = normalizeWindowsPath(value);
            final dir = Directory(normalized);

            if (!dir.existsSync()) {
              return 'Diretório não encontrado:\n$normalized';
            }

            // Se for root de drive (C:\), não force listagem
            final isDriveRoot = RegExp(r'^[a-zA-Z]:\\$').hasMatch(normalized);
            if (isDriveRoot) {
              return null;
            }

            // Teste real de acesso
            try {
              dir.listSync(followLinks: false).take(1).toList();
            } catch (_) {
              return 'Sem permissão para acessar:\n$normalized';
            }

            return null;
          },
        ),
      ],
    );

    final results = await wizard.run();
    final rawPath = results['path'] as String;
    final path = Directory(normalizeWindowsPath(rawPath)).absolute.path;

    // =========================================================
    // 2. VARREDURA COM SPINNER
    // =========================================================
    Elog.info('Iniciando varredura em: $path');

    final spinner = Elog.spinner(
      text: 'Analisando arquivos...',
      spinner: SpinnerPresets.dots,
    );

    late List<ZeroSizeFileGroup> groups;

    try {
      groups = await _scanZeroSizeFiles(path);
    } finally {
      spinner.stop();
    }

    if (groups.isEmpty) {
      Elog.warn('Nenhum arquivo com tamanho 0 KB encontrado.');
      return;
    }

    // =========================================================
    // 3. TABELA
    // =========================================================
    _printTable(groups);

    // =========================================================
    // 4. CONFIRMAÇÃO
    // =========================================================
    final confirmWizard = EWizardBuilder(
      title: 'CONFIRMAÇÃO FINAL',
      style: EWizardPresets.warning,
      steps: [
        ToggleStep(
          'Deseja excluir TODOS os arquivos listados?',
          id: 'confirm',
          activeLabel: 'Sim, excluir',
          inactiveLabel: 'Não, cancelar',
          initialValue: false,
          footer: 'Use ← → e Enter para confirmar',
        ),
      ],
    );

    final confirm = await confirmWizard.run();

    if (confirm['confirm'] != true) {
      Elog.warn('Operação cancelada pelo usuário.');
      return;
    }

    // =========================================================
    // 5. EXCLUSÃO COM PROGRESS BAR
    // =========================================================
    await _deleteGroups(groups);

    Elog.success('Limpeza concluída com sucesso.');
  });
}

// ============================================================
// VARREDURA
// ============================================================

Future<List<ZeroSizeFileGroup>> _scanZeroSizeFiles(String path) async {
  final dir = Directory(path);

  final entities = dir.listSync(recursive: true, followLinks: false);

  final zeroFiles = entities.whereType<File>().where((file) {
    try {
      return file.statSync().size == 0;
    } catch (_) {
      return false;
    }
  }).toList();

  final Map<String, List<FileSystemEntity>> grouped = {};

  for (final file in zeroFiles) {
    final name = file.uri.pathSegments.last;
    final base = name.split('.').first;
    final parent = file.parent;

    grouped.putIfAbsent(base, () => []);

    for (final e in parent.listSync()) {
      final n = e.uri.pathSegments.last;
      if (n == base || n.startsWith('$base.')) {
        grouped[base]!.add(e);
      }
    }
  }

  return grouped.entries
      .map((e) => ZeroSizeFileGroup(e.key, e.value.toSet().toList()))
      .toList();
}

// ============================================================
// TABELA
// ============================================================

void _printTable(List<ZeroSizeFileGroup> groups) {
  final table = Elog.table(['Prefixo', 'Qtd', 'Arquivos']);

  for (final g in groups) {
    table.row([
      g.baseName,
      g.files.length.toString(),
      g.files.map((f) => f.uri.pathSegments.last).join('\n'),
    ]);
  }

  stdout.writeln();
  table.print();
}

// ============================================================
// EXCLUSÃO
// ============================================================

Future<void> _deleteGroups(List<ZeroSizeFileGroup> groups) async {
  final total = groups.fold<int>(0, (a, b) => a + b.files.length);

  final progress = Elog.progress(total: total, label: 'Excluindo arquivos');

  int count = 0;

  for (final group in groups) {
    for (final file in group.files) {
      try {
        await file.delete();
      } catch (e) {
        Elog.error('Erro ao excluir ${file.path}', error: e);
      }
      count++;
      progress.update(count);
    }
  }

  progress.finish();
}
