part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

/// Custom builder for icons in the switch.
typedef CustomIconBuilder<T> = Widget Function(BuildContext context,
    LocalToggleProperties<T> local, DetailedGlobalToggleProperties<T> global);

/// Custom builder for the indicator of the switch.
typedef CustomIndicatorBuilder<T> = Widget Function(
    BuildContext context, DetailedGlobalToggleProperties<T> global);

/// Custom builder for the wrapper of the switch.
typedef CustomWrapperBuilder<T> = Widget Function(
    BuildContext context, GlobalToggleProperties<T> local, Widget child);

/// Custom builder for the appearing animation of the indicator.
///
/// If [value] is [0.0], the indicator is completely disappeared.
///
/// If [value] is [1.0], the indicator is fully appeared.
typedef IndicatorAppearingBuilder = Widget Function(
    BuildContext context, double value, Widget indicator);

enum FittingMode { none, preventHorizontalOverlapping }

// global parameter default values
const _defaultIndicatorAppearingAnimationDuration = Duration(milliseconds: 350);
const _defaultIndicatorAppearingAnimationCurve = Curves.easeOutBack;

Widget _defaultIndicatorAppearingBuilder(
    BuildContext context, double value, Widget indicator) {
  return Transform.scale(scale: value, child: indicator);
}

enum IconArrangement {
  /// Indicates that the icons should be in a row.
  ///
  /// This is the default setting.
  row,

  /// Indicates that the icons should overlap.
  /// Normally you don't need this setting unless you want the icons to overlap.
  ///
  /// This is used for example with [AnimatedToggleSwitch.dual],
  /// because the texts partially overlap here.
  overlap
}

/// With this widget you can implement your own switches with nice animations.
///
/// For pre-made switches, please use the constructors of [AnimatedToggleSwitch]
/// instead.
class CustomAnimatedToggleSwitch<T> extends StatefulWidget {
  /// The currently selected value. It has to be set at [onChanged] or whenever for animating to this value.
  ///
  /// [current] has to be in [values] for working correctly.
  final T current;

  /// All possible values.
  final List<T> values;

  /// The IconBuilder for all icons with the specified size.
  final CustomWrapperBuilder<T>? wrapperBuilder;

  /// The IconBuilder for all icons with the specified size.
  final CustomIconBuilder<T> iconBuilder;

  /// A builder for an indicator which is in front of the icons.
  final CustomIndicatorBuilder<T>? foregroundIndicatorBuilder;

  /// A builder for an indicator which is in behind the icons.
  final CustomIndicatorBuilder<T>? backgroundIndicatorBuilder;

  /// Custom builder for the appearing animation of the indicator.
  ///
  /// If you want to use this feature, you have to set [allowUnlistedValues] to [true].
  ///
  /// An indicator can appear if [current] was previously not contained in [values].
  final IndicatorAppearingBuilder indicatorAppearingBuilder;

  /// Duration of the motion animation.
  final Duration animationDuration;

  /// Curve of the motion animation.
  final Curve animationCurve;

  /// Duration of the loading animation.
  ///
  /// Defaults to [animationDuration].
  final Duration? loadingAnimationDuration;

  /// Curve of the loading animation.
  ///
  /// Defaults to [animationCurve].
  final Curve? loadingAnimationCurve;

  /// Duration of the appearing animation.
  final Duration indicatorAppearingDuration;

  /// Curve of the appearing animation.
  final Curve indicatorAppearingCurve;

  /// Size of the indicator.
  final Size indicatorSize;

  /// Callback for selecting a new value. The new [current] should be set here.
  final Function(T)? onChanged;

  /// Space between the "indicator rooms" of the adjacent icons.
  final double dif;

  /// Callback for tapping anywhere on the widget.
  final Function()? onTap;

  /// Indicates if [onChanged] is called when an icon is tapped.
  /// If [false] the user can change the value only by dragging the indicator.
  final bool iconsTappable;

  /// Indicates if the icons should overlap.
  ///
  /// Defaults to [IconArrangement.row] because it fits the most use cases.
  final IconArrangement iconArrangement;

  /// The [FittingMode] of the switch.
  ///
  /// Change this only if you don't want the switch to adjust when the constraints are too small.
  final FittingMode fittingMode;

  /// The height of the whole switch including wrapper.
  final double height;

