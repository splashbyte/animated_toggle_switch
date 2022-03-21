import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:animated_toggle_switch/src/utils.dart';
import 'package:animated_toggle_switch/src/widgets/drag_region.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Custom builder for icons in the switch.
typedef CustomIconBuilder<T> = Widget Function(BuildContext context,
    LocalToggleProperties<T> local, DetailedGlobalToggleProperties<T> global);

/// Custom builder for the indicator of the switch.
typedef CustomIndicatorBuilder<T> = Widget Function(
    BuildContext context, DetailedGlobalToggleProperties<T> global);

/// Custom builder for the wrapper of the switch.
typedef CustomWrapperBuilder<T> = Widget Function(
    BuildContext conext, GlobalToggleProperties<T> local, Widget child);

enum FittingMode { none, preventHorizontalOverlapping }

enum IconArrangement {
  /// Indicates that the icons should be in a row.
  ///
  /// This is the default setting.
  row,

  /// Indicates that the icons should overlap.
  /// Normally you don't need this setting unless you want the icons to overlap.
  /// This is used for example with [AnimatedToggleSwitch.dual],
  /// because the texts partially overlap here.
  overlap
}

class CustomAnimatedToggleSwitch<T> extends StatefulWidget {
  /// The currently selected value. It has to be set at [onChanged] or whenever for animating to this value.
  ///
  /// [value] has to be in [values] for working correctly.
  final T value;

  /// All possible values.
  final List<T> values;

  /// The IconBuilder for all icons with the specified size.
  final CustomWrapperBuilder<T> wrapperBuilder;

  /// The IconBuilder for all icons with the specified size.
  final CustomIconBuilder<T> iconBuilder;

  final CustomIndicatorBuilder<T>? foregroundIndicatorBuilder;
  final CustomIndicatorBuilder<T>? backgroundIndicatorBuilder;

  /// Duration of the motion animation.
  final Duration animationDuration;

  /// Curve of the motion animation.
  final Curve animationCurve;

  /// Size of the indicator.
  final Size indicatorSize;

  /// Callback for selecting a new value. The new [value] should be set here.
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

  final FittingMode fittingMode;

  /// The height of the whole switch including wrapper.
  final double height;

  /// A padding between wrapper and icons/indicator.
  final EdgeInsetsGeometry padding;

  /// A padding between wrapper and icons/indicator.
  final double minTouchTargetSize;

  /// The duration for the animation to the thumb when the user starts dragging.
  final Duration dragStartDuration;

  /// The curve for the animation to the thumb when the user starts dragging.
  final Curve dragStartCurve;

  const CustomAnimatedToggleSwitch({
    Key? key,
    required this.value,
    required this.values,
    required this.iconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.dif = 0.0,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    required this.wrapperBuilder,
    this.foregroundIndicatorBuilder,
    this.backgroundIndicatorBuilder,
    this.height = 50.0,
    this.iconArrangement = IconArrangement.row,
    this.iconsTappable = true,
    this.padding = EdgeInsets.zero,
    this.minTouchTargetSize = 48.0,
    this.dragStartDuration = const Duration(milliseconds: 200),
    this.dragStartCurve = Curves.easeInOutCirc,
  })  : assert(foregroundIndicatorBuilder != null ||
            backgroundIndicatorBuilder != null),
        super(key: key);

  @override
  _CustomAnimatedToggleSwitchState createState() =>
      _CustomAnimatedToggleSwitchState<T>();
}

class _CustomAnimatedToggleSwitchState<T>
    extends State<CustomAnimatedToggleSwitch<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late _AnimationInfo _animationInfo;
  late CurvedAnimation _animation;
  Offset? _lastTapDownOffset;

  @override
  void initState() {
    super.initState();

    _animationInfo =
        _AnimationInfo(widget.values.indexOf(widget.value).toDouble());
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addListener(() {
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
              setState(() {});
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed &&
                _animationInfo.moveMode != MoveMode.dragged) {
              _animationInfo = _animationInfo.ended();
            }
          });

    _animation =
        CurvedAnimation(parent: _controller, curve: widget.animationCurve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomAnimatedToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
    _animation.curve = widget.animationCurve;

    if (oldWidget.value != widget.value) {
      int index = widget.values.indexOf(widget.value);
      _animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    double dif = widget.dif;

    return SizedBox(
      height: widget.height,
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            double positionValue = _animationInfo
                .valueAt(_animation.value)
                .clamp(0, widget.values.length - 1);
            GlobalToggleProperties<T> properties = GlobalToggleProperties(
                position: positionValue,
                value: widget.value,
                previousValue:
                    _animationInfo.start.toInt() == _animationInfo.start
                        ? widget.values[_animationInfo.start.toInt()]
                        : null,
                previousPosition: _animationInfo.start);
            Widget child = Padding(
              padding: widget.padding,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;
                  Size indicatorSize = Size(
                      widget.indicatorSize.width.isInfinite
                          ? (constraints.maxWidth -
                                  dif * (widget.values.length - 1)) /
                              widget.values.length
                          : widget.indicatorSize.width,
                      widget.indicatorSize.height.isInfinite
                          ? height
                          : widget.indicatorSize.height);
                  double width = indicatorSize.width * widget.values.length +
                      (widget.values.length - 1) * dif;
                  if (widget.fittingMode ==
                          FittingMode.preventHorizontalOverlapping &&
                      width > constraints.maxWidth) {
                    double factor = constraints.maxWidth / width;
                    dif *= factor;
                    indicatorSize = Size(
                        indicatorSize.width.isInfinite
                            ? width / widget.values.length
                            : factor * indicatorSize.width,
                        indicatorSize.height);
                  }

                  double dragDif =
                      indicatorSize.width < widget.minTouchTargetSize
                          ? (widget.minTouchTargetSize - indicatorSize.width)
                          : 0;

                  double position =
                      (indicatorSize.width + dif) * positionValue +
                          indicatorSize.width / 2;

                  bool Function(Offset offset) isHoveringIndicator = (offset) =>
                      position - (indicatorSize.width + dragDif) / 2 <=
                          offset.dx &&
                      offset.dx <=
                          (position + (indicatorSize.width + dragDif) / 2);

                  DetailedGlobalToggleProperties<T> properties =
                      DetailedGlobalToggleProperties(
                          dif: dif,
                          position: positionValue,
                          indicatorSize: indicatorSize,
                          value: widget.value,
                          previousValue: _animationInfo.start.toInt() ==
                                  _animationInfo.start
                              ? widget.values[_animationInfo.start.toInt()]
                              : null,
                          previousPosition: _animationInfo.start);

                  double doubleFromPosition(double x) {
                    return (x.clamp(indicatorSize.width / 2,
                                width - indicatorSize.width / 2) -
                            indicatorSize.width / 2) /
                        (indicatorSize.width + dif);
                  }

                  int indexFromPosition(double x) {
                    return doubleFromPosition(x).round();
                  }

                  T valueFromPosition(double x) {
                    return widget.values[indexFromPosition(x)];
                  }

                  List<Widget> stack = <Widget>[
                    if (widget.backgroundIndicatorBuilder != null)
                      _Indicator(
                        height: height,
                        indicatorSize: indicatorSize,
                        dragDif: dragDif,
                        animationInfo: _animationInfo,
                        position: position,
                        child: widget.backgroundIndicatorBuilder!(
                            context, properties),
                      ),
                    Stack(
                        clipBehavior: Clip.none,
                        children:
                            widget.iconArrangement == IconArrangement.overlap
                                ? _buildBackgroundStack(context, properties)
                                : _buildBackgroundRow(context, properties)),
                    if (widget.foregroundIndicatorBuilder != null)
                      _Indicator(
                        height: height,
                        indicatorSize: indicatorSize,
                        dragDif: dragDif,
                        animationInfo: _animationInfo,
                        position: position,
                        child: widget.foregroundIndicatorBuilder!(
                            context, properties),
                      ),
                  ];

                  return SizedBox(
                    width: width,
                    height: height,
                    // manual check if cursor is above indicator
                    // to make sure that GestureDetector and MouseRegion match.
                    // TODO: one widget for DragRegion and GestureDetector to avoid redundancy
                    child: DragRegion(
                      dragging: _animationInfo.moveMode == MoveMode.dragged,
                      hoverCheck: (offset) => isHoveringIndicator(offset),
                      child: GestureDetector(
                        onTapUp: (details) {
                          widget.onTap?.call();
                          T newValue =
                              valueFromPosition(details.localPosition.dx);
                          if (newValue == widget.value || !widget.iconsTappable)
                            return;
                          widget.onChanged?.call(newValue);
                        },
                        onTapDown: (details) =>
                            _lastTapDownOffset = details.localPosition,
                        onHorizontalDragStart: (details) {
                          if (_lastTapDownOffset == null ||
                              !isHoveringIndicator(_lastTapDownOffset!)) return;
                          _onDragged(
                              doubleFromPosition(details.localPosition.dx),
                              positionValue);
                        },
                        onHorizontalDragUpdate: (details) {
                          _onDragUpdate(
                              doubleFromPosition(details.localPosition.dx));
                        },
                        onHorizontalDragEnd: (details) {
                          _onDragEnd();
                        },
                        // DecoratedBox for gesture detection
                        child: DecoratedBox(
                            position: DecorationPosition.background,
                            decoration: BoxDecoration(),
                            child: Stack(
                                clipBehavior: Clip.none, children: stack)),
                      ),
                    ),
                  );
                },
              ),
            );
            return widget.wrapperBuilder(context, properties, child);
          }),
    );
  }

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

  List<Widget> _buildBackgroundRow(
      BuildContext context, DetailedGlobalToggleProperties<T> properties) {
    return [
      Row(
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

  void _animateTo(int index, {double? current}) {
    if (index.toDouble() != _animationInfo.end &&
        _animationInfo.moveMode != MoveMode.dragged) {
      _animationInfo = _animationInfo.toEnd(index.toDouble(),
          current: current ?? _animationInfo.valueAt(_animation.value));
      _controller.duration = widget.animationDuration;
      _animation.curve = widget.animationCurve;
      _controller.forward(from: 0.0);
    }
  }

  void _onDragged(double indexPosition, double pos) {
    _animationInfo = _animationInfo.dragged(indexPosition, pos: pos);
    _controller.duration = widget.dragStartDuration;
    _animation.curve = widget.dragStartCurve;
    _controller.forward(from: 0.0);
  }

  void _onDragUpdate(double indexPosition) {
    if (_animationInfo.moveMode != MoveMode.dragged) return;
    setState(() {
      _animationInfo = _animationInfo.dragged(indexPosition);
    });
  }

  void _onDragEnd() {
    if (_animationInfo.moveMode != MoveMode.dragged) return;
    int index = _animationInfo.end.round();
    T newValue = widget.values[index];
    if (widget.value != newValue) widget.onChanged?.call(newValue);
    _animationInfo = _animationInfo.none(current: _animationInfo.end);
    _animateTo(index, current: _animationInfo.end);
  }
}

class _Indicator extends StatelessWidget {
  final double height;
  final Size indicatorSize;
  final double position;
  final double dragDif;
  final _AnimationInfo animationInfo;
  final Widget child;

  const _Indicator({
    Key? key,
    required this.height,
    required this.indicatorSize,
    required this.position,
    required this.dragDif,
    required this.animationInfo,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (height - indicatorSize.height) / 2,
      left: position - (indicatorSize.width + dragDif) / 2,
      width: indicatorSize.width + dragDif,
      height: indicatorSize.height,
      child: Center(
        child: SizedBox(
          width: indicatorSize.width,
          child: child,
        ),
      ),
    );
  }
}

TextDirection _textDirectionOf(BuildContext context) =>
    Directionality.maybeOf(context) ?? TextDirection.ltr;

class _AnimationInfo {
  final double start;
  final double end;
  final MoveMode moveMode;

  const _AnimationInfo(this.start, {this.moveMode = MoveMode.none})
      : end = start;

  const _AnimationInfo._internal(this.start, this.end,
      {this.moveMode = MoveMode.none});

  const _AnimationInfo.animating(this.start, this.end)
      : moveMode = MoveMode.animating;

  _AnimationInfo toEnd(double end, {double? current}) =>
      _AnimationInfo.animating(current ?? start, end);

  _AnimationInfo none({double? current}) =>
      _AnimationInfo(current ?? start, moveMode: MoveMode.none);

  _AnimationInfo ended() => _AnimationInfo(end);

  _AnimationInfo dragged(double current, {double? pos}) =>
      _AnimationInfo._internal(
        pos ?? start,
        current,
        moveMode: MoveMode.dragged,
      );

  double valueAt(num position) => start + (end - start) * position;
}
