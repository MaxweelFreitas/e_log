import 'dart:async';
import 'dart:io';
import 'dart:math';

import '../../base/x_term/x_term_color.dart';

import '../../utils/terminal_utils.dart';
import 'steps/info_steps.dart';
import 'steps/input_text_step.dart';
import 'style/e_wizard_style.dart';
import 'engine/input_reader.dart';

// Steps Imports
import 'steps/e_wizard_step.dart';
import 'steps/select_step.dart';
import 'steps/toggle_step.dart';
import 'steps/multi_select_step.dart';
import 'steps/future_step.dart';
import 'steps/message_step.dart';

class EWizardBuilder {
  final String title;
  final List<EWizardStep> steps;
  final EWizardStyle style;
  final String? endingMessage;
  final int? width;
  final int paddingTop;

  final _reader = InputReader();
  final Map<String, dynamic> _results = {};

  StreamSubscription? _resizeSubscription;
  StreamSubscription? _sigintSubscription;

  // Estado Global
  int _activeIndex = 0;
  bool _isInputMode = false;

  String? _validationError;
  bool _isRealTimeInvalid = false;

  // Estados Temporários
  int? _selectIndex;
  List<int>? _multiSelectIndices;
  bool? _toggleValue;
  String _currentTextInput = '';

  // Spinner
  Timer? _spinnerTimer;
  int _spinnerFrameIndex = 0;
  bool _isSpinnerActive = false;
  List<String> _currentSpinnerFrames = [];

  int _lastFrameHeight = 0;
  int _cursorVisualOffset = 0;

  EWizardBuilder({
    required this.title,
    required this.steps,
    this.endingMessage,
    this.width,
    this.paddingTop = 1,
    EWizardStyle? style,
  }) : style = style ?? const EWizardStyle();

  EWizardStyle _getStepStyle(EWizardStep step) {
    return step.style ?? style;
  }

  Future<Map<String, dynamic>> run() async {
    // 1. INICIALIZAÇÃO CENTRALIZADA
    Terminal.init();

    _reader.init();
    _initResizeListener();
    _initSigintListener();

    try {
      for (int i = 0; i < steps.length; i++) {
        _activeIndex = i;
        final step = steps[i];

        if (step.condition != null) {
          final shouldRun = step.condition!(_results);
          if (!shouldRun) {
            _results[step.id] = null;
            continue;
          }
        }

        _resetStepStates();
        dynamic result;

        if (step is InputTextStep) {
          result = await _runTextStep(step);
        } else if (step is ToggleStep) {
          result = await _runToggleStep(step);
        } else if (step is SelectStep) {
          result = await _runSelectStep(step);
        } else if (step is MultiSelectStep) {
          result = await _runMultiSelectStep(step);
        } else if (step is FutureStep) {
          result = await _runFutureStep(step);
        } else if (step is InfoStep) {
          await _runInfoStep(step);
          result = true;
        } else if (step is MessageStep) {
          await _runMessageStep(step);
          result = true;
        }

        _results[step.id] = result;
      }

      _activeIndex = -1;
      _render();
    } finally {
      // 2. LIMPEZA GARANTIDA
      _cleanup();
    }

    return _results;
  }

  // --- LIMPEZA ---
  void _cleanup() {
    // Limpa o offset visual específico do Wizard
    if (_cursorVisualOffset > 0) {
      stdout.write('\x1B[${_cursorVisualOffset}B\r');
      _cursorVisualOffset = 0;
    }

    _disposeResizeListener();
    _sigintSubscription?.cancel();
    _stopSpinner();
    _reader.dispose();

    // 3. RESTAURAÇÃO CENTRALIZADA
    // Restaura cursor, echo, line mode e cores
    Terminal.restore();
  }

  void _resetStepStates() {
    _isInputMode = false;
    _currentTextInput = '';
    _validationError = null;
    _isRealTimeInvalid = false;
    _selectIndex = null;
    _multiSelectIndices = null;
    _toggleValue = null;
    _stopSpinner();
    _cursorVisualOffset = 0;
  }

