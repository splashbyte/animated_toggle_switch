import 'package:flutter/foundation.dart';

class IconKey<T> extends LocalKey {
  final bool foreground;
  final T value;

  const IconKey(this.value, {this.foreground = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconKey &&
          foreground == other.foreground &&
          value == other.value;

  @override
  int get hashCode => foreground.hashCode ^ value.hashCode;

  @override
  String toString() {
    return 'IconKey{foreground: $foreground, value: $value}';
  }
}

class SeparatorKey extends LocalKey {
  final int index;

  const SeparatorKey(this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SeparatorKey && index == other.index;

  @override
  int get hashCode => index.hashCode;

  @override
  String toString() {
    return 'SeparatorKey{index: $index}';
  }
}
