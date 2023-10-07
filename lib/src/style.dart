part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

abstract class _BaseToggleStyle {
  const _BaseToggleStyle();

  _ToggleStyleProperty<Color>? get _indicatorColor;

  _ToggleStyleProperty<Gradient>? get _indicatorGradient;

  _ToggleStyleProperty<Color>? get _backgroundColor;

  _ToggleStyleProperty<Gradient>? get _backgroundGradient;

  _ToggleStyleProperty<Color>? get _borderColor;

  _ToggleStyleProperty<BorderRadiusGeometry>? get _borderRadius;

  _ToggleStyleProperty<BorderRadiusGeometry>? get _indicatorBorderRadius;

  _ToggleStyleProperty<BoxBorder>? get _indicatorBorder;

  _ToggleStyleProperty<List<BoxShadow>>? get _indicatorBoxShadow;

  _ToggleStyleProperty<List<BoxShadow>>? get _boxShadow;

  _BaseToggleStyle _merge(
    _BaseToggleStyle? other,
    BorderRadiusGeometry indicatorBorderRadiusDifference,
  ) =>
      other == null
          ? this
          : _CustomToggleStyle(
              indicatorColor: other._indicatorColor ?? _indicatorColor,
              indicatorGradient: other._indicatorGradient ??
                  (other._indicatorColor != null ? null : _indicatorGradient),
              backgroundColor: other._backgroundColor ?? _backgroundColor,
              backgroundGradient: other._backgroundGradient ??
                  (other._backgroundColor != null ? null : _backgroundGradient),
              borderColor: other._borderColor ?? _borderColor,
              borderRadius: other._borderRadius ?? _borderRadius,
              indicatorBorderRadius: other._indicatorBorderRadius ??
                  other._borderRadius?.update((value) =>
                      value.subtract(indicatorBorderRadiusDifference)) ??
                  _indicatorBorderRadius ??
                  _borderRadius?.update((value) =>
                      value.subtract(indicatorBorderRadiusDifference)),
              indicatorBorder: other._indicatorBorder ?? _indicatorBorder,
              indicatorBoxShadow:
                  other._indicatorBoxShadow ?? _indicatorBoxShadow,
              boxShadow: other._boxShadow ?? _boxShadow,
            );

  static _BaseToggleStyle _lerp(
          _BaseToggleStyle style1, _BaseToggleStyle style2, double t) =>
      _CustomToggleStyle(
        indicatorColor: _ToggleStyleProperty.lerpConditional(
            style1._indicatorColor, style2._indicatorColor, t, Color.lerp),
        indicatorGradient: _ToggleStyleProperty.lerpConditional(
            style1._indicatorGradient ??
                style1._indicatorColor?.map((value) => value.toGradient()),
            style2._indicatorGradient ??
                style2._indicatorColor?.map((value) => value.toGradient()),
            t,
            Gradient.lerp),
        backgroundColor: _ToggleStyleProperty.lerpConditional(
            style1._backgroundColor, style2._backgroundColor, t, Color.lerp),
        backgroundGradient: _ToggleStyleProperty.lerpConditional(
            style1._backgroundGradient ??
                style1._backgroundColor?.map((value) => value.toGradient()),
            style2._backgroundGradient ??
                style2._backgroundColor?.map((value) => value.toGradient()),
            t,
            Gradient.lerp),
        borderColor: _ToggleStyleProperty.lerpConditional(
            style1._borderColor, style2._borderColor, t, Color.lerp),
        borderRadius: _ToggleStyleProperty.lerpConditional(style1._borderRadius,
            style2._borderRadius, t, BorderRadiusGeometry.lerp),
        indicatorBorderRadius: _ToggleStyleProperty.lerpConditional(
            style1._indicatorBorderRadius ?? style1._borderRadius,
            style2._indicatorBorderRadius ?? style2._borderRadius,
            t,
            BorderRadiusGeometry.lerp),
        indicatorBorder: _ToggleStyleProperty.lerpConditional(
            style1._indicatorBorder,
            style2._indicatorBorder,
            t,
            BoxBorder.lerp),
        indicatorBoxShadow: _ToggleStyleProperty.lerpConditional(
            style1._indicatorBoxShadow,
            style2._indicatorBoxShadow,
            t,
            BoxShadow.lerpList),
        boxShadow: _ToggleStyleProperty.lerpConditional(
            style1._boxShadow, style2._boxShadow, t, BoxShadow.lerpList),
      );
}