  void _initResizeListener() {
    if (!Platform.isWindows) {
      _resizeSubscription = ProcessSignal.sigwinch.watch().listen((_) {
        if (!_isSpinnerActive) _render();
      });
    }
  }

  void _initSigintListener() {
    _sigintSubscription = ProcessSignal.sigint.watch().listen((_) {
      _exitWizard();
    });
  }

  void _exitWizard() {
    // _cleanup chama Terminal.restore(), então o terminal volta ao normal aqui
    _cleanup();
    stdout.writeln(
        '\n${XTermColor.red}✖ Cancelado pelo usuário.${XTermColor.reset}');
    exit(0);
  }

  void _disposeResizeListener() {
    _resizeSubscription?.cancel();
  }

  void _startSpinner(FutureStep step) {
    _isSpinnerActive = true;
    _spinnerFrameIndex = 0;
    _spinnerTimer?.cancel();
    final spinnerSet = step.getResolvedSpinner();
    _currentSpinnerFrames = spinnerSet.frames.map((f) => f.value).toList();
    final interval = Duration(milliseconds: spinnerSet.intervalMs);
    _spinnerTimer = Timer.periodic(interval, (t) {
      _spinnerFrameIndex++;
      _render();
    });
  }

  void _stopSpinner() {
    _isSpinnerActive = false;
    _spinnerTimer?.cancel();
    _spinnerTimer = null;
  }

  // ===========================================================================
  // RUNNERS
  // ===========================================================================

  void _validateRealTime(InputTextStep step) {
    if (step.validator == null) {
      _isRealTimeInvalid = false;
      return;
    }
    final val = _currentTextInput.isEmpty
        ? (step.defaultValue ?? '')
        : _currentTextInput;
    final error = step.validator!(val);
    _isRealTimeInvalid = error != null;
  }

  Future<String> _runTextStep(InputTextStep step) async {
    _isInputMode = true;
    _currentTextInput = step.defaultValue ?? '';
    _validateRealTime(step);

    while (true) {
      _render();
      final result = await _reader.readKey();

      if (result.action == KeyAction.cancel) _exitWizard();

      if (result.action == KeyAction.enter) {
        final finalValue = _currentTextInput.isEmpty
            ? (step.defaultValue ?? '')
            : _currentTextInput;
        if (step.validator != null) {
          final error = step.validator!(finalValue);
          if (error != null) {
            _validationError = error;
            _isRealTimeInvalid = true;
            continue;
          }
        }
        _isInputMode = false;
        return finalValue;
      } else if (result.action == KeyAction.backspace) {
        if (_currentTextInput.isNotEmpty) {
          _currentTextInput =
              _currentTextInput.substring(0, _currentTextInput.length - 1);
          _validateRealTime(step);
        } else {
          _validateRealTime(step);
        }
      } else if (result.action == KeyAction.char ||
          result.action == KeyAction.space) {
        if (result.char != null) {
          _currentTextInput += result.char!;
          _validateRealTime(step);
        }
      }
    }
  }

  Future<bool> _runToggleStep(ToggleStep step) async {
    _toggleValue = step.initialValue;
    while (true) {
      _render();
      final res = await _reader.readKey();
      if (res.action == KeyAction.cancel) _exitWizard();

      if (res.action == KeyAction.left || res.action == KeyAction.right) {
        _toggleValue = !_toggleValue!;
      } else if (res.action == KeyAction.enter) {
        return _toggleValue!;
      }
    }
  }

  Future<String> _runSelectStep(SelectStep step) async {
    _selectIndex = 0;
    while (true) {
      _render();
      final res = await _reader.readKey();
      if (res.action == KeyAction.cancel) _exitWizard();

      if (res.action == KeyAction.up) {
        _selectIndex = (_selectIndex! - 1).clamp(0, step.options.length - 1);
      } else if (res.action == KeyAction.down) {
        _selectIndex = (_selectIndex! + 1).clamp(0, step.options.length - 1);
      } else if (res.action == KeyAction.enter) {
        return step.options[_selectIndex!];
      }
    }
  }

