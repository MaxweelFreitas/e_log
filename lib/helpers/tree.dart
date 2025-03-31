class Tree {
  static String genTreeByMap(Map<String, dynamic> tree,
      {String indent = '',
      int lineLength = 80,
      String branchLast = '└─',
      String branchMid = '├─',
      String verticalLine = '│ ',
      String divider = '│',
      String branchLastColor = '\x1B[36m', // Default cyan color
      String branchMidColor = '\x1B[36m', // Default cyan color
      String verticalLineColor = '\x1B[36m', // Default cyan color
      String dividerColor = '\x1B[37m', // Default white color
      String dotColor = '\x1B[36m', // Default cyan color for '.'
      String textColor = '\x1B[37m', // Default white color for text
      String resetColor = '\x1B[0m' // Reset to default color
      }) {
    final buffer = StringBuffer();

    // Function to get the display length of a string considering ANSI codes
    int displayLength(String text) {
      final ansiEscapeCodePattern = RegExp(r'\x1B\[\d+([;\d+]*)m');
      return text.replaceAll(ansiEscapeCodePattern, '').length;
    }

    // Function to print the warning message
    void printWarningMessage() {
      const message1 = 'Insufficient space';

      final totalLineLength = lineLength;

      // Function to print a line with dividers and message centered
      String formatLine(String message) {
        final messageLength = displayLength(message);
        final paddingLength = (totalLineLength - messageLength) - 1;
        final padding = ' ' * paddingLength;
        final line =
            '$dividerColor$divider$resetColor $message$padding$dividerColor$divider$resetColor';
        // Ensure line length is consistent
        return line.padRight(totalLineLength);
      }

      // Print the warning message with necessary line breaks
      final lines = <String>[];
      final maxMessageLength = totalLineLength - 2;
      for (var i = 0; i < message1.length; i += maxMessageLength) {
        final end = (i + maxMessageLength < message1.length)
            ? i + maxMessageLength
            : message1.length;
        lines.add(formatLine(message1.substring(i, end)));
      }

      buffer.writeln(lines.join('\n'));
    }

    void printNode(
      String name,
      dynamic value,
      String currentIndent, {
      bool isLast = false,
    }) {
      final branch = isLast
          ? '$branchLastColor$branchLast$resetColor'
          : '$branchMidColor$branchMid$resetColor';
      final vertical = '$verticalLineColor$verticalLine$resetColor';
      final branchLength = displayLength(branch);

      final contentPrefix = '$currentIndent$branch';
      final contentLength = displayLength('$contentPrefix$name');

      // Calculate the total line length including dividers
      final hasDivider = divider.isNotEmpty;
      final dividerPadding = hasDivider ? 2 : 0;
      final totalLineLength =
          lineLength - dividerPadding; // Subtract space for dividers

      if (contentLength > totalLineLength) {
        printWarningMessage();
        return; // Exit the function after printing the warning
      } else {
        // Ensure the content fits within the line length
        final lineContent = '$contentPrefix$name';
        if (displayLength(lineContent) > totalLineLength) {
          final maxChunkLength =
              totalLineLength - branchLength - currentIndent.length;

          for (var i = 0; i < lineContent.length; i += maxChunkLength) {
            final end = (i + maxChunkLength <= lineContent.length)
                ? i + maxChunkLength
                : lineContent.length;
            final chunk = lineContent.substring(i, end);

            buffer.writeln(
                '${hasDivider ? '$dividerColor$divider$resetColor ' : ''}$chunk${' ' * (totalLineLength - displayLength(chunk))}${hasDivider ? ' $dividerColor$divider$resetColor' : ''}');
          }
        } else {
          // Pad the line to ensure it meets the totalLineLength
          final paddingLength =
              totalLineLength - displayLength('$contentPrefix$name');
          buffer.writeln(
              '${hasDivider ? '$dividerColor$divider$resetColor ' : ''}$contentPrefix$textColor$name$resetColor${' ' * paddingLength}${hasDivider ? ' $dividerColor$divider$resetColor' : ''}');
        }

        if (value is Map<String, dynamic>) {
          final newIndent = currentIndent + (isLast ? '    ' : vertical);
          value.forEach((key, val) {
            final lastChild = value.keys.last == key;
            printNode(key, val, newIndent, isLast: lastChild);
          });
        }
      }
    }

    // Print the root node with the initial indentation and color for '.'
    final rootLine =
        '${divider.isNotEmpty ? '$dividerColor$divider$resetColor ' : ''}$dotColor.$resetColor${' ' * (lineLength - displayLength('${divider.isNotEmpty ? '$dividerColor$divider$resetColor ' : ''}$dotColor.$resetColor'))}${divider.isNotEmpty ? ' $dividerColor$divider$resetColor' : ''}';
    buffer.writeln(rootLine);

    tree.forEach((key, value) {
      final isLast = tree.keys.last == key;
      printNode(key, value, indent, isLast: isLast);
    });

    return buffer.toString();
  }
}
