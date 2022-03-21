import 'package:flutter/rendering.dart';

class GlobalToggleProperties<T> {
  final double position;
  final T value;
  final T? previousValue;
  final double previousPosition;

  const GlobalToggleProperties({
    required this.position,
    required this.value,
    required this.previousValue,
    required this.previousPosition,
  });
}

class DetailedGlobalToggleProperties<T> extends GlobalToggleProperties<T> {
  final double dif;
  final Size indicatorSize;

  const DetailedGlobalToggleProperties({
    required this.dif,
    required this.indicatorSize,
    required double position,
    required T value,
    required T? previousValue,
    required double previousPosition,
  }) : super(
          position: position,
          value: value,
          previousValue: previousValue,
          previousPosition: previousPosition,
        );
}

class LocalToggleProperties<T> {
  final T value;
  final int index;

  const LocalToggleProperties({
    required this.value,
    required this.index,
  });
}

class AnimatedToggleProperties<T> extends LocalToggleProperties<T> {
  final double animationValue;

  AnimatedToggleProperties.fromLocal({
    required this.animationValue,
    required LocalToggleProperties<T> properties,
  }) : super(value: properties.value, index: properties.index);

  const AnimatedToggleProperties({
    required T value,
    required int index,
    required this.animationValue,
  }) : super(
          value: value,
          index: index,
        );

  AnimatedToggleProperties<T> copyWith({T? value, int? index}) {
    return AnimatedToggleProperties(
        value: value ?? this.value,
        index: index ?? this.index,
        animationValue: animationValue);
  }
}

class RollingProperties<T> extends LocalToggleProperties<T> {
  final Size iconSize;
  final bool foreground;

  RollingProperties.fromLocal({
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
    required T value,
    required int index,
  }) : super(
          value: value,
          index: index,
        );
}

class SizeProperties<T> extends AnimatedToggleProperties<T> {
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
    required T value,
    required int index,
    required double animationValue,
  }) : super(
          value: value,
          index: index,
          animationValue: animationValue,
        );
}
