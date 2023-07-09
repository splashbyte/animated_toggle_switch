import 'package:flutter/cupertino.dart';

//TODO: Replace with record after Dart SDK upgrade
class IconKey<T> extends LocalKey {
  final bool foreground;
  final T value;

  IconKey(this.value, {this.foreground = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconKey &&
          foreground == other.foreground &&
          value == other.value;

  @override
  int get hashCode => foreground.hashCode ^ value.hashCode;
}