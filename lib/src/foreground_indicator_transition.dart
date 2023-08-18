// coverage:ignore-file
part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

/// Different types of transitions for the foreground indicator.
///
/// Currently this class is used mainly for deactivating the rolling animation in
/// some constructors.
//TODO: Sealed class after upgrade to Dart 3
abstract class ForegroundIndicatorTransition {
  const ForegroundIndicatorTransition._();

  /// Fades between the different icons and shows a rolling animation additionally.
  ///
  /// [rollingRadius] is the radius which will be used for calculating the rotation.
  /// If set to [null], a reasonable value is calculated from [indicatorSize] and [height].
  const factory ForegroundIndicatorTransition.rolling({double? rollingRadius}) =
      _RollingForegroundIndicatorTransition;

  /// Fades between the different icons.
  const factory ForegroundIndicatorTransition.fading() =
      _FadingForegroundIndicatorTransition;
}

class _RollingForegroundIndicatorTransition
    extends ForegroundIndicatorTransition {
  /// The radius which will be used for calculating the rotation.
  ///
  /// If set to [null], a reasonable value is calculated from [indicatorSize], [borderWidth] and [height].
  final double? rollingRadius;

  const _RollingForegroundIndicatorTransition({this.rollingRadius}) : super._();
}

class _FadingForegroundIndicatorTransition
    extends ForegroundIndicatorTransition {
  const _FadingForegroundIndicatorTransition() : super._();
}
