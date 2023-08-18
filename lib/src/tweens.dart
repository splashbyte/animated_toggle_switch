part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class _CustomTween<V> extends Tween<V> {
  final V Function(V value1, V value2, double t) lerpFunction;

  _CustomTween(this.lerpFunction, {super.begin, super.end});

  @override
  V lerp(double t) => lerpFunction(begin as V, end as V, t);
}
