import '../../core/base/e_log.dart';

/// A utility class for injecting and replacing text within a given string.
///
/// This class provides methods to inject text before or after specific keywords,
/// between two keywords, and also allows replacing words at specific positions
/// or replacing all occurrences of a word in the text. Regular expressions
/// can be optionally provided to customize the replacement behavior.
class InjectStr {
  /// Injects the string [toInject] before the first occurrence of [keyword].
  ///
  /// The [text] parameter is the original string where the injection will occur.
  /// If the [keyword] is found, the method returns the text with [toInject] inserted
  /// before the [keyword]. If the [keyword] is not found, the original text is returned.
  ///
  /// Example:
  /// ```
  /// String result = InjectStr.before("I love Dart!", "Dart", "Flutter");
  /// print(result); // Output: "I love Flutter Dart!"
  /// ```
  static String before(String text, String keyword, String toInject) {
    int index = text.indexOf(keyword);
    if (index == -1) {
      return text; // If keyword is not found, return original text
    }
    return text.substring(0, index) + toInject + text.substring(index);
  }

  /// Injects the string [toInject] after the first occurrence of [keyword].
  ///
  /// The [text] parameter is the original string where the injection will occur.
  /// If the [keyword] is found, the method returns the text with [toInject] inserted
  /// after the [keyword]. If the [keyword] is not found, the original text is returned.
  ///
  /// Example:
  /// ```
  /// String result = InjectStr.after("I love Dart!", "love", " and Flutter");
  /// print(result); // Output: "I love Dart and Flutter!"
  /// ```
  static String after(String text, String keyword, String toInject) {
    int index = text.indexOf(keyword);
    if (index == -1) {
      return text; // If keyword is not found, return original text
    }
    return text.substring(0, index + keyword.length) +
        toInject +
        text.substring(index + keyword.length);
  }

  /// Injects the string [toInject] between the first occurrences of [keywordBefore] and [keywordAfter].
  ///
  /// The [text] parameter is the original string where the injection will occur.
  /// The method inserts [toInject] between the first occurrence of [keywordBefore]
  /// and [keywordAfter]. If any of the keywords are not found, the original text is returned.
  ///
  /// Example:
  /// ```
  /// String result = InjectStr.between("I love Dart and Flutter.", "love", "and", "and React");
  /// print(result); // Output: "I love and React Dart and Flutter."
  /// ```
  @Deprecated('It bug when use with customWord')
  static String between(
    String text,
    String keywordBefore,
    String keywordAfter,
    String modIn, {
    String modOut = '\x1B[0m', // Reset color
  }) {
    // Encontrar as posições das palavras-chave
    int startIndex = text.indexOf(keywordBefore);
    int endIndex =
        text.indexOf(keywordAfter, startIndex + keywordBefore.length);

    // Verificar se as palavras-chave foram encontradas
    if (startIndex == -1 || endIndex == -1) {
      return text; // Se não encontrar, retorna o texto original
    }

    // Extrair o conteúdo entre as palavras-chave
    String contentBetween =
        text.substring(startIndex + keywordBefore.length, endIndex);

    // Aplica o modificador de início e fim ao conteúdo
    String modifiedContent = modIn + contentBetween + modOut;

    // Retorna o texto com o conteúdo modificado entre as palavras-chave
    return text.substring(0, startIndex + keywordBefore.length) +
        modifiedContent +
        text.substring(endIndex);
  }

  /// Replaces the nth occurrence of a word in the text with a new word.
  ///
  /// The [text] parameter is the original string where the word replacement will occur.
  /// The [word] parameter is the word to replace, [newWord] is the word that will
  /// replace it, and [position] is the occurrence index to replace (starting from 0).
  /// If the word occurs more than [position] times, it will be replaced at the given index.
  ///
  /// You can optionally pass a [regex] to modify the search behavior.
  ///
  /// Example:
  /// ```
  /// String result = InjectStr.replaceAtPosition("I love Dart and Dart is great.", "Dart", "Flutter", 1);
  /// print(result); // Output: "I love Dart and Flutter is great."
  /// ```
  static String replaceAtPosition(
      String text, String word, String newWord, int position,
      {RegExp? regex}) {
    RegExp regExp = regex ?? RegExp(r'\b' + RegExp.escape(word) + r'\b');
    Iterable<Match> matches = regExp.allMatches(text);

    int count = 0;
    for (var match in matches) {
      if (count == position) {
        text = text.replaceRange(match.start, match.end, newWord);
        break;
      }
      count++;
    }
    return text;
  }