  Future<List<String>> _runMultiSelectStep(MultiSelectStep step) async {
    _selectIndex = 0;
    _multiSelectIndices = List.from(step.initialSelections);
    while (true) {
      _render();
      final res = await _reader.readKey();
      if (res.action == KeyAction.cancel) _exitWizard();

      if (res.action == KeyAction.up) {
        _selectIndex = (_selectIndex! - 1).clamp(0, step.options.length - 1);
      } else if (res.action == KeyAction.down) {
        _selectIndex = (_selectIndex! + 1).clamp(0, step.options.length - 1);
      } else if (res.action == KeyAction.space) {
        if (_multiSelectIndices!.contains(_selectIndex)) {
          _multiSelectIndices!.remove(_selectIndex);
        } else {
          _multiSelectIndices!.add(_selectIndex!);
        }
      } else if (res.action == KeyAction.enter) {
        if (_multiSelectIndices!.length < step.minSelection) {
          _validationError =
              'Selecione pelo menos ${step.minSelection} opções.';
          continue;
        }
        if (_multiSelectIndices!.length > step.maxSelection) {
          _validationError =
              'Máximo de ${step.maxSelection} opções permitidas.';
          continue;
        }
        return _multiSelectIndices!.map((i) => step.options[i]).toList();
      }
    }
  }

  Future<dynamic> _runFutureStep(FutureStep step) async {
    _startSpinner(step);
    await Future.delayed(Duration.zero);
    try {
      final result = await step.task();
      _stopSpinner();
      return result;
    } catch (e) {
      _stopSpinner();
      rethrow;
    }
  }

  Future<void> _runInfoStep(InfoStep step) async {
    _render();
    if (step.waitForEnter) {
      final res = await _reader.readKey();
      if (res.action == KeyAction.cancel) _exitWizard();
    }
  }

  Future<void> _runMessageStep(MessageStep step) async {
    _render();
    final res = await _reader.readKey();
    if (res.action == KeyAction.cancel) _exitWizard();
  }

  // ===========================================================================
  // RENDERER
  // ===========================================================================

  void _render() {
    if (_lastFrameHeight > 0) {
      stdout.write('\x1B[${_lastFrameHeight}A\r\x1B[0J');
    }

    final buffer = StringBuffer();
    _cursorVisualOffset = 0;

    if (paddingTop > 0) {
      buffer.write('\n' * paddingTop);
    }

    _writeHeader(buffer);

    final limit = _activeIndex == -1 ? steps.length : _activeIndex + 1;

    for (int i = 0; i < limit; i++) {
      final step = steps[i];
      if (i < _activeIndex && _results[step.id] == null) continue;
      _renderSingleStep(buffer, i, step, i == limit - 1);
    }

    // --- Footer Logic ---
    if (_activeIndex == -1) {
      if (endingMessage != null && endingMessage!.isNotEmpty) {
        _writeFooter(buffer, endingMessage!, style);
      } else {
        if (style.treeLineChar.trim().isNotEmpty) {
          buffer.writeln(
              '${style.completedColor}${style.border.bottomLeft}${XTermColor.reset}');
        }
      }
    } else {
      final currentStep = steps[_activeIndex];
      final currentStyle = _getStepStyle(currentStep);
      String? footerText = currentStep.footer;

      if (currentStep is InputTextStep && footerText == null && _isInputMode) {
        footerText = 'Digite e pressione Enter';
      }

      if (footerText != null) {
        if (_isInputMode) {
          final hasTreeLine = currentStyle.treeLineChar.trim().isNotEmpty;

          if (hasTreeLine) {
            final isError = currentStep is InputTextStep && _isRealTimeInvalid;
            final treeColor =
                isError ? currentStyle.errorColor : currentStyle.completedColor;
            buffer.writeln(
                '$treeColor${currentStyle.treeLineChar}${XTermColor.reset}');
          }

          _writeFooter(buffer, footerText, currentStyle);
        } else {
          _writeFooter(buffer, footerText, currentStyle);
        }
      } else {
        if (!_isInputMode && currentStyle.treeLineChar.trim().isNotEmpty) {
          buffer.writeln(
              '${currentStyle.completedColor}${currentStyle.border.bottomLeft}${XTermColor.reset}');
        }
      }
    }

    final output = buffer.toString();
    _lastFrameHeight = '\n'.allMatches(output).length;

    if (_isInputMode) {
      stdout.write(output);
    } else {
      if (output.endsWith('\n')) {
        stdout.write(output.substring(0, output.length - 1));
        print('');
      } else {
        print(output);
      }
    }
  }

