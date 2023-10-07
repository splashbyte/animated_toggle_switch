part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

/// The base class for all toggle styles.
///
/// In most cases [ToggleStyle] is sufficient.
///
/// If you want to disable the animation of single properties,
/// you can use [CustomToggleStyle] for this purpose.
abstract class BaseToggleStyle {
  const BaseToggleStyle._();

  ToggleStyleProperty<Color>? get _indicatorColor;

  ToggleStyleProperty<Gradient>? get _indicatorGradient;

  ToggleStyleProperty<Color>? get _backgroundColor;

  ToggleStyleProperty<Gradient>? get _backgroundGradient;

  ToggleStyleProperty<Color>? get _borderColor;

  ToggleStyleProperty<BorderRadiusGeometry>? get _borderRadius;

  ToggleStyleProperty<BorderRadiusGeometry>? get _indicatorBorderRadius;

  ToggleStyleProperty<BoxBorder>? get _indicatorBorder;

  ToggleStyleProperty<List<BoxShadow>>? get _indicatorBoxShadow;

  ToggleStyleProperty<List<BoxShadow>>? get _boxShadow;

  BaseToggleStyle _merge(
    BaseToggleStyle? other,
    BorderRadiusGeometry indicatorBorderRadiusDifference,
  ) =>
      other == null
          ? this
          : CustomToggleStyle._(
              indicatorColor: other._indicatorColor ?? _indicatorColor,
              indicatorGradient: other._indicatorGradient ??
                  (other._indicatorColor != null ? null : _indicatorGradient),
              backgroundColor: other._backgroundColor ?? _backgroundColor,
              backgroundGradient: other._backgroundGradient ??
                  (other._backgroundColor != null ? null : _backgroundGradient),
              borderColor: other._borderColor ?? _borderColor,
              borderRadius: other._borderRadius ?? _borderRadius,
              indicatorBorderRadius: other._indicatorBorderRadius ??
                  other._borderRadius?._map((value) =>
                      value.subtract(indicatorBorderRadiusDifference)) ??
                  _indicatorBorderRadius ??
                  _borderRadius?._map((value) =>
                      value.subtract(indicatorBorderRadiusDifference)),
              indicatorBorder: other._indicatorBorder ?? _indicatorBorder,
              indicatorBoxShadow:
                  other._indicatorBoxShadow ?? _indicatorBoxShadow,
              boxShadow: other._boxShadow ?? _boxShadow,
            );

  static BaseToggleStyle _lerp(
          BaseToggleStyle style1, BaseToggleStyle style2, double t) =>
      CustomToggleStyle._(
        indicatorColor: ToggleStyleProperty._lerpConditional(
            style1._indicatorColor, style2._indicatorColor, t, Color.lerp),
        indicatorGradient: ToggleStyleProperty._lerpConditional(
            style1._indicatorGradient ??
                style1._indicatorColor?._map((value) => value.toGradient()),
            style2._indicatorGradient ??
                style2._indicatorColor?._map((value) => value.toGradient()),
            t,
            Gradient.lerp),
        backgroundColor: ToggleStyleProperty._lerpConditional(
            style1._backgroundColor, style2._backgroundColor, t, Color.lerp),
        backgroundGradient: ToggleStyleProperty._lerpConditional(
            style1._backgroundGradient ??
                style1._backgroundColor?._map((value) => value.toGradient()),
            style2._backgroundGradient ??
                style2._backgroundColor?._map((value) => value.toGradient()),
            t,
            Gradient.lerp),
        borderColor: ToggleStyleProperty._lerpConditional(
            style1._borderColor, style2._borderColor, t, Color.lerp),
        borderRadius: ToggleStyleProperty._lerpConditional(style1._borderRadius,
            style2._borderRadius, t, BorderRadiusGeometry.lerp),
        indicatorBorderRadius: ToggleStyleProperty._lerpConditional(
            style1._indicatorBorderRadius ?? style1._borderRadius,
            style2._indicatorBorderRadius ?? style2._borderRadius,
            t,
            BorderRadiusGeometry.lerp),
        indicatorBorder: ToggleStyleProperty._lerpConditional(
            style1._indicatorBorder,
            style2._indicatorBorder,
            t,
            BoxBorder.lerp),
        indicatorBoxShadow: ToggleStyleProperty._lerpConditional(
            style1._indicatorBoxShadow,
            style2._indicatorBoxShadow,
            t,
            BoxShadow.lerpList),
        boxShadow: ToggleStyleProperty._lerpConditional(
            style1._boxShadow, style2._boxShadow, t, BoxShadow.lerpList),
      );
}

class CustomToggleStyle extends BaseToggleStyle {
  @override
  final ToggleStyleProperty<Color>? _indicatorColor;
  @override
  final ToggleStyleProperty<Gradient>? _indicatorGradient;
  @override
  final ToggleStyleProperty<Color>? _backgroundColor;
  @override
  final ToggleStyleProperty<Gradient>? _backgroundGradient;
  @override
  final ToggleStyleProperty<Color>? _borderColor;
  @override
  final ToggleStyleProperty<BorderRadiusGeometry>? _borderRadius;
  @override
  final ToggleStyleProperty<BorderRadiusGeometry>? _indicatorBorderRadius;
  @override
  final ToggleStyleProperty<BoxBorder>? _indicatorBorder;
  @override
  final ToggleStyleProperty<List<BoxShadow>>? _indicatorBoxShadow;
  @override
  final ToggleStyleProperty<List<BoxShadow>>? _boxShadow;