  /// A padding between wrapper and icons/indicator.
  final EdgeInsetsGeometry padding;

  /// The minimum width of the indicator's hitbox.
  ///
  /// Helpful if the indicator is so small that you can hardly grip it.
  final double minTouchTargetSize;

  /// The duration for the animation to the thumb when the user starts dragging.
  final Duration dragStartDuration;

  /// The curve for the animation to the thumb when the user starts dragging.
  final Curve dragStartCurve;

  /// The direction in which the icons are arranged.
  ///
  /// If set to [null], the [TextDirection] is taken from the [BuildContext].
  final TextDirection? textDirection;

  /// [MouseCursor] to show when not hovering an indicator.
  ///
  /// Defaults to [SystemMouseCursors.click] if [iconsTappable] is [true]
  /// and to [MouseCursor.defer] otherwise.
  final MouseCursor? defaultCursor;

  /// [MouseCursor] to show when grabbing the indicators.
  final MouseCursor draggingCursor;

  /// [MouseCursor] to show when hovering the indicators.
  final MouseCursor dragCursor;

  /// [MouseCursor] to show during loading.
  final MouseCursor loadingCursor;

  /// Indicates if the switch is currently loading.
  ///
  /// If set to [null], the switch is loading automatically when a [Future] is
  /// returned by [onChanged] or [onTap].
  final bool? loading;

  /// Indicates if an error should be thrown if [current] is not in [values].
  ///
  /// If [allowUnlistedValues] is [true] and [values] does not contain [current],
  /// the indicator disappears with the specified [indicatorAppearingBuilder].
  final bool allowUnlistedValues;

  const CustomAnimatedToggleSwitch({
    Key? key,
    required this.current,
    required this.values,
    required this.iconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.dif = 0.0,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.wrapperBuilder,
    this.foregroundIndicatorBuilder,
    this.backgroundIndicatorBuilder,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.height = 50.0,
    this.iconArrangement = IconArrangement.row,
    this.iconsTappable = true,
    this.padding = EdgeInsets.zero,
    this.minTouchTargetSize = 48.0,
    this.dragStartDuration = const Duration(milliseconds: 200),
    this.dragStartCurve = Curves.easeInOutCirc,
    this.textDirection,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.allowUnlistedValues = false,
  })  : assert(foregroundIndicatorBuilder != null ||
            backgroundIndicatorBuilder != null),
        super(key: key);

  @override
  _CustomAnimatedToggleSwitchState createState() =>
      _CustomAnimatedToggleSwitchState<T>();

  bool get _isCurrentUnlisted => !values.contains(current);
}

