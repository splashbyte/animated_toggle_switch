part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

/// The base class for all toggle styles.
abstract class _BaseToggleStyle extends ThemeExtension<_BaseToggleStyle> {
  const _BaseToggleStyle._();

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

  _BaseToggleStyle _merge(
    _BaseToggleStyle? other,
    BorderRadiusGeometry indicatorBorderRadiusDifference,
  ) =>
      other == null
          ? this
          : _CustomToggleStyle._(
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

  static _BaseToggleStyle Function(
      _BaseToggleStyle style1, _BaseToggleStyle style2, double t) _lerpFunction(
          AnimationType animationType) =>
      (style1, style2, t) => _lerp(style1, style2, t, animationType);

  @override
  _BaseToggleStyle lerp(_BaseToggleStyle other, double t) =>
      _lerp(this, other, t, AnimationType.none);

  static _BaseToggleStyle _lerp(_BaseToggleStyle style1,
          _BaseToggleStyle style2, double t, AnimationType animationType) =>
      _CustomToggleStyle._(
        indicatorColor: ToggleStyleProperty._lerpConditional(
            style1._indicatorColor,
            style2._indicatorColor,
            t,
            Color.lerp,
            animationType),
        indicatorGradient: ToggleStyleProperty._lerpConditional(
            style1._indicatorGradient ??
                style1._indicatorColor?._map((value) => value.toGradient()),
            style2._indicatorGradient ??
                style2._indicatorColor?._map((value) => value.toGradient()),
            t,
            Gradient.lerp,
            animationType),
        backgroundColor: ToggleStyleProperty._lerpConditional(
            style1._backgroundColor,
            style2._backgroundColor,
            t,
            Color.lerp,
            animationType),
        backgroundGradient: ToggleStyleProperty._lerpConditional(
            style1._backgroundGradient ??
                style1._backgroundColor?._map((value) => value.toGradient()),
            style2._backgroundGradient ??
                style2._backgroundColor?._map((value) => value.toGradient()),
            t,
            Gradient.lerp,
            animationType),
        borderColor: ToggleStyleProperty._lerpConditional(style1._borderColor,
            style2._borderColor, t, Color.lerp, animationType),
        borderRadius: ToggleStyleProperty._lerpConditional(style1._borderRadius,
            style2._borderRadius, t, BorderRadiusGeometry.lerp, animationType),
        indicatorBorderRadius: ToggleStyleProperty._lerpConditional(
            style1._indicatorBorderRadius ?? style1._borderRadius,
            style2._indicatorBorderRadius ?? style2._borderRadius,
            t,
            BorderRadiusGeometry.lerp,
            animationType),
        indicatorBorder: ToggleStyleProperty._lerpConditional(
            style1._indicatorBorder,
            style2._indicatorBorder,
            t,
            BoxBorder.lerp,
            animationType),
        indicatorBoxShadow: ToggleStyleProperty._lerpConditional(
            style1._indicatorBoxShadow,
            style2._indicatorBoxShadow,
            t,
            BoxShadow.lerpList,
            animationType),
        boxShadow: ToggleStyleProperty._lerpConditional(style1._boxShadow,
            style2._boxShadow, t, BoxShadow.lerpList, animationType),
      );
}

/// Currently not supported.
class _CustomToggleStyle extends _BaseToggleStyle {
  @override
  Object get type => _CustomToggleStyle;

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

  /// Default constructor for [_CustomToggleStyle].
  ///
  /// If you don't want to disable the animation of single properties,
  /// you should use [ToggleStyle] instead.
  const _CustomToggleStyle({
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

  const _CustomToggleStyle._({
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

  ToggleStyleProperty<Color>? get indicatorColor => _indicatorColor;

  ToggleStyleProperty<Gradient>? get indicatorGradient => _indicatorGradient;

  ToggleStyleProperty<Color>? get backgroundColor => _backgroundColor;

  ToggleStyleProperty<Gradient>? get backgroundGradient => _backgroundGradient;

  ToggleStyleProperty<Color>? get borderColor => _borderColor;

  ToggleStyleProperty<BorderRadiusGeometry>? get borderRadius => _borderRadius;

  ToggleStyleProperty<BorderRadiusGeometry>? get indicatorBorderRadius =>
      _indicatorBorderRadius;

  ToggleStyleProperty<BoxBorder>? get indicatorBorder => _indicatorBorder;

  ToggleStyleProperty<List<BoxShadow>>? get indicatorBoxShadow =>
      _indicatorBoxShadow;

  ToggleStyleProperty<List<BoxShadow>>? get boxShadow => _boxShadow;

  @override
  _CustomToggleStyle copyWith({
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
  }) =>
      _CustomToggleStyle._(
        indicatorColor: indicatorColor ?? this.indicatorColor,
        indicatorGradient: indicatorGradient ?? this.indicatorGradient,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundGradient: backgroundGradient ?? this.backgroundGradient,
        borderColor: borderColor ?? this.borderColor,
        borderRadius: borderRadius ?? this.borderRadius,
        indicatorBorderRadius:
            indicatorBorderRadius ?? this.indicatorBorderRadius,
        indicatorBorder: indicatorBorder ?? this.indicatorBorder,
        indicatorBoxShadow: indicatorBoxShadow ?? this.indicatorBoxShadow,
        boxShadow: boxShadow ?? this.boxShadow,
      );
}

class ToggleStyle extends _BaseToggleStyle {
  @override
  Object get type => ToggleStyle;

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
  }) : super._();

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
  }) : super._();

