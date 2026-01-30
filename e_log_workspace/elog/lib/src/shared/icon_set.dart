/// Define conjuntos de ícones para os passos e seleções do Wizard.
class IconSet {
  /// Ícone do passo atual (ex: ➜ Passo 1)
  final String activeStep;

  /// Ícone de passo concluído (ex: ✓ Passo 1)
  final String completedStep;

  /// Cursor dentro da lista de seleção (ex: ❯ Opção A)
  final String selectionCursor;

  /// Checkbox marcado (ex: [x] ou ◉)
  final String selectedOption;

  /// Checkbox desmarcado (ex: [ ] ou ○)
  final String unselectedOption;

  const IconSet({
    required this.activeStep,
    required this.completedStep,
    required this.selectionCursor,
    required this.selectedOption,
    required this.unselectedOption,
  });

  /// Cria uma cópia com alterações pontuais.
  IconSet copyWith({
    String? activeStep,
    String? completedStep,
    String? selectionCursor,
    String? selectedOption,
    String? unselectedOption,
  }) {
    return IconSet(
      activeStep: activeStep ?? this.activeStep,
      completedStep: completedStep ?? this.completedStep,
      selectionCursor: selectionCursor ?? this.selectionCursor,
      selectedOption: selectedOption ?? this.selectedOption,
      unselectedOption: unselectedOption ?? this.unselectedOption,
    );
  }

  // ===========================================================================
  // 1. GERAIS E ESTRUTURAIS
  // ===========================================================================

  /// ➜ **Classic**: O padrão profissional.
  static const classic = IconSet(
    activeStep: '➜',
    completedStep: '✓',
    selectionCursor: '❯',
    selectedOption: '◉',
    unselectedOption: '○',
  );

  /// ● **Minimal**: Limpo e discreto.
  static const minimal = IconSet(
    activeStep: '●',
    completedStep: '✔',
    selectionCursor: '›',
    selectedOption: '✔',
    unselectedOption: '  ',
  );

  /// > **ASCII**: Compatibilidade máxima (Terminais antigos/Windows CMD).
  static const ascii = IconSet(
    activeStep: '>',
    completedStep: '+',
    selectionCursor: '→',
    selectedOption: '[x]',
    unselectedOption: '[ ]',
  );

  /// ▲ **Geometric**: Formas geométricas (Usado no tema Vercel).
  static const geometric = IconSet(
    activeStep: '▲',
    completedStep: '●',
    selectionCursor: '▶',
    selectedOption: '◼',
    unselectedOption: '◻',
  );

  /// ■ **Pixel**: Estilo bloco/retro (Usado nos temas Retro e Amber).
  static const pixel = IconSet(
    activeStep: '■',
    completedStep: '□',
    selectionCursor: '►',
    selectedOption: '█',
    unselectedOption: '░',
  );

  /// ● **Round**: Bolinhas sólidas (Usado como base para temas modernos).
  static const round = IconSet(
    activeStep: '●',
    completedStep: '•',
    selectionCursor: '➜',
    selectedOption: '●',
    unselectedOption: '○',
  );

  // ===========================================================================
  // 2. TEMÁTICOS (FORMAS E EMOJIS)
  // ===========================================================================

  /// ★ **Star**: Estrelas (Usado no tema Ubuntu/Yaru).
  static const star = IconSet(
    activeStep: '★',
    completedStep: '☆',
    selectionCursor: '➜',
    selectedOption: '★',
    unselectedOption: '☆',
  );

  /// 🔥 **Fire**: Chama e cinzas (Usado nos temas Fire e Meltdown).
  static const fire = IconSet(
    activeStep: '🔥',
    completedStep: '·',
    selectionCursor: '»',
    selectedOption: '»',
    unselectedOption: ' ',
  );

  /// ☁ **Cloud**: Nuvens (Usado no tema Cloud).
  static const cloud = IconSet(
    activeStep: '☁',
    completedStep: '✔',
    selectionCursor: '➜',
    selectedOption: '✔',
    unselectedOption: '  ',
  );

  /// ♥ **Lovely**: Corações (Usado no tema Candy).
  static const lovely = IconSet(
    activeStep: '♥',
    completedStep: '♡',
    selectionCursor: '❥',
    selectedOption: '♥',
    unselectedOption: '♡',
  );

  /// 🚀 **Emoji**: Ícones divertidos variados.
  static const emoji = IconSet(
    activeStep: '🚀',
    completedStep: '✨',
    selectionCursor: '👉',
    selectedOption: '✅',
    unselectedOption: '⬜',
  );

  // ===========================================================================
  // 3. SEMÂNTICOS (STATUS)
  // ===========================================================================

  /// ✓ **Success**: Focado em confirmação positiva.
  static const success = IconSet(
    activeStep: '✓',
    completedStep: '✓',
    selectionCursor: '❯',
    selectedOption: '✓',
    unselectedOption: '○',
  );

  /// ⚠ **Warning**: Alerta e atenção.
  static const warning = IconSet(
    activeStep: '⚠',
    completedStep: '!',
    selectionCursor: '❯',
    selectedOption: '!',
    unselectedOption: '○',
  );

  /// ✖ **Error**: Negação e falha.
  static const error = IconSet(
    activeStep: '✖',
    completedStep: '✖',
    selectionCursor: '❯',
    selectedOption: '✖',
    unselectedOption: '○',
  );
}
