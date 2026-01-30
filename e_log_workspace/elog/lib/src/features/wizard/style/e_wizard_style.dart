import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import '../../../shared/icon_set.dart';

enum WizardBoxStyle { none, bracketSide, box, solidBackground }

class EWizardStyle {
  final BorderSet border;
  final IconSet icons;
  final WizardBoxStyle bannerStyle;
  final String? errorColor;
  final String? bannerBorderColor;
  final String? bannerBackgroundColor;
  final String? bannerTextColor;

  final WizardBoxStyle footerStyle;
  final String? footerBorderColor;
  final String? footerBackgroundColor;
  final String? footerTextColor;

  final bool showMessage;
  final bool renderMessageBox;
  final String? messageBorderColor;
  final String? messageTextColor;

  final String? activeColor;
  final String? completedColor;
  final String? stepTitleColor;
  final String? completedStepTitleColor;

  final String treeLineChar;
  final String treeCornerChar;

  final String? selectionHighlightColor;

  const EWizardStyle({
    this.border = BorderSet.rounded,
    this.icons = IconSet.classic,
    this.bannerStyle = WizardBoxStyle.bracketSide,
    this.footerStyle = WizardBoxStyle.bracketSide,
    this.bannerBorderColor = XTermColor.cyan,
    this.bannerBackgroundColor = XTermColor.reset,
    this.bannerTextColor = XTermColor.white,
    this.footerBorderColor = XTermColor.cyan,
    this.footerBackgroundColor = XTermColor.reset,
    this.footerTextColor = XTermColor.white,
    this.showMessage = true,
    this.renderMessageBox = true,
    this.messageBorderColor = XTermColor.cyan,
    this.messageTextColor = XTermColor.white,
    this.activeColor = XTermColor.cyan,
    this.completedColor = XTermColor.green,
    this.stepTitleColor = XTermColor.white,
    this.treeLineChar = '│',
    this.treeCornerChar = '╰',
    this.selectionHighlightColor = XTermColor.cyan,
    this.errorColor = XTermColor.red,
    this.completedStepTitleColor = XTermColor.green,
  });

  EWizardStyle copyWith({
    BorderSet? border,
    IconSet? icons,
    WizardBoxStyle? bannerStyle,
    String? bannerBorderColor,
    String? bannerBackgroundColor,
    String? bannerTextColor,
    WizardBoxStyle? footerStyle,
    String? footerBorderColor,
    String? footerBackgroundColor,
    String? footerTextColor,
    bool? showMessage,
    bool? renderMessageBox,
    String? messageBorderColor,
    String? messageTextColor,
    String? activeColor,
    String? completedColor,
    String? stepTitleColor,
    String? completedStepTitleColor,
    String? treeLineChar,
    String? treeCornerChar,
    String? selectionHighlightColor,
    String? errorColor,
  }) {
    return EWizardStyle(
      border: border ?? this.border,
      bannerStyle: bannerStyle ?? this.bannerStyle,
      bannerBorderColor: bannerBorderColor ?? this.bannerBorderColor,
      bannerBackgroundColor:
          bannerBackgroundColor ?? this.bannerBackgroundColor,
      bannerTextColor: bannerTextColor ?? this.bannerTextColor,
      footerStyle: footerStyle ?? this.footerStyle,
      footerBorderColor: footerBorderColor ?? this.footerBorderColor,
      footerBackgroundColor:
          footerBackgroundColor ?? this.footerBackgroundColor,
      footerTextColor: footerTextColor ?? this.footerTextColor,
      showMessage: showMessage ?? this.showMessage,
      renderMessageBox: renderMessageBox ?? this.renderMessageBox,
      messageBorderColor: messageBorderColor ?? this.messageBorderColor,
      messageTextColor: messageTextColor ?? this.messageTextColor,
      activeColor: activeColor ?? this.activeColor,
      completedColor: completedColor ?? this.completedColor,
      stepTitleColor: stepTitleColor ?? this.stepTitleColor,
      completedStepTitleColor:
          completedStepTitleColor ?? this.completedStepTitleColor,
      treeLineChar: treeLineChar ?? this.treeLineChar,
      treeCornerChar: treeCornerChar ?? this.treeCornerChar,
      selectionHighlightColor:
          selectionHighlightColor ?? this.selectionHighlightColor,
      errorColor: errorColor ?? this.errorColor,
    );
  }
}