  @override
  ToggleStyleProperty<Color>? get _backgroundColor =>
      ToggleStyleProperty.nullable(backgroundColor);

  @override
  ToggleStyleProperty<Gradient>? get _backgroundGradient =>
      ToggleStyleProperty.nullable(backgroundGradient);

  @override
  ToggleStyleProperty<Color>? get _borderColor =>
      ToggleStyleProperty.nullable(borderColor);

  @override
  ToggleStyleProperty<BorderRadiusGeometry>? get _borderRadius =>
      ToggleStyleProperty.nullable(borderRadius);

  @override
  ToggleStyleProperty<List<BoxShadow>>? get _boxShadow =>
      ToggleStyleProperty.nullable(boxShadow);

  @override
  ToggleStyleProperty<BoxBorder>? get _indicatorBorder =>
      ToggleStyleProperty.nullable(indicatorBorder);

  @override
  ToggleStyleProperty<BorderRadiusGeometry>? get _indicatorBorderRadius =>
      ToggleStyleProperty.nullable(indicatorBorderRadius);

  @override
  ToggleStyleProperty<List<BoxShadow>>? get _indicatorBoxShadow =>
      ToggleStyleProperty.nullable(indicatorBoxShadow);

  @override
  ToggleStyleProperty<Color>? get _indicatorColor =>
      ToggleStyleProperty.nullable(indicatorColor);

  @override
  ToggleStyleProperty<Gradient>? get _indicatorGradient =>
      ToggleStyleProperty.nullable(indicatorGradient);

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

  @override
  ToggleStyle copyWith({
    Color? indicatorColor,
    Gradient? indicatorGradient,
    Color? backgroundColor,
    Gradient? backgroundGradient,
    Color? borderColor,
    BorderRadiusGeometry? borderRadius,
    BorderRadiusGeometry? indicatorBorderRadius,
    BoxBorder? indicatorBorder,
    List<BoxShadow>? indicatorBoxShadow,
    List<BoxShadow>? boxShadow,
  }) =>
      ToggleStyle._(
        indicatorColor: indicatorColor ?? this.indicatorColor,
        indicatorGradient: indicatorGradient ?? this.indicatorGradient,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundGradient: backgroundGradient ?? this.backgroundGradient,
        borderColor: borderColor ?? this.borderColor,
        borderRadius: borderRadius ?? this.borderRadius,
        indicatorBorderRadius:
            indicatorBorderRadius ?? this.indicatorBorderRadius,
        indicatorBorder: indicatorBorder ?? this.indicatorBorder,
        indicatorBoxShadow: indicatorBoxShadow ?? this.indicatorBoxShadow,
        boxShadow: boxShadow ?? this.boxShadow,
      );

  @override
  ToggleStyle lerp(ToggleStyle other, double t) {
    final result = super.lerp(other, t);
    return ToggleStyle._(
      indicatorColor: result._indicatorColor?.value,
      indicatorGradient: result._indicatorGradient?.value,
      backgroundColor: result._backgroundColor?.value,
      backgroundGradient: result._backgroundGradient?.value,
      borderColor: result._borderColor?.value,
      borderRadius: result._borderRadius?.value,
      indicatorBorderRadius: result._indicatorBorderRadius?.value,
      indicatorBorder: result._indicatorBorder?.value,
      indicatorBoxShadow: result._indicatorBoxShadow?.value,
      boxShadow: result._boxShadow?.value,
    );
  }

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

  static ToggleStyleProperty<T>? nullable<T>(
    T? value, {
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
      T? Function(T?, T?, double) lerp,
      AnimationType animationType) {
    if (prop1?.animationEnabled != true && prop2?.animationEnabled != true) {
      if (animationType == AnimationType.onHover && t < 0.5) return prop1;
      return prop2;
    }
    return ToggleStyleProperty.nullable(
      lerp(prop1?.value, prop2?.value, t),
      animationEnabled: true,
    );
  }
}

extension XThemeDataToggleStyle on ThemeData {
  ToggleStyle get toggleStyle =>
      extension<ToggleStyle>() ?? const ToggleStyle();
}
