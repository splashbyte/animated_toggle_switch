// coverage:ignore-file
part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class GlobalToggleProperties<T> {
  /// The position of the indicator relative to the indices of the values.
  final double position;

  /// The current value which is given to the switch.
  ///
  /// Helpful if the value is generated e.g.
  /// when the switch constructor is called.
  final T current;

  /// The previous value of the switch.
  final T? previous;

  /// The values which are given to the switch.
  ///
  /// Helpful if the list is generated e.g.
  /// when the switch constructor is called.
  final List<T> values;

  /// The previous position of the indicator relative
  /// to the indices of the values.
  final double previousPosition;

  /// The [TextDirection] of the switch.
  final TextDirection textDirection;

  /// The current [ToggleMode] of the switch.
  final ToggleMode mode;

  /// Indicates the progress of the loading animation.
  /// [0] means 'not loading' and [1] means 'loading'.
  final double loadingAnimationValue;

  final bool active;

  const GlobalToggleProperties({
    required this.position,
    required this.current,
    required this.previous,
    required this.values,
    required this.previousPosition,
    required this.textDirection,
    required this.mode,
    required this.loadingAnimationValue,
    required this.active,
  });
}

class DetailedGlobalToggleProperties<T> extends GlobalToggleProperties<T> {
  /// The final width of the space between the icons.
  ///
  /// May differ from the value passed to the switch.
  final double dif;

  /// The final size of the indicator.
  ///
  /// May differ from the value passed to the switch.
  final Size indicatorSize;

  /// The size of the switch exclusive the outer wrapper
  final Size switchSize;

  Size get difSize => Size(dif, switchSize.height);

  const DetailedGlobalToggleProperties({
    required this.dif,
    required this.indicatorSize,
    required this.switchSize,
    required super.position,
    required super.current,
    required super.previous,
    required super.values,
    required super.previousPosition,
    required super.textDirection,
    required super.mode,
    required super.loadingAnimationValue,
    required super.active,
  });
}

class LocalToggleProperties<T> {
  /// The value.
  final T value;

  /// The index of [value].
  final int index;

  const LocalToggleProperties({
    required this.value,
    required this.index,
  });
}

class StyledToggleProperties<T> extends LocalToggleProperties<T> {
  //TODO: Add style to this class

  const StyledToggleProperties({
    required super.value,
    required super.index,
  });
}

class AnimatedToggleProperties<T> extends StyledToggleProperties<T> {
  /// A value between [0] and [1].
  ///
  /// [0] indicates that [value] is not selected.
  ///
  /// [1] indicates that [value] is selected.
  final double animationValue;

  AnimatedToggleProperties._fromLocal({
    required this.animationValue,
    required LocalToggleProperties<T> properties,
  }) : super(value: properties.value, index: properties.index);

  const AnimatedToggleProperties({
    required super.value,
    required super.index,
    required this.animationValue,
  });

  AnimatedToggleProperties<T> copyWith({T? value, int? index}) {
    return AnimatedToggleProperties(
        value: value ?? this.value,
        index: index ?? this.index,
        animationValue: animationValue);
  }
}

class RollingProperties<T> extends StyledToggleProperties<T> {
  /// The size the icon should currently have.
  final Size iconSize;

  /// Indicates if the icon is in the foreground.
  ///
  /// For [RollingIconBuilder] it indicates if the icon will be on the indicator
  /// or in the background.
  final bool foreground;

  RollingProperties._fromLocal({
    required Size iconSize,
    required bool foreground,
    required LocalToggleProperties<T> properties,
  }) : this(
          iconSize: iconSize,
          foreground: foreground,
          value: properties.value,
          index: properties.index,
        );

  const RollingProperties({
    required this.iconSize,
    required this.foreground,
    required super.value,
    required super.index,
  });
}

class SizeProperties<T> extends AnimatedToggleProperties<T> {
  /// The size the icon should currently have.
  final Size iconSize;

  SizeProperties.fromAnimated({
    required Size iconSize,
    required AnimatedToggleProperties<T> properties,
  }) : this(
          iconSize: iconSize,
          value: properties.value,
          index: properties.index,
          animationValue: properties.animationValue,
        );

  const SizeProperties({
    required this.iconSize,
    required super.value,
    required super.index,
    required super.animationValue,
  });
}

class SeparatorProperties<T> {
  /// Index of the separator.
  ///
  /// The separator is located  between the items at [index] and [index+1].
  final int index;

  /// The position of the separator relative to the indices of the values.
  double get position => index + 0.5;

  const SeparatorProperties({
    required this.index,
  });
}