  void _renderSingleStep(
      StringBuffer b, int index, EWizardStep step, bool isLast) {
    final s = _getStepStyle(step);
    final isCompleted = _activeIndex == -1 ? true : index < _activeIndex;
    final isActive = _activeIndex == -1 ? false : index == _activeIndex;

    // =========================================================
    // LÓGICA ESPECIAL PARA MESSAGE STEP (A CAIXA)
    // =========================================================
    if (step is MessageStep && isActive) {
      _writeMessage(b, step.content, s);
      return;
    }
    // =========================================================

    final bool isErrorState =
        isActive && step is InputTextStep && _isRealTimeInvalid;
    final treeColor = isErrorState ? s.errorColor : s.completedColor;
    final activeItemColor = isErrorState ? s.errorColor : s.activeColor;

    final hasTreeLine = s.treeLineChar.trim().isNotEmpty;
    final treeChar = hasTreeLine ? s.treeLineChar : '';
    final indent = hasTreeLine ? '$treeChar   ' : '   ';

    if (isActive &&
        step is FutureStep &&
        _isSpinnerActive &&
        _currentSpinnerFrames.isNotEmpty) {
      final frame = _currentSpinnerFrames[
          _spinnerFrameIndex % _currentSpinnerFrames.length];
      b.writeln(
          '${s.activeColor}$frame  ${s.stepTitleColor}${step.loadingText}${XTermColor.reset}');
    } else {
      final icon = isCompleted
          ? s.icons.completedStep
          : (isActive ? s.icons.activeStep : ' ');
      final iconColor = isCompleted ? s.completedColor : activeItemColor;
      final titleColor = isActive
          ? s.stepTitleColor
          : (isCompleted ? s.completedStepTitleColor : XTermColor.brightBlack);
      b.writeln('$iconColor$icon  $titleColor${step.title}${XTermColor.reset}');
    }

    if ((isActive || step is InfoStep) &&
        step.description != null &&
        !(step is FutureStep && isActive)) {
      b.writeln(
          '$treeColor$indent${XTermColor.brightBlack}${step.description}${XTermColor.reset}');
    }

    if (isCompleted) {
      final val = _results[step.id];
      if (step is MessageStep) {
        // Gap opcional
      } else {
        String displayVal = '$val';
        if (val is List) displayVal = val.join(', ');
        if (val is bool) displayVal = val ? 'Sim' : 'Não';
        b.writeln(
            '${s.completedColor}$indent${XTermColor.brightBlack}$displayVal${XTermColor.reset}');
      }
    } else if (isActive) {
      if (_validationError != null) {
        b.writeln(
            '$treeColor$indent${XTermColor.red}⚠ $_validationError${XTermColor.reset}');
      }

      if (step is InputTextStep) {
        int maxW =
            width ?? (stdout.hasTerminal ? stdout.terminalColumns - 10 : 70);
        maxW -= 6;

        final lines = _wrapText(
            _currentTextInput.isEmpty && step.placeholder != null
                ? step.placeholder!
                : _currentTextInput,
            maxW);
        final isPlaceholder = _currentTextInput.isEmpty;
        final txtColor = isPlaceholder
            ? XTermColor.brightBlack
            : (isErrorState ? s.errorColor : XTermColor.reset);

        for (int k = 0; k < lines.length; k++) {
          final prefix = k == 0 ? '$activeItemColor> ' : '  ';
          final cursor = (k == lines.length - 1 && !isPlaceholder)
              ? '$activeItemColor█${XTermColor.reset}'
              : '';
          b.writeln(
              '$treeColor$indent$prefix$txtColor${lines[k]}${XTermColor.reset}$cursor');
        }
      } else if (step is ToggleStep) {
        final onStyle =
            _toggleValue! ? s.selectionHighlightColor : XTermColor.brightBlack;
        final offStyle =
            !_toggleValue! ? s.selectionHighlightColor : XTermColor.brightBlack;
        final tStr = _toggleValue!
            ? '$onStyle[ ${step.activeLabel} ]${XTermColor.reset}  ${step.inactiveLabel}'
            : '${step.activeLabel}  $offStyle[ ${step.inactiveLabel} ]${XTermColor.reset}';
        b.writeln('${s.completedColor}$indent$tStr');
      } else if (step is SelectStep) {
        for (int j = 0; j < step.options.length; j++) {
          final isSel = j == _selectIndex;

          final cursorStr = isSel
              ? '${s.activeColor}${s.icons.selectionCursor}${XTermColor.reset}'
              : ' ';

          final bullet =
              isSel ? s.icons.selectedOption : s.icons.unselectedOption;
          final color =
              isSel ? s.selectionHighlightColor : XTermColor.brightBlack;
          b.writeln(
              '${s.completedColor}$treeChar $cursorStr $color$bullet ${step.options[j]}${XTermColor.reset}');
        }
      } else if (step is MultiSelectStep) {
        for (int j = 0; j < step.options.length; j++) {
          final isCursor = j == _selectIndex;
          final isChecked = _multiSelectIndices!.contains(j);

          final cursorStr = isCursor
              ? '${s.activeColor}${s.icons.selectionCursor}${XTermColor.reset}'
              : ' ';

          final checkIcon =
              isChecked ? s.icons.selectedOption : s.icons.unselectedOption;
          final color = isCursor
              ? s.selectionHighlightColor
              : (isChecked ? XTermColor.white : XTermColor.brightBlack);

          b.writeln(
              '${s.completedColor}$treeChar $cursorStr $color$checkIcon ${step.options[j]}${XTermColor.reset}');
        }
        b.writeln(
            '${s.completedColor}$indent${XTermColor.brightBlack}(Espaço p/ marcar, Enter confirma)${XTermColor.reset}');
      }
    }

    if (!isLast || isActive) {
      if (isActive && step is MessageStep) {
        // Gap
      } else if (isActive && step is InputTextStep) {
        // Gap
      } else {
        if (hasTreeLine) {
          final connColor = (isActive && _isRealTimeInvalid)
              ? s.errorColor
              : s.completedColor;
          b.writeln('$connColor$treeChar${XTermColor.reset}');
        }
      }
    }
  }

