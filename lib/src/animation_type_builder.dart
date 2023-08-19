part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class _AnimationTypeHoverBuilder<T, V> extends StatefulWidget {
  final V Function(StyledToggleProperties<T> local) valueProvider;
  final V Function(V value1, V value2, double t) lerp;
  final Widget Function(V value) builder;
  final GlobalToggleProperties<T> properties;
  final Duration animationDuration;
  final Curve animationCurve;
  final Duration indicatorAppearingDuration;
  final Curve indicatorAppearingCurve;

  const _AnimationTypeHoverBuilder({
    required this.valueProvider,
    required this.lerp,
    required this.builder,
    required this.properties,
    required this.animationDuration,
    required this.animationCurve,
    required this.indicatorAppearingDuration,
    required this.indicatorAppearingCurve,
  });

  @override
  State<_AnimationTypeHoverBuilder<T, V>> createState() =>
      _AnimationTypeHoverBuilderState();
}

class _AnimationTypeHoverBuilderState<T, V>
    extends State<_AnimationTypeHoverBuilder<T, V>> {
  final _builderKey = GlobalKey();
  T? _lastUnlistedValue;

  @override
  void initState() {
    super.initState();
    if (!widget.properties.isCurrentListed) {
      _lastUnlistedValue = widget.properties.current;
    }
  }

  @override
  void didUpdateWidget(covariant _AnimationTypeHoverBuilder<T, V> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.properties.isCurrentListed) {
      _lastUnlistedValue = widget.properties.current;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pos = widget.properties.position;
    final values = widget.properties.values;
    final index1 = pos.floor();
    final index2 = pos.ceil();
    V listedValueFunction() => widget.lerp(
          widget.valueProvider(
              StyledToggleProperties(value: values[index1], index: index1)),
          widget.valueProvider(
              StyledToggleProperties(value: values[index2], index: index2)),
          pos - pos.floor(),
        );
    final indicatorAppearingAnimation =
        widget.properties._indicatorAppearingAnimation;
    return AnimatedBuilder(
      animation: indicatorAppearingAnimation,
      builder: (context, _) {
        final appearingValue = indicatorAppearingAnimation.value;
        if (appearingValue >= 1.0) {
          return _EmptyWidget(
              key: _builderKey, child: widget.builder(listedValueFunction()));
        }
        final unlistedValue = widget.valueProvider(
            StyledToggleProperties(value: _lastUnlistedValue as T, index: -1));
        return TweenAnimationBuilder<V>(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            tween: _CustomTween(widget.lerp,
                begin: unlistedValue, end: unlistedValue),
            builder: (context, unlistedValue, _) {
              return _EmptyWidget(
                key: _builderKey,
                child: widget.builder(appearingValue <= 0.0
                    ? unlistedValue
                    : widget.lerp(
                        unlistedValue, listedValueFunction(), appearingValue)),
              );
            });
      },
    );
  }
}
