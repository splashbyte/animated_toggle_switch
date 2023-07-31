part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleStyle {
  /// Background color of the indicator.
  final Color? indicatorColor;

  /// Background color of the switch.
  final Color? backgroundColor;

  /// Gradient of the background. Overwrites [innerColor] if not [null].
  final Gradient? backgroundGradient;

  /// Border color of the switch.
  ///
  /// For deactivating please set this to [Colors.transparent].
  final Color? borderColor;

  /// [BorderRadius] of the switch.
  final BorderRadiusGeometry? borderRadius;

  /// [BorderRadius] of the indicator.
  ///
  /// Defaults to [borderRadius].
  final BorderRadiusGeometry? indicatorBorderRadius;

  /// [BorderRadius] of the indicator.
  final BoxBorder? indicatorBorder;

  /// Shadow for the indicator [Container].
  final List<BoxShadow>? indicatorBoxShadow;

  /// Shadow for the [Container] in the background.
  final List<BoxShadow>? boxShadow;

  /// Default constructor for [ToggleStyle].
  const ToggleStyle({
    this.indicatorColor,
    this.backgroundColor,
    this.backgroundGradient,
    this.borderColor,
    this.borderRadius,
    this.indicatorBorderRadius,
    this.indicatorBorder,
    this.indicatorBoxShadow,
    this.boxShadow,
  });

  /// Private constructor for setting all possible parameters.
  ToggleStyle._({
    required this.indicatorColor,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.borderColor,
    required this.borderRadius,
    required this.indicatorBorderRadius,
    required this.indicatorBorder,
    required this.indicatorBoxShadow,
    required this.boxShadow,
  });

  ToggleStyle _merge(ToggleStyle? other) => other == null
      ? this
      : ToggleStyle._(
          indicatorColor: other.indicatorColor ?? indicatorColor,
          backgroundColor: other.backgroundColor ?? backgroundColor,
          backgroundGradient: other.backgroundGradient ??
              (other.backgroundColor == null ? null : backgroundGradient),
          borderColor: other.borderColor ?? borderColor,
          borderRadius: other.borderRadius ?? borderRadius,
          indicatorBorderRadius: other.indicatorBorderRadius ??
              other.borderRadius ??
              indicatorBorderRadius ??
              borderRadius,
          indicatorBorder: other.indicatorBorder ?? indicatorBorder,
          indicatorBoxShadow: other.indicatorBoxShadow ?? indicatorBoxShadow,
          boxShadow: other.boxShadow ?? boxShadow,
        );

  static ToggleStyle _lerp(ToggleStyle style1, ToggleStyle style2, double t) =>
      ToggleStyle._(
        indicatorColor:
            Color.lerp(style1.indicatorColor, style2.indicatorColor, t),
        backgroundColor:
            Color.lerp(style1.backgroundColor, style2.backgroundColor, t),
        backgroundGradient: Gradient.lerp(
          style1.backgroundGradient ?? style1.backgroundColor?.toGradient(),
          style2.backgroundGradient ?? style2.backgroundColor?.toGradient(),
          t,
        ),
        borderColor: Color.lerp(style1.borderColor, style2.borderColor, t),
        borderRadius: BorderRadiusGeometry.lerp(
          style1.borderRadius,
          style2.borderRadius,
          t,
        ),
        indicatorBorderRadius: BorderRadiusGeometry.lerp(
          style1.indicatorBorderRadius ?? style1.borderRadius,
          style2.indicatorBorderRadius ?? style2.borderRadius,
          t,
        ),
        indicatorBorder: BoxBorder.lerp(
          style1.indicatorBorder,
          style2.indicatorBorder,
          t,
        ),
        indicatorBoxShadow: BoxShadow.lerpList(
          style1.indicatorBoxShadow,
          style2.indicatorBoxShadow,
          t,
        ),
        boxShadow: BoxShadow.lerpList(
          style1.boxShadow,
          style2.boxShadow,
          t,
        ),
      );

  // coverage:ignore-start

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToggleStyle &&
          runtimeType == other.runtimeType &&
          indicatorColor == other.indicatorColor &&
          backgroundColor == other.backgroundColor &&
          backgroundGradient == other.backgroundGradient &&
          borderColor == other.borderColor &&
          borderRadius == other.borderRadius &&
          indicatorBorderRadius == other.indicatorBorderRadius &&
          indicatorBorder == other.indicatorBorder &&
          indicatorBoxShadow == other.indicatorBoxShadow &&
          boxShadow == other.boxShadow;

  @override
  int get hashCode =>
      indicatorColor.hashCode ^
      backgroundColor.hashCode ^
      backgroundGradient.hashCode ^
      borderColor.hashCode ^
      borderRadius.hashCode ^
      indicatorBorderRadius.hashCode ^
      indicatorBorder.hashCode ^
      indicatorBoxShadow.hashCode ^
      boxShadow.hashCode;
  
  // coverage:ignore-end
}