  void _writeHeader(StringBuffer b) {
    final s = style;
    final bColor = s.bannerBorderColor;
    final tColor = s.bannerTextColor;
    final treeColor = s.completedColor;
    const reset = XTermColor.reset;
    final border = s.border;

    if (s.bannerStyle == WizardBoxStyle.bracketSide) {
      b.writeln(
          '$treeColor${border.topLeft}$bColor[ $tColor$title $bColor]$reset');
    } else if (s.bannerStyle == WizardBoxStyle.box) {
      b.writeln(
          '$treeColor${border.topLeft}$bColor${border.top}[ $tColor$title $bColor]$reset');
    } else if (s.bannerStyle == WizardBoxStyle.none) {
      b.writeln('$tColor$title$reset');
    } else {
      b.writeln('${s.bannerBackgroundColor}$tColor  $title  $reset');
    }

    if (s.treeLineChar.trim().isNotEmpty) {
      b.writeln('${s.completedColor}${s.treeLineChar}${XTermColor.reset}');
    } else {
      b.writeln();
    }
  }

  void _writeFooter(StringBuffer b, String text, EWizardStyle s) {
    final bColor = s.footerBorderColor;
    final tColor = s.footerTextColor;
    final treeColor = s.completedColor;
    const reset = XTermColor.reset;
    final border = s.border;

    if (s.footerStyle == WizardBoxStyle.bracketSide) {
      b.writeln(
          '$treeColor${border.bottomLeft}$bColor[ $tColor$text $bColor]$reset');
    } else if (s.footerStyle == WizardBoxStyle.box) {
      b.writeln(
          '$treeColor${border.bottomLeft}$bColor${border.top}[ $tColor$text $bColor]$reset');
    } else if (s.footerStyle == WizardBoxStyle.none) {
      if (s.treeLineChar.trim().isNotEmpty) {
        b.writeln('$treeColor${border.bottomLeft} $tColor$text$reset');
      } else {
        b.writeln('\n$tColor$text$reset');
      }
    } else {
      b.writeln('$treeColor${s.treeLineChar}$reset');
      b.writeln('$reset${s.footerBackgroundColor}$tColor  $text  $reset');
    }
  }