class _CustomToggleStyle extends _BaseToggleStyle {
  @override
  final _ToggleStyleProperty<Color>? _indicatorColor;
  @override
  final _ToggleStyleProperty<Gradient>? _indicatorGradient;
  @override
  final _ToggleStyleProperty<Color>? _backgroundColor;
  @override
  final _ToggleStyleProperty<Gradient>? _backgroundGradient;
  @override
  final _ToggleStyleProperty<Color>? _borderColor;
  @override
  final _ToggleStyleProperty<BorderRadiusGeometry>? _borderRadius;
  @override
  final _ToggleStyleProperty<BorderRadiusGeometry>? _indicatorBorderRadius;
  @override
  final _ToggleStyleProperty<BoxBorder>? _indicatorBorder;
  @override
  final _ToggleStyleProperty<List<BoxShadow>>? _indicatorBoxShadow;
  @override
  final _ToggleStyleProperty<List<BoxShadow>>? _boxShadow;

  const _CustomToggleStyle(
      {required _ToggleStyleProperty<Color>? indicatorColor,
      required _ToggleStyleProperty<Gradient>? indicatorGradient,
      required _ToggleStyleProperty<Color>? backgroundColor,
      required _ToggleStyleProperty<Gradient>? backgroundGradient,
      required _ToggleStyleProperty<Color>? borderColor,
      required _ToggleStyleProperty<BorderRadiusGeometry>? borderRadius,
      required _ToggleStyleProperty<BorderRadiusGeometry>?
          indicatorBorderRadius,
      required _ToggleStyleProperty<BoxBorder>? indicatorBorder,
      required _ToggleStyleProperty<List<BoxShadow>>? indicatorBoxShadow,
      required _ToggleStyleProperty<List<BoxShadow>>? boxShadow})
      : _indicatorColor = indicatorColor,
        _indicatorGradient = indicatorGradient,
        _backgroundColor = backgroundColor,
        _backgroundGradient = backgroundGradient,
        _borderColor = borderColor,
        _borderRadius = borderRadius,
        _indicatorBorderRadius = indicatorBorderRadius,
        _indicatorBorder = indicatorBorder,
        _indicatorBoxShadow = indicatorBoxShadow,
        _boxShadow = boxShadow;
}

class ToggleStyle extends _BaseToggleStyle {
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

  @override
  _ToggleStyleProperty<Color>? get _backgroundColor =>
      _ToggleStyleProperty.nullable(value: backgroundColor);

  @override
  _ToggleStyleProperty<Gradient>? get _backgroundGradient =>
      _ToggleStyleProperty.nullable(value: backgroundGradient);

  @override
  _ToggleStyleProperty<Color>? get _borderColor =>
      _ToggleStyleProperty.nullable(value: borderColor);

  @override
  _ToggleStyleProperty<BorderRadiusGeometry>? get _borderRadius =>
      _ToggleStyleProperty.nullable(value: borderRadius);

  @override
  _ToggleStyleProperty<List<BoxShadow>>? get _boxShadow =>
      _ToggleStyleProperty.nullable(value: boxShadow);

  @override
  _ToggleStyleProperty<BoxBorder>? get _indicatorBorder =>
      _ToggleStyleProperty.nullable(value: indicatorBorder);

  @override
  _ToggleStyleProperty<BorderRadiusGeometry>? get _indicatorBorderRadius =>
      _ToggleStyleProperty.nullable(value: indicatorBorderRadius);

  @override
  _ToggleStyleProperty<List<BoxShadow>>? get _indicatorBoxShadow =>
      _ToggleStyleProperty.nullable(value: indicatorBoxShadow);

  @override
  _ToggleStyleProperty<Color>? get _indicatorColor =>
      _ToggleStyleProperty.nullable(value: indicatorColor);

  @override
  _ToggleStyleProperty<Gradient>? get _indicatorGradient =>
      _ToggleStyleProperty.nullable(value: indicatorGradient);

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

class _ToggleStyleProperty<T> {
  final T value;

  /// Indicates if this property will be animated when changed
  final bool animationEnabled;

  const _ToggleStyleProperty({
    required this.value,
    this.animationEnabled = true,
  });

  _ToggleStyleProperty<T> update(T Function(T value) update) => map(update);

  _ToggleStyleProperty<S> map<S>(S Function(T value) map) =>
      _ToggleStyleProperty(
        value: map(value),
        animationEnabled: animationEnabled,
      );

  static _ToggleStyleProperty<T>? nullable<T>({
    required T? value,
    bool animationEnabled = true,
  }) =>
      value == null
          ? null
          : _ToggleStyleProperty(
              value: value, animationEnabled: animationEnabled);

  static _ToggleStyleProperty<T>? lerpConditional<T>(
      _ToggleStyleProperty<T>? prop1,
      _ToggleStyleProperty<T>? prop2,
      double t,
      T? Function(T?, T?, double) lerp) {
    if (prop1?.animationEnabled != true && prop2?.animationEnabled != true) {
      return prop2;
    }
    return _ToggleStyleProperty.nullable(
      value: lerp(prop1?.value, prop2?.value, t),
      animationEnabled: true,
    );
  }
}
