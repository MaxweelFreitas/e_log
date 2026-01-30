import '../../../base/x_term/x_term_color.dart';
import '../../../shared/border_set.dart';
import '../../../utils/color_utils.dart';
import 'shadow_style.dart';

enum BoxTitleAlign { left, center, right }

enum BoxOverflow { wrap, ellipsis }

/// Configuração visual de um Box.
class BoxStyle {
  final BorderSet border;
  final String borderColor;
  final int padding;
  final ShadowStyle? shadow;
  final String backgroundColor;
  final String? titleColor;
  final Rgb? backgroundGradientStart;
  final Rgb? backgroundGradientEnd;
  final GradientDirection backgroundGradientDir;

  const BoxStyle({
    this.border = BorderSet.single,
    this.borderColor = XTermColor.reset,
    this.padding = 1,
    this.shadow,
    this.backgroundColor = '',
    this.titleColor,
    this.backgroundGradientStart,
    this.backgroundGradientEnd,
    this.backgroundGradientDir = GradientDirection.vertical,
  });

  bool get isBackgroundGradient {
    return backgroundGradientStart != null && backgroundGradientEnd != null;
  }

  /// Cria uma cópia com alterações.
  BoxStyle copyWith({
    BorderSet? border,
    String? borderColor,
    int? padding,
    ShadowStyle? shadow,
    String? backgroundColor,
    String? titleColor,
    Rgb? bgStart,
    Rgb? bgEnd,
    GradientDirection? bgDir,
  }) {
    return BoxStyle(
      border: border ?? this.border,
      borderColor: borderColor ?? this.borderColor,
      padding: padding ?? this.padding,
      shadow: shadow ?? this.shadow,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      backgroundGradientStart: bgStart ?? backgroundGradientStart,
      backgroundGradientEnd: bgEnd ?? backgroundGradientEnd,
      backgroundGradientDir: bgDir ?? backgroundGradientDir,
    );
  }
}