  void _writeMessage(StringBuffer b, String text, EWizardStyle s) {
    if (!s.renderMessageBox) {
      final lines = _wrapText(text, width ?? 80);
      for (final line in lines) {
        b.writeln(
            '${s.completedColor}${s.treeLineChar}   ${s.messageTextColor}$line$XTermColor.reset');
      }
      if (s.treeLineChar.trim().isNotEmpty) {
        b.writeln('${s.completedColor}${s.treeLineChar}${XTermColor.reset}');
      } else {
        b.writeln();
      }
      return;
    }

    final borderColor = s.messageBorderColor;
    final textColor = s.messageTextColor;
    final border = s.border;

    int maxAllowedWidth =
        width ?? (stdout.hasTerminal ? stdout.terminalColumns - 6 : 80);
    maxAllowedWidth -= 8;

    final rawLines = text.split('\n');
    final List<String> lines = [];
    for (var rawLine in rawLines) {
      lines.addAll(_wrapText(rawLine, maxAllowedWidth));
    }

    int contentWidth = 0;
    for (var line in lines) {
      final len = _visualLength(line);
      if (len > contentWidth) contentWidth = len;
    }
    if (width == null) {
      contentWidth = max(contentWidth, 20);
    } else {
      contentWidth = maxAllowedWidth;
    }

    final topBorderLine = border.top * (contentWidth + 2);
    final bottomBorderLine = border.top * (contentWidth + 2);

    final hasTreeLine = s.treeLineChar.trim().isNotEmpty;
    final treeChar = hasTreeLine ? s.treeLineChar : '';
    final indent = hasTreeLine ? '$treeChar   ' : '   ';

    b.writeln(
        '${s.completedColor}$indent$borderColor${border.topLeft}$topBorderLine${border.topRight}${XTermColor.reset}');

    for (final line in lines) {
      final len = _visualLength(line);
      final paddingRight = contentWidth - len;
      final padStr = ' ' * paddingRight;

      b.writeln(
          '${s.completedColor}$indent$borderColor${border.vertical} $textColor$line$padStr $borderColor${border.vertical}${XTermColor.reset}');
    }

    b.writeln(
        '${s.completedColor}$indent$borderColor${border.bottomLeft}$bottomBorderLine${border.bottomRight}${XTermColor.reset}');

    if (hasTreeLine) {
      b.writeln('${s.completedColor}$treeChar${XTermColor.reset}');
    }
  }

  List<String> _wrapText(String text, int maxWidth) {
    if (text.isEmpty) return [''];
    if (text.length > maxWidth && !text.contains(' ')) {
      final chunks = <String>[];
      for (int i = 0; i < text.length; i += maxWidth) {
        chunks.add(text.substring(i, min(i + maxWidth, text.length)));
      }
      return chunks;
    }

    final words = text.split(' ');
    final lines = <String>[];
    var currentLine = StringBuffer();
    int currentLen = 0;
    for (var word in words) {
      int wordLen = _visualLength(word);
      if (wordLen > maxWidth) {
        if (currentLine.isNotEmpty) {
          lines.add(currentLine.toString());
          currentLine = StringBuffer();
          currentLen = 0;
        }
        lines.add(word);
        continue;
      }
      if ((currentLen + wordLen + 1) > maxWidth) {
        lines.add(currentLine.toString());
        currentLine = StringBuffer();
        currentLen = 0;
      }
      if (currentLine.isNotEmpty) {
        currentLine.write(' ');
        currentLen++;
      }
      currentLine.write(word);
      currentLen += wordLen;
    }
    if (currentLine.isNotEmpty) {
      lines.add(currentLine.toString());
    }
    return lines;
  }

  int _visualLength(String text) {
    return text.replaceAll(RegExp(r'\x1B\[[\d;]*m'), '').length;
  }
}
