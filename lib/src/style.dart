part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleStyle {
  /// Background color of the indicator.
  ///
  /// Defaults to [ThemeData.colorScheme.secondary].
  final Color? indicatorColor;

  /// Gradient of the indicator. Overwrites [indicatorColor] if not [null].
  final Gradient? indicatorGradient;

  /// Background color of the switch.
  ///
  /// Defaults to [ThemeData.colorScheme.surface].
  final Color? backgroundColor;

  /// Gradient of the background. Overwrites [backgroundColor] if not [null].
  final Gradient? backgroundGradient;

  /// Border color of the switch.
  ///
  /// Defaults to [ThemeData.colorScheme.secondary].
  ///
  /// For deactivating please set this to [Colors.transparent].
  final Color? borderColor;

  /// [BorderRadius] of the switch.
  final BorderRadiusGeometry? borderRadius;

  /// [BorderRadius] of the indicator.
  ///
  /// Defaults to [borderRadius] - [BorderRadius.circular(borderWidth)].
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
    this.indicatorGradient,
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
  const ToggleStyle._({
    required this.indicatorColor,
    required this.indicatorGradient,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.borderColor,
    required this.borderRadius,
    required this.indicatorBorderRadius,
    required this.indicatorBorder,
    required this.indicatorBoxShadow,
    required this.boxShadow,
  });

  ToggleStyle _merge(
    ToggleStyle? other,
    BorderRadiusGeometry indicatorBorderRadiusDifference,
  ) =>
      other == null
          ? this
          : ToggleStyle._(
              indicatorColor: other.indicatorColor ?? indicatorColor,
              indicatorGradient: other.indicatorGradient ??
                  (other.indicatorColor != null ? null : indicatorGradient),
              backgroundColor: other.backgroundColor ?? backgroundColor,
              backgroundGradient: other.backgroundGradient ??
                  (other.backgroundColor != null ? null : backgroundGradient),
              borderColor: other.borderColor ?? borderColor,
              borderRadius: other.borderRadius ?? borderRadius,
              indicatorBorderRadius: other.indicatorBorderRadius ??
                  other.borderRadius
                      .subtractNullable(indicatorBorderRadiusDifference) ??
                  indicatorBorderRadius ??
                  borderRadius
                      .subtractNullable(indicatorBorderRadiusDifference),
              indicatorBorder: other.indicatorBorder ?? indicatorBorder,
              indicatorBoxShadow:
                  other.indicatorBoxShadow ?? indicatorBoxShadow,
              boxShadow: other.boxShadow ?? boxShadow,
            );

  static ToggleStyle _lerp(ToggleStyle style1, ToggleStyle style2, double t) =>
      ToggleStyle._(
        indicatorColor:
            Color.lerp(style1.indicatorColor, style2.indicatorColor, t),
        indicatorGradient: Gradient.lerp(
          style1.indicatorGradient ?? style1.indicatorColor?.toGradient(),
          style2.indicatorGradient ?? style2.indicatorColor?.toGradient(),
          t,
        ),
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
          indicatorGradient == other.indicatorGradient &&
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
      indicatorGradient.hashCode ^
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

extension _XSubtractNullable on BorderRadiusGeometry? {
  BorderRadiusGeometry? subtractNullable(BorderRadiusGeometry other) {
    if (this == null) return null;
    return this!.subtract(other);
  }
}
