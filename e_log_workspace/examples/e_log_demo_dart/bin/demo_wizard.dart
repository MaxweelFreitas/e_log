import 'dart:async';

import '../../../elog/lib/elog.dart';

void main() async {
  // ---------------------------------------------------------
  // 1. ESCOLHA O ESTILO GLOBAL
  // ---------------------------------------------------------
  // Você pode trocar por .minimal, .classic, .retro, etc.
  final myStyle = EWizardPresets.candy;

  // ---------------------------------------------------------
  // 2. DEFINIÇÃO DO WIZARD
  // ---------------------------------------------------------
  final wizard = EWizardBuilder(
    title: 'ELOG FULL DEMO SETUP',

    endingMessage: 'CONFIGURAÇÃO CONCLUÍDA COM SUCESSO!',

    style: myStyle,
    paddingTop: 2,

    steps: [
      MessageStep(
        'Bem Vindo',
        id: 'intro',
        content:
            'Bem-vindo ao configurador de projeto.\n'
            'Vamos testar todas as funcionalidades.',
        footer: 'Tecle Enter para continuar',
      ),
      // --- 1. TEXTO (Herda Estilo Global) ---
      InputTextStep(
        'Nome do Projeto',
        id: 'project_name',
        description: 'Mínimo de 3 caracteres.',
        placeholder: 'Digite o nome do app...',
        footer: 'Digite o nome e tecle Enter',
        validator: (input) {
          if (input.trim().length < 3) return 'Nome muito curto.';
          return null;
        },
      ),

      // --- 2. SELECT (Herda Estilo Global) ---
      SelectStep(
        'Tipo de Projeto',
        id: 'type',
        description: 'Selecione a plataforma alvo.',
        options: ['Application', 'Package', 'Plugin', 'Module'],
        footer: 'Use ↑ ↓ para navegar e Enter para confirmar',
      ),

      // --- 3. TOGGLE (Estilo WARNING) ---
      // AJUSTE AQUI: Passamos 'myStyle' para ele manter o layout Modern, mas com cores de Warning.
      ToggleStep(
        'Formatar disco antes?',
        id: 'format_disk',
        activeLabel: 'Sim',
        inactiveLabel: 'Não',
        initialValue: false,
        style: StepPresets.warning(myStyle),
        footer: 'Cuidado! Ação perigosa.',
      ),

      // --- 4. TOGGLE GIT (Herda Estilo Global) ---
      ToggleStep(
        'Deseja inicializar o Git?',
        id: 'use_git',
        activeLabel: 'Sim',
        inactiveLabel: 'Não',
        initialValue: true,
        footer: 'Use ← → para alternar e Enter para escolher',
      ),

      // --- 5. MULTI SELECT (Estilo INFO) ---
      // AJUSTE AQUI: Passamos 'myStyle' para herdar layout.
      MultiSelectStep(
        'Arquivos para .gitignore',
        id: 'git_ignore',
        description: 'Quais arquivos você quer ignorar?',
        options: [
          '.env',
          'build/',
          '.idea/',
          'dist/',
          '*.log',
          'node_modules/',
        ],
        minSelection: 1,
        footer: 'Espaço marca/desmarca, Enter finaliza',
        condition: (results) {
          return results['use_git'] == true;
        },
      ),

      // --- 6. INFO STEP (PAUSA) ---
      InfoStep(
        'Revisão',
        id: 'info_review',
        description: 'Tudo pronto. Pressione Enter para instalar.',
        waitForEnter: true,
        // style: StepPresets.highlight(myStyle),
        footer: 'Pressione Enter para continuar',
      ),

      // --- 7. FUTURE STEP (Estilo SUCCESS) ---
      // AJUSTE AQUI: Passamos 'myStyle' para herdar layout.
      FutureStep(
        'Instalando dependências...',
        id: 'installing',
        loadingText: 'Baixando pacotes da internet...',
        spinner: 'dots',
        // style: StepPresets.success(myStyle),
        footer: 'Por favor, aguarde o processamento...',
        task: () async {
          await Future.delayed(const Duration(seconds: 4));
          return 'Versão 1.0.0 instalada';
        },
      ),
    ],
  );

  // ---------------------------------------------------------
  // 3. EXECUÇÃO
  // ---------------------------------------------------------
  try {
    final results = await wizard.run();
    print('\n📦 RESULTADOS FINAIS:');
    print(results);
  } catch (e) {
    // Agora o exit(0) no wizard deve tratar a saída, mas caso algo escape:
    print('Encerrado.');
  }
}