  /// Customizes a word at a specified position in a given text by wrapping it
  /// with the provided modifiers. The customization can be applied to either a
  /// specific line or all lines in the text.
  ///
  /// - [text]: The input text to be modified.
  /// - [word]: The word to be customized.
  /// - [position]: The position of the match in the line to apply the modification to.
  /// - [modIn]: The string to be inserted before the word.
  /// - [modOut]: The string to be inserted after the word.
  /// - [line]: The line number (0-indexed) where the modification should occur. Defaults to 0.
  /// - [allLines]: If true, applies the modification to all lines. Defaults to false.
  ///
  /// Returns the modified text.
  static String customWord(
    String text,
    String word, // Palavra ou caractere passado pelo usuário
    int position,
    String modIn, {
    String modOut = '', // Reset color
    int line = 0,
    bool allLines = false,
  }) {
    // Split the text into lines
    List<String> lines = text.split('\n');

    /// Helper function to process a single line and apply word/character modification.
    String processLine(String lineText, int position) {
      // Create a RegExp with case sensitivity and Unicode enabled
      RegExp regExp = RegExp(
        RegExp.escape(word), // Escape any special characters in the word
        unicode: true,
      );
      Iterable<Match> matches = regExp.allMatches(lineText);
      List<Match> matchList = matches.toList();

      // If the position is valid, apply modification to the matched word/character at that position
      if (matchList.isNotEmpty && position < matchList.length) {
        Match match = matchList[position];
        String customizedMatch = modIn + match.group(0)! + modOut;
        lineText =
            lineText.replaceRange(match.start, match.end, customizedMatch);
      }

      return lineText;
    }

    // Create a new list of lines to avoid modifying the original list
    List<String> modifiedLines = List.from(lines);

    // Apply the modification to all lines if specified, otherwise to a specific line
    if (allLines) {
      for (int i = 0; i < modifiedLines.length; i++) {
        modifiedLines[i] = processLine(modifiedLines[i], position);
      }
    } else {
      if (line >= 0 && line < modifiedLines.length) {
        // Apply modification to the specified line only
        modifiedLines[line] = processLine(modifiedLines[line], position);
      }
    }

    // Join the modified lines back into a single text string
    return modifiedLines.join('\n');
  }

  static String customChar(
    String text,
    String word, // Palavra ou caractere passado pelo usuário
    String modIn, {
    String modOut = '', // Reset color
  }) {
    // Substitui todas as ocorrências da palavra ou caractere com a formatação
    return text.replaceAll(word, '$modIn$word$modOut');
  }

  static String customBorder(String text, String modIn, String modOut) {
    // Separa o texto em linhas
    List<String> linhas = text.split('\n');

    // Aplica a customização na primeira linha
    if (linhas.isNotEmpty) {
      String primeiraLinha = linhas[0];
      if (primeiraLinha.isNotEmpty) {
        linhas[0] =
            primeiraLinha.split('').map((char) => '$modIn$char$modOut').join();
      }

      // Aplica a customização na última linha
      if (linhas.length > 1) {
        String ultimaLinha = linhas[linhas.length - 1];
        if (ultimaLinha.isNotEmpty) {
          linhas[linhas.length - 1] =
              ultimaLinha.split('').map((char) => '$modIn$char$modOut').join();
        }
      }
    }

    // Aplica a customização para as linhas intermediárias (primeiro e último caractere)
    for (int i = 1; i < linhas.length - 1; i++) {
      String linha = linhas[i];

      if (linha.isNotEmpty) {
        String primeiraParte = '$modIn${linha[0]}$modOut';
        String ultimaParte = '$modIn${linha[linha.length - 1]}$modOut';

        // Se a linha tem mais de um caractere, combina a primeira e última parte com o meio da linha
        if (linha.length > 1) {
          linhas[i] =
              '$primeiraParte${linha.substring(1, linha.length - 1)}$ultimaParte';
        } else {
          // Caso a linha tenha apenas um caractere, aplica os modificadores nele
          linhas[i] = '$primeiraParte$ultimaParte';
        }
      }
    }

    // Junta novamente todas as linhas em uma única string
    return linhas.join('\n');
  }