  /// Default constructor for [CustomToggleStyle].
  ///
  /// If you don't want to disable the animation of single properties,
  /// you should use [ToggleStyle] instead.
  const CustomToggleStyle({
    ToggleStyleProperty<Color>? indicatorColor,
    ToggleStyleProperty<Gradient>? indicatorGradient,
    ToggleStyleProperty<Color>? backgroundColor,
    ToggleStyleProperty<Gradient>? backgroundGradient,
    ToggleStyleProperty<Color>? borderColor,
    ToggleStyleProperty<BorderRadiusGeometry>? borderRadius,
    ToggleStyleProperty<BorderRadiusGeometry>? indicatorBorderRadius,
    ToggleStyleProperty<BoxBorder>? indicatorBorder,
    ToggleStyleProperty<List<BoxShadow>>? indicatorBoxShadow,
    ToggleStyleProperty<List<BoxShadow>>? boxShadow,
  })  : _indicatorColor = indicatorColor,
        _indicatorGradient = indicatorGradient,
        _backgroundColor = backgroundColor,
        _backgroundGradient = backgroundGradient,
        _borderColor = borderColor,
        _borderRadius = borderRadius,
        _indicatorBorderRadius = indicatorBorderRadius,
        _indicatorBorder = indicatorBorder,
        _indicatorBoxShadow = indicatorBoxShadow,
        _boxShadow = boxShadow,
        super._();

  const CustomToggleStyle._({
    required ToggleStyleProperty<Color>? indicatorColor,
    required ToggleStyleProperty<Gradient>? indicatorGradient,
    required ToggleStyleProperty<Color>? backgroundColor,
    required ToggleStyleProperty<Gradient>? backgroundGradient,
    required ToggleStyleProperty<Color>? borderColor,
    required ToggleStyleProperty<BorderRadiusGeometry>? borderRadius,
    required ToggleStyleProperty<BorderRadiusGeometry>? indicatorBorderRadius,
    required ToggleStyleProperty<BoxBorder>? indicatorBorder,
    required ToggleStyleProperty<List<BoxShadow>>? indicatorBoxShadow,
    required ToggleStyleProperty<List<BoxShadow>>? boxShadow,
  })  : _indicatorColor = indicatorColor,
        _indicatorGradient = indicatorGradient,
        _backgroundColor = backgroundColor,
        _backgroundGradient = backgroundGradient,
        _borderColor = borderColor,
        _borderRadius = borderRadius,
        _indicatorBorderRadius = indicatorBorderRadius,
        _indicatorBorder = indicatorBorder,
        _indicatorBoxShadow = indicatorBoxShadow,
        _boxShadow = boxShadow,
        super._();
}

class ToggleStyle extends BaseToggleStyle {
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
  ///
  /// If you want to disable the animation of single properties,
  /// you can use [CustomToggleStyle] for this purpose.
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
  }) : super._();

  @override
  ToggleStyleProperty<Color>? get _backgroundColor =>
      ToggleStyleProperty.nullable(value: backgroundColor);

  @override
  ToggleStyleProperty<Gradient>? get _backgroundGradient =>
      ToggleStyleProperty.nullable(value: backgroundGradient);

  @override
  ToggleStyleProperty<Color>? get _borderColor =>
      ToggleStyleProperty.nullable(value: borderColor);

  @override
  ToggleStyleProperty<BorderRadiusGeometry>? get _borderRadius =>
      ToggleStyleProperty.nullable(value: borderRadius);

  @override
  ToggleStyleProperty<List<BoxShadow>>? get _boxShadow =>
      ToggleStyleProperty.nullable(value: boxShadow);

  @override
  ToggleStyleProperty<BoxBorder>? get _indicatorBorder =>
      ToggleStyleProperty.nullable(value: indicatorBorder);

  @override
  ToggleStyleProperty<BorderRadiusGeometry>? get _indicatorBorderRadius =>
      ToggleStyleProperty.nullable(value: indicatorBorderRadius);

  @override
  ToggleStyleProperty<List<BoxShadow>>? get _indicatorBoxShadow =>
      ToggleStyleProperty.nullable(value: indicatorBoxShadow);

  @override
  ToggleStyleProperty<Color>? get _indicatorColor =>
      ToggleStyleProperty.nullable(value: indicatorColor);

  @override
  ToggleStyleProperty<Gradient>? get _indicatorGradient =>
      ToggleStyleProperty.nullable(value: indicatorGradient);

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

class ToggleStyleProperty<T> {
  /// The value of this property.
  final T value;

  /// Indicates if this property will be animated when changed.
  final bool animationEnabled;

  const ToggleStyleProperty(
    this.value, {
    this.animationEnabled = true,
  });

  static ToggleStyleProperty<T>? nullable<T>({
    required T? value,
    bool animationEnabled = true,
  }) =>
      value == null
          ? null
          : ToggleStyleProperty(value, animationEnabled: animationEnabled);

  ToggleStyleProperty<S> _map<S>(S Function(T value) map) =>
      ToggleStyleProperty(
        map(value),
        animationEnabled: animationEnabled,
      );

  static ToggleStyleProperty<T>? _lerpConditional<T>(
      ToggleStyleProperty<T>? prop1,
      ToggleStyleProperty<T>? prop2,
      double t,
      T? Function(T?, T?, double) lerp) {
    if (prop1?.animationEnabled != true && prop2?.animationEnabled != true) {
      return prop2;
    }
    return ToggleStyleProperty.nullable(
      value: lerp(prop1?.value, prop2?.value, t),
      animationEnabled: true,
    );
  }
}
