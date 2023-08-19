part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

// this Animation is not covered because it contains not logic but
// forwards all methods to its parent Animation.
// coverage:ignore-start
/// This class is a proxy for another animation.
///
/// It is used for passing animations in builders without exposing the real
/// animation to the user.
class _PrivateAnimation<T> extends Animation<T> {
  final Animation<T> _parent;

  _PrivateAnimation(this._parent);

  @override
  void addListener(VoidCallback listener) => _parent.addListener(listener);

  @override
  void addStatusListener(AnimationStatusListener listener) =>
      _parent.addStatusListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _parent.removeListener(listener);

  @override
  void removeStatusListener(AnimationStatusListener listener) =>
      _parent.removeStatusListener(listener);

  @override
  AnimationStatus get status => _parent.status;

  @override
  T get value => _parent.value;
}
// coverage:ignore-end