class _CustomAnimatedToggleSwitchState<T>
    extends State<CustomAnimatedToggleSwitch<T>> with TickerProviderStateMixin {
  /// The [AnimationController] for the movement of the indicator.
  late final AnimationController _controller;

  /// The [AnimationController] for the appearing of the indicator.
  late final AnimationController _appearingController;

  /// The [Animation] for the movement of the indicator.
  late CurvedAnimation _animation;

  /// The [Animation] for the appearing of the indicator.
  late CurvedAnimation _appearingAnimation;

  /// The current state of the movement of the indicator.
  late _AnimationInfo _animationInfo;

  @override
  void initState() {
    super.initState();

    final current = widget.current;
    final isValueSelected = widget.values.contains(current);
    _animationInfo = _AnimationInfo(
        isValueSelected ? widget.values.indexOf(current).toDouble() : 0.0);
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed &&
                _animationInfo.toggleMode != ToggleMode.dragged) {
              _animationInfo = _animationInfo.ended();
            }
          });

    _animation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);

    _appearingController = AnimationController(
      vsync: this,
      duration: widget.indicatorAppearingDuration,
      value: isValueSelected ? 1.0 : 0.0,
    );

    _appearingAnimation = CurvedAnimation(
      parent: _appearingController,
      curve: widget.indicatorAppearingCurve,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @pragma('vm:notify-debugger-on-exception')
  void _checkForUnlistedValue() {
    if (!widget.allowUnlistedValues && widget._isCurrentUnlisted) {
      try {
        throw ArgumentError(
            'The values in AnimatedToggleSwitch have to contain current if allowUnlistedValues is false.\n'
            'current: ${widget.current}\n'
            'values: ${widget.values}\n'
            'This error is only thrown in debug mode to minimize problems with the production app.');
      } catch (e, s) {
        if (kDebugMode) rethrow;
        FlutterError.reportError(FlutterErrorDetails(
            exception: e, stack: s, library: 'AnimatedToggleSwitch'));
      }
    }
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkForUnlistedValue();
    if (oldWidget.indicatorAppearingDuration !=
        widget.indicatorAppearingDuration) {
      _appearingController.duration = widget.indicatorAppearingDuration;
    }
    if (oldWidget.indicatorAppearingCurve != widget.indicatorAppearingCurve) {
      _appearingAnimation.curve = widget.indicatorAppearingCurve;
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
    if (oldWidget.animationCurve != widget.animationCurve) {
      _animation.curve = widget.animationCurve;
    }

    _checkValuePosition();
    if (oldWidget.loading != widget.loading) {
      if (widget.loading != null) _loading(widget.loading!);
    }
  }

  void _onChanged(T value) {
    var result = widget.onChanged?.call(value);
    if (result is Future && widget.loading == null) {
      _loading(true);
      result.onError((e, s) => null).then((value) => _loading(false));
    }
  }

  void _onTap() {
    if (_animationInfo.loading) return;
    var result = widget.onTap?.call();
    if (result is Future && widget.loading == null) {
      _loading(true);
      result.onError((e, s) => null).then((value) => _loading(false));
    }
  }

  void _loading(bool b) {
    if (b == _animationInfo.loading) return;
    if (_animationInfo.toggleMode == ToggleMode.dragged) {
      _animationInfo = _animationInfo.none();
      _checkValuePosition();
    }
    setState(() => _animationInfo = _animationInfo.setLoading(b));
  }

  /// Checks if the current value has a different position than the indicator
  /// and starts an animation if necessary.
  void _checkValuePosition() {
    if (_animationInfo.toggleMode == ToggleMode.dragged) return;
    final current = widget.current;
    if (widget.values.contains(widget.current)) {
      int index = widget.values.indexOf(current);
      _animateTo(index);
    } else {
      _appearingController.reverse();
    }
  }

  /// Returns the value position by the local position of the cursor.
  /// It is mainly intended as a helper function for the build method.
  double _doubleFromPosition(
      double x, DetailedGlobalToggleProperties properties) {
    double result = (x.clamp(
                properties.indicatorSize.width / 2,
                properties.switchSize.width -
                    properties.indicatorSize.width / 2) -
            properties.indicatorSize.width / 2) /
        (properties.indicatorSize.width + properties.dif);
    if (properties.textDirection == TextDirection.rtl)
      result = widget.values.length - 1 - result;
    return result;
  }

  /// Returns the value index by the local position of the cursor.
  /// It is mainly intended as a helper function for the build method.
  int _indexFromPosition(double x, DetailedGlobalToggleProperties properties) {
    return _doubleFromPosition(x, properties).round();
  }

  /// Returns the value by the local position of the cursor.
  /// It is mainly intended as a helper function for the build method.
  T _valueFromPosition(double x, DetailedGlobalToggleProperties properties) {
    return widget.values[_indexFromPosition(x, properties)];
  }

  @override
  Widget build(BuildContext context) {
    double dif = widget.dif;
    final textDirection = _textDirectionOf(context);
    final loadingValue = _animationInfo.loading ? 1.0 : 0.0;

    return SizedBox(
      height: widget.height,
      child: TweenAnimationBuilder<double>(
        duration: widget.loadingAnimationDuration ?? widget.animationDuration,
        curve: widget.loadingAnimationCurve ?? widget.animationCurve,
        tween: Tween(begin: loadingValue, end: loadingValue),
        builder: (context, loadingValue, child) => AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              double positionValue = _animationInfo
                  .valueAt(_animation.value)
                  .clamp(0, widget.values.length - 1);
              GlobalToggleProperties<T> properties = GlobalToggleProperties(
                position: positionValue,
                current: widget.current,
                previous: _animationInfo.start.toInt() == _animationInfo.start
                    ? widget.values[_animationInfo.start.toInt()]
                    : null,
                values: widget.values,
                previousPosition: _animationInfo.start,
                textDirection: textDirection,
                mode: _animationInfo.toggleMode,
                loadingAnimationValue: loadingValue,
              );
              Widget child = Padding(
                padding: widget.padding,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double height = constraints.maxHeight;
                    assert(
                        constraints.maxWidth.isFinite ||
                            (widget.indicatorSize.width.isFinite &&
                                dif.isFinite),
                        "With unbound width constraints "
                        "the width of the indicator and the dif "
                        "can't be infinite");
                    assert(
                        widget.indicatorSize.width.isFinite || dif.isFinite,
                        "The width of the indicator "
                        "or the dif must be finite.");

                    // Recalculates the indicatorSize if its width or height is
                    // infinite.
                    Size indicatorSize = Size(
                        widget.indicatorSize.width.isInfinite
                            ? (constraints.maxWidth -
                                    dif * (widget.values.length - 1)) /
                                widget.values.length
                            : widget.indicatorSize.width,
                        widget.indicatorSize.height.isInfinite
                            ? height
                            : widget.indicatorSize.height);

                    if (dif.isInfinite) {
                      dif = (constraints.maxWidth -
                              widget.indicatorSize.width *
                                  widget.values.length) /
                          (widget.values.length - 1);
                    }

                    // Calculates the required width of the widget.
                    double width = indicatorSize.width * widget.values.length +
                        (widget.values.length - 1) * dif;

                    // Handles the case that the required width of the widget
                    // cannot be used due to the given BoxConstraints.
                    if (widget.fittingMode ==
                            FittingMode.preventHorizontalOverlapping &&
                        width > constraints.maxWidth) {
                      double factor = constraints.maxWidth / width;
                      dif *= factor;
                      width = constraints.maxWidth;
                      indicatorSize = Size(
                          indicatorSize.width.isInfinite
                              ? width / widget.values.length
                              : factor * indicatorSize.width,
                          indicatorSize.height);
                    } else if (constraints.minWidth > width) {
                      dif += (constraints.minWidth - width) /
                          (widget.values.length - 1);
                      width = constraints.minWidth;
                    }

                    // The additional width of the indicator's hitbox needed
                    // to reach the minTouchTargetSize.
                    double dragDif =
                        indicatorSize.width < widget.minTouchTargetSize
                            ? (widget.minTouchTargetSize - indicatorSize.width)
                            : 0;

                    // The local position of the indicator.
                    double position =
                        (indicatorSize.width + dif) * positionValue +
                            indicatorSize.width / 2;

                    double leftPosition = textDirection == TextDirection.rtl
                        ? width - position
                        : position;

                    bool isHoveringIndicator(Offset offset) {
                      if (_animationInfo.loading || widget._isCurrentUnlisted)
                        return false;
                      double dx = textDirection == TextDirection.rtl
                          ? width - offset.dx
                          : offset.dx;
                      return position - (indicatorSize.width + dragDif) / 2 <=
                              dx &&
                          dx <=
                              (position + (indicatorSize.width + dragDif) / 2);
                    }

                    DetailedGlobalToggleProperties<T> properties =
                        DetailedGlobalToggleProperties(
                      dif: dif,
                      position: positionValue,
                      indicatorSize: indicatorSize,
                      switchSize: Size(width, height),
                      current: widget.current,
                      previous:
                          _animationInfo.start.toInt() == _animationInfo.start
                              ? widget.values[_animationInfo.start.toInt()]
                              : null,
                      values: widget.values,
                      previousPosition: _animationInfo.start,
                      textDirection: textDirection,
                      mode: _animationInfo.toggleMode,
                      loadingAnimationValue: loadingValue,
                    );

                    List<Widget> stack = <Widget>[
                      if (widget.backgroundIndicatorBuilder != null)
                        _Indicator(
                          textDirection: textDirection,
                          height: height,
                          indicatorSize: indicatorSize,
                          position: position,
                          appearingAnimation: _appearingAnimation,
                          appearingBuilder: widget.indicatorAppearingBuilder,
                          child: widget.backgroundIndicatorBuilder!(
                              context, properties),
                        ),
                      ...(widget.iconArrangement == IconArrangement.overlap
                          ? _buildBackgroundStack(context, properties)
                          : _buildBackgroundRow(context, properties)),
                      if (widget.foregroundIndicatorBuilder != null)
                        _Indicator(
                          textDirection: textDirection,
                          height: height,
                          indicatorSize: indicatorSize,
                          position: position,
                          appearingAnimation: _appearingAnimation,
                          appearingBuilder: widget.indicatorAppearingBuilder,
                          child: widget.foregroundIndicatorBuilder!(
                              context, properties),
                        ),
                    ];

                    return _WidgetPart(
                      left: loadingValue *
                          (leftPosition - 0.5 * indicatorSize.width),
                      width: indicatorSize.width +
                          (1 - loadingValue) * (width - indicatorSize.width),
                      height: height,
                      child: SizedBox(
                        width: width,
                        height: height,
                        // manual check if cursor is above indicator
                        // to make sure that GestureDetector and MouseRegion match.
                        // TODO: one widget for DragRegion and GestureDetector to avoid redundancy
                        child: DragRegion(
                          dragging:
                              _animationInfo.toggleMode == ToggleMode.dragged,
                          draggingCursor: widget.draggingCursor,
                          dragCursor: widget.dragCursor,
                          hoverCheck: isHoveringIndicator,
                          defaultCursor: _animationInfo.loading
                              ? widget.loadingCursor
                              : (widget.defaultCursor ??
                                  (widget.iconsTappable
                                      ? SystemMouseCursors.click
                                      : MouseCursor.defer)),
                          child: GestureDetector(
                            dragStartBehavior: DragStartBehavior.down,
                            onTapUp: (details) {
                              _onTap();
                              if (!widget.iconsTappable) return;
                              T newValue = _valueFromPosition(
                                  details.localPosition.dx, properties);
                              if (newValue == widget.current) return;
                              _onChanged(newValue);
                            },
                            onHorizontalDragStart: (details) {
                              if (!isHoveringIndicator(details.localPosition))
                                return;
                              _onDragged(
                                  _doubleFromPosition(
                                      details.localPosition.dx, properties),
                                  positionValue);
                            },
                            onHorizontalDragUpdate: (details) {
                              _onDragUpdate(_doubleFromPosition(
                                  details.localPosition.dx, properties));
                            },
                            onHorizontalDragEnd: (details) {
                              _onDragEnd();
                            },
                            // DecoratedBox for gesture detection
                            child: DecoratedBox(
                                position: DecorationPosition.background,
                                decoration: const BoxDecoration(),
                                child: Stack(
                                    clipBehavior: Clip.none, children: stack)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
              return widget.wrapperBuilder?.call(context, properties, child) ??
                  child;
            }),
      ),
    );
  }

  /// The builder of the icons for [IconArrangement.overlap].
  List<Positioned> _buildBackgroundStack(
      BuildContext context, DetailedGlobalToggleProperties<T> properties) {
    return List.generate(widget.values.length, (i) {
      double position = i * (properties.indicatorSize.width + properties.dif);
      return Positioned.directional(
        textDirection: _textDirectionOf(context),
        start: i == 0 ? position : position - properties.dif,
        width:
            (i == 0 || i == widget.values.length - 1 ? 1 : 2) * properties.dif +
                properties.indicatorSize.width,
        height: properties.indicatorSize.height,
        child: widget.iconBuilder(
            context,
            LocalToggleProperties(value: widget.values[i], index: i),
            properties),
      );
    }).toList();
  }

  /// The builder of the icons for [IconArrangement.row].
  List<Widget> _buildBackgroundRow(
      BuildContext context, DetailedGlobalToggleProperties<T> properties) {
    return [
      Row(
        textDirection: _textDirectionOf(context),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          widget.values.length,
          (i) => SizedBox(
            width: properties.indicatorSize.width,
            height: properties.indicatorSize.height,
            child: widget.iconBuilder(
                context,
                LocalToggleProperties(value: widget.values[i], index: i),
                properties),
          ),
        ),
      ),
    ];
  }

  /// Animates the indicator to a specific item by its index.
  void _animateTo(int index, {double? current}) {
    if (_animationInfo.toggleMode == ToggleMode.dragged) return;
    if (_appearingController.value > 0.0) {
      if (index.toDouble() != _animationInfo.end) {
        _animationInfo = _animationInfo.toEnd(index.toDouble(),
            current: current ?? _animationInfo.valueAt(_animation.value));
        _controller.duration = widget.animationDuration;
        _animation.curve = widget.animationCurve;
        _controller.forward(from: 0.0);
      }
    } else {
      _animationInfo = _animationInfo.toEnd(index.toDouble()).ended();
    }
    _appearingController.forward();
  }

  /// Starts the dragging of the indicator and starts the animation to
  /// the current cursor position.
  void _onDragged(double indexPosition, double pos) {
    if (_animationInfo.loading) return;
    _animationInfo = _animationInfo.dragged(indexPosition, pos: pos);
    _controller.duration = widget.dragStartDuration;
    _animation.curve = widget.dragStartCurve;
    _controller.forward(from: 0.0);
  }

  /// Updates the current drag position.
  void _onDragUpdate(double indexPosition) {
    if (_animationInfo.toggleMode != ToggleMode.dragged) return;
    setState(() {
      _animationInfo = _animationInfo.dragged(indexPosition);
    });
  }

  /// Ends the dragging of the indicator and starts an animation
  /// to the new value if necessary.
  void _onDragEnd() {
    if (_animationInfo.toggleMode != ToggleMode.dragged) return;
    int index = _animationInfo.end.round();
    T newValue = widget.values[index];
    _animationInfo = _animationInfo.none(current: _animationInfo.end);
    if (widget.current != newValue) _onChanged(newValue);
    _checkValuePosition();
  }

  /// Returns the [TextDirection] of the widget.
  TextDirection _textDirectionOf(BuildContext context) =>
      widget.textDirection ??
      Directionality.maybeOf(context) ??
      TextDirection.ltr;
}

/// The [Positioned] for an indicator. It is used as wrapper for
/// [CustomAnimatedToggleSwitch.foregroundIndicatorBuilder] and
/// [CustomAnimatedToggleSwitch.backgroundIndicatorBuilder].
class _Indicator extends StatelessWidget {
  final double height;
  final Size indicatorSize;
  final double position;
  final Widget child;
  final TextDirection textDirection;
  final Animation<double> appearingAnimation;
  final IndicatorAppearingBuilder appearingBuilder;

  const _Indicator({
    required this.height,
    required this.indicatorSize,
    required this.position,
    required this.textDirection,
    required this.appearingAnimation,
    required this.appearingBuilder,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.directional(
      textDirection: textDirection,
      top: (height - indicatorSize.height) / 2,
      start: position - indicatorSize.width / 2,
      width: indicatorSize.width,
      height: indicatorSize.height,
      child: AnimatedBuilder(
          animation: appearingAnimation,
          builder: (context, _) {
            return appearingBuilder(context, appearingAnimation.value, child);
          }),
    );
  }
}

class _WidgetPart extends StatelessWidget {
  final double width, height;
  final double left;
  final Widget child;

  const _WidgetPart({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    required this.left,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Transform.translate(offset: Offset(-left, 0), child: child),
      ),
    );
  }
}

/// A class for holding the current state of [_CustomAnimatedToggleSwitchState].
class _AnimationInfo {
  final double start;
  final double end;
  final ToggleMode toggleMode;
  final bool loading;

  const _AnimationInfo(
    this.start, {
    this.toggleMode = ToggleMode.none,
    this.loading = false,
  }) : end = start;

  const _AnimationInfo._internal(
    this.start,
    this.end, {
    this.toggleMode = ToggleMode.none,
    this.loading = false,
  });

  const _AnimationInfo.animating(
    this.start,
    this.end, {
    this.loading = false,
  }) : toggleMode = ToggleMode.animating;

  _AnimationInfo toEnd(double end, {double? current}) =>
      _AnimationInfo.animating(current ?? start, end, loading: loading);

  _AnimationInfo none({double? current}) => _AnimationInfo(current ?? start,
      toggleMode: ToggleMode.none, loading: loading);

  _AnimationInfo ended() => _AnimationInfo(end, loading: loading);

  _AnimationInfo dragged(double current, {double? pos}) =>
      _AnimationInfo._internal(
        pos ?? start,
        current,
        toggleMode: ToggleMode.dragged,
        loading: false,
      );

  _AnimationInfo setLoading(bool loading) =>
      _AnimationInfo._internal(start, end,
          toggleMode: toggleMode, loading: loading);

  double valueAt(num position) => start + (end - start) * position;
}
