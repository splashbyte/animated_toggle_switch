import 'package:flutter/foundation.dart';

/// This class should only be used in the animated_toggle_switch package itself or in its tests.
abstract class AnimatedToggleSwitchTestKeys {
  const AnimatedToggleSwitchTestKeys._();

  static const Key indicatorDecoratedBoxKey = _AnimatedToggleSwitchKey(0);
}

class _AnimatedToggleSwitchKey<T> extends ValueKey<T> {
  const _AnimatedToggleSwitchKey(super.value);
}