  static String betweenA(
    String text,
    String keywordBefore,
    String keywordAfter,
    String modIn, {
    String modOut = '\x1B[0m', // Reset color
    int? line, // Linha onde começar a busca (nulo se não for especificado)
    int?
        position, // Posição da incidência inicial (nulo se não for especificado)
    bool allIncidences =
        true, // Se true, retorna todas as incidências, caso contrário, retorna uma
  }) {
    // Função para remover temporariamente as sequências ANSI
    String removeAnsi(String input) {
      return input.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');
    }

    // Limpeza do texto para procurar palavras-chave sem interferência das ANSI
    String cleanedText = removeAnsi(text);

    // Lista para armazenar todas as incidências encontradas
    List<String> contentsBetween = [];
    List<Map<String, int>> positions =
        []; // Para armazenar as posições de início e fim

    int startIndex = 0;
    int startLineIndex = 0;

    // Procurando as incidências linha por linha
    while (true) {
      // Encontrar o próximo índice da keywordBefore
      startIndex = cleanedText.indexOf(keywordBefore, startIndex);
      if (startIndex == -1) break; // Se não encontrar mais, sai do loop

      int endIndex =
          cleanedText.indexOf(keywordAfter, startIndex + keywordBefore.length);
      if (endIndex == -1) break; // Se não encontrar a keywordAfter, sai do loop

      // Calcular a linha atual com base no número de quebras de linha
      String substring = cleanedText.substring(startLineIndex, startIndex);
      int currentLine = substring.split('\n').length;

      // Se a linha atual é maior ou igual à linha desejada, extrair o conteúdo
      if (line == null || currentLine >= line) {
        String contentBetween =
            cleanedText.substring(startIndex + keywordBefore.length, endIndex);
        contentsBetween.add(contentBetween);

        // Armazenar as posições de início e fim no texto original
        positions.add({
          'start': startIndex + modIn.length, // Incluindo o modIn no cálculo
          'end': endIndex + modOut.length, // Incluindo o modOut no cálculo
        });
      }

      // Avança o índice para a próxima busca
      startLineIndex = endIndex + keywordAfter.length;
      startIndex = startLineIndex;
    }

    // Filtrando com base na posição e no parâmetro allIncidences
    if (contentsBetween.isEmpty) {
      return text; // Se não encontrar nenhuma incidência, retorna o texto original
    }

    // Se não for especificado um position, retorna a primeira incidência
    position ??= 0;

    // Imprimir as posições
    for (int i = 0; i < positions.length; i++) {
      eLog(
          'Incidência ${i + 1}: Início: ${positions[i]['start']}, Fim: ${positions[i]['end']}');
    }

    eLog(text.substring(80 + keywordBefore.length, 99 + 5));
    eLog('$modIn${text.substring(84 + keywordBefore.length, 99 + 5)}$modOut');

    //$modIn${linha[0]}$modOut'

    // Filtrar a incidência com base na posição
    if (!allIncidences) {
      // Retorna apenas a incidência na posição desejada
      return contentsBetween.length > position ? contentsBetween[position] : '';
    }

    // Retorna todas as incidências encontradas
    return contentsBetween.join('\n'); // Ou outro formato desejado
  }

  static List<Map<String, dynamic>> findAnsiColors(String text) {
    // Regex para encontrar sequências de cores ANSI
    final ansiRegex = RegExp(r'\x1B\[[0-9;]*m');

    // Lista para armazenar as correspondências e suas posições
    List<Map<String, dynamic>> matches = [];

    // Itera sobre todas as correspondências na string
    for (final match in ansiRegex.allMatches(text)) {
      matches.add({
        'sequence': match.group(0), // Sequência de cor encontrada
        'start': match.start, // Posição inicial
        'end': match.end // Posição final
      });
    }

    final t = text.substring(110, 127);
    eLog(t);

    return matches;
  }

  static String betweenAnsi(
    String text,
    String keywordBefore,
    String keywordAfter,
    String modIn, {
    String modOut = '\x1B[0m',
    int? line,
    int? position,
    bool allIncidences = true,
  }) {
    List<Map<String, dynamic>> ansiMatches = findAnsiColors(text);

    StringBuffer modifiedText = StringBuffer();
    int lastIndex = 0;

    for (var i = 0; i < ansiMatches.length; i++) {
      var currentMatch = ansiMatches[i];

      // Adicionar texto antes do código ANSI atual
      modifiedText.write(text.substring(lastIndex, currentMatch['start']));

      // Verificar se há keywords antes e depois do código ANSI atual
      String segmentBeforeAnsi =
          text.substring(lastIndex, currentMatch['start']);
      String segmentAfterAnsi = i < ansiMatches.length - 1
          ? text.substring(currentMatch['end'], ansiMatches[i + 1]['start'])
          : text.substring(currentMatch['end']);

      bool beforeMatch = segmentBeforeAnsi.contains(keywordBefore);
      bool afterMatch = segmentAfterAnsi.contains(keywordAfter);

      // Aplicar modificadores se os keywords forem encontrados
      if (beforeMatch && afterMatch) {
        modifiedText.write(modIn);
        modifiedText.write(currentMatch['sequence']);
        modifiedText.write(modOut);
      } else {
        // Manter o código ANSI sem alterações
        modifiedText.write(currentMatch['sequence']);
      }

      lastIndex = currentMatch['end'];
    }

    // Adicionar o restante do texto após o último código ANSI
    modifiedText.write(text.substring(lastIndex));

    return modifiedText.toString();
  }
}

void main() {
  // Example text
  String text = 'I love Dart, Dart is great! I also enjoy Dart.';

  // 1. Using 'before' method
  String resultBefore = InjectStr.before(text, 'Dart', 'Flutter');
  // Output: "I love Flutter Dart, Dart is great! I also enjoy Dart."
  eLog(resultBefore);

  // 2. Using 'after' method
  String resultAfter = InjectStr.after(text, 'love', ' and Flutter');
  // Output: "I love Dart and Flutter, Dart is great! I also enjoy Dart."
  eLog(resultAfter);

  // 3. Using 'between' method
  String resultBetween = InjectStr.between(text, 'love', 'and', 'and React');
  // Output: "I love and React Dart, Dart is great! I also enjoy Dart."
  eLog(resultBetween);

  // 4. Using 'replaceAtPosition' method with default regex
  String resultReplaceAtPosition = InjectStr.replaceAtPosition(
    text,
    'Dart',
    'Flutter',
    1,
  );
  // Output: "I love Dart, Flutter is great! I also enjoy Dart."
  eLog(resultReplaceAtPosition);
}
