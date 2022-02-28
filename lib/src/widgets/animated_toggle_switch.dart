import 'dart:math';

import 'package:animated_toggle_switch/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef IconBuilder<T> = Widget Function(T t, Size size, bool active);

/// A version of IconBuilder for writing a own Animation on the change of the selected item.
typedef AnimatedIconBuilder<T> = Widget Function(
    T t, double value, bool active);

/// Own builder for the background of the switch. It has to return the Widgets which should be in the Stack with the indicator.
typedef BackgroundBuilder = List<Widget> Function(
    Size size, Size indicatorSize, double dif, double positionValue);

typedef ColorBuilder<T> = Color? Function(T t);

enum AnimationType { onSelected, onHover }

enum FittingMode { none, preventHorizontalOverlapping }

class AnimatedToggleSwitch<T> extends StatefulWidget {
  /// The currently selected value. It has to be set at [onChanged] or whenever for animating to this value.
  ///
  /// [current] has to be in [values] for working correctly.
  final T current;

  /// All possible values.
  final List<T> values;

  /// The IconBuilder for all icons with the specified size.
  final AnimatedIconBuilder<T>? animatedIconBuilder;

  /// Builder for the color of the indicator depending on the current value.
  final ColorBuilder<T>? colorBuilder;

  /// Duration of the motion animation.
  final Duration animationDuration;

  /// If null, [animationDuration] is taken.
  ///
  /// [iconAnimationDuration] defines the duration of the Animation built in [animatedIconBuilder].
  /// In some constructors this is the Duration of the size animation.
  final Duration? iconAnimationDuration;

  /// Curve of the motion animation.
  final Curve animationCurve;

  /// [iconAnimationCurve] defines the duration of the Animation built in [animatedIconBuilder].
  /// In some constructors this is the [Curve] of the size animation.
  final Curve iconAnimationCurve;

  /// Size of the indicator.
  final Size indicatorSize;

  /// Callback for selecting a new value. The new [current] should be set here.
  final Function(T)? onChanged;

  /// Width of the border of the switch. For deactivating please set this to 0.0 and set [borderColor] to Colors.transparent.
  final double borderWidth;

  /// BorderRadius of the border. If this is null, the standard BorderRadius is taken.
  final BorderRadiusGeometry? borderRadius;

  /// Standard color of the border of the switch. For deactivating please set this to Colors.transparent and set [borderWidth] to 0.0.
  final Color? borderColor;

  /// Color of the background.
  final Color? innerColor;

  /// Opacity for the icons.
  ///
  /// Please set [iconOpacity] and [selectedIconOpacity] to 1.0 for deactivating the AnimatedOpacity.
  final double iconOpacity;

  /// Opacity for the currently selected icon.
  ///
  /// Please set [iconOpacity] and [selectedIconOpacity] to 1.0 for deactivating the AnimatedOpacity.
  final double selectedIconOpacity;

  /// Space between the "indicator rooms" of the adjacent icons.
  final double dif;

  /// Total height of the widget.
  final double height;

  /// If null, the indicator is behind the icons. Otherwise an icon is in the indicator and is built using this Function.
  final Widget Function(double value, Size size)?
      foregroundIndicatorIconBuilder;

  /// Standard Indicator Color
  final Color? indicatorColor;

  /// A builder for the Color of the Border. Can be used alternatively to [borderColor].
  final ColorBuilder<T>? borderColorBuilder;

  /// Which iconAnimationType for the [animatedIconBuilder] should be taken?
  final AnimationType iconAnimationType;

  /// Which iconAnimationType for the indicator should be taken?
  final AnimationType indicatorAnimationType;

  /// Callback for tapping anywhere on the widget.
  final Function()? onTap;

  final bool _iconsInStack;

  final BackgroundBuilder? backgroundBuilder;

  final FittingMode fittingMode;

  final BoxBorder? foregroundBorder;

  /// Shadow for the indicator [Container].
  final List<BoxShadow> foregroundBoxShadow;

  /// Shadow for the [Container] in the background.
  final List<BoxShadow> boxShadow;

  /// Constructor of AnimatedToggleSwitch with all possible settings.
  const AnimatedToggleSwitch.custom({
    Key? key,
    required this.current,
    required this.values,
    this.animatedIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.borderColorBuilder,
    this.iconAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  /// Provides an [AnimatedToggleSwitch] with the standard size animation of the icons.
  AnimatedToggleSwitch.size({
    Key? key,
    required this.current,
    required this.values,
    IconBuilder<T>? iconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    iconSize = const Size(23.0, 23.0),
    selectedIconSize = const Size(34.5, 34.5),
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.borderColorBuilder,
    this.iconAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : animatedIconBuilder = _iconSizeBuilder<T>(iconBuilder, iconSize, selectedIconSize),
        this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  /// All size values ([indicatorWidth], [iconSize], [selectedIconSize]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  AnimatedToggleSwitch.sizeByHeight({
    Key? key,
    this.height = 50.0,
    required this.current,
    required this.values,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    IconBuilder<T>? iconBuilder,
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    iconSize = const Size(0.5, 0.5),
    selectedIconSize = const Size(0.75, 0.75),
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.borderRadius,
    dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.borderColorBuilder,
    this.iconAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this.dif = dif * (height - 2 * borderWidth),
        animatedIconBuilder = _iconSizeBuilder<T>(
            iconBuilder,
            iconSize * (height + 2 * borderWidth),
            selectedIconSize * (height + 2 * borderWidth)),
        this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  static AnimatedIconBuilder<T>? _iconSizeBuilder<T>(
      IconBuilder<T>? iconBuilder, Size iconSize, Size selectedIconSize) {
    return iconBuilder == null
        ? null
        : (T t, double value, bool active) => iconBuilder(
              t,
              Size(
                  iconSize.width +
                      (selectedIconSize.width - iconSize.width) * value,
                  iconSize.height +
                      (selectedIconSize.height - iconSize.height) * value),
              active,
            );
  }

  /// Another version of [AnimatedToggleSwitch.custom].
  ///
  /// All size values ([indicatorWidth]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  const AnimatedToggleSwitch.byHeight({
    Key? key,
    this.height = 50.0,
    required this.current,
    required this.values,
    this.animatedIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.borderRadius,
    dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.borderColorBuilder,
    this.iconAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this.dif = dif * (height - 2 * borderWidth),
        this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  /// Special version of [AnimatedToggleSwitch.byHeight].
  ///
  /// All size values ([indicatorWidth], [iconSize], [selectedIconSize]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  AnimatedToggleSwitch.rollingByHeight({
    Key? key,
    this.height = 50.0,
    required this.current,
    required this.values,
    IconBuilder<T>? iconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    double iconRadius = 0.25,
    double selectedIconRadius = 0.35,
    this.iconOpacity = 0.5,
    this.borderRadius,
    double dif = 0.0,
    this.borderColorBuilder,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this.iconAnimationCurve = Curves.linear,
        this.dif = dif * (height - 2 * borderWidth),
        this.iconAnimationDuration = Duration.zero,
        this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this.selectedIconOpacity = iconOpacity,
        this.iconAnimationType = AnimationType.onSelected,
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder(
                values,
                dif,
                iconBuilder,
                Size.square(
                    selectedIconRadius * 2 * (height - 2 * borderWidth))),
        animatedIconBuilder = _standardIconBuilder(
            iconBuilder,
            Size.square(iconRadius * 2 * (height - 2 * borderWidth)),
            Size.square(iconRadius * 2 * (height - 2 * borderWidth))),
        this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  /// Defining an rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  AnimatedToggleSwitch.rolling({
    Key? key,
    required this.current,
    required this.values,
    IconBuilder<T>? iconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(46.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    double iconRadius = 11.5,
    double selectedIconRadius = 16.1,
    this.iconOpacity = 0.5,
    this.borderRadius,
    this.dif = 0.0,
    this.height = 50.0,
    this.borderColorBuilder,
    this.indicatorAnimationType = AnimationType.onSelected,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this.iconAnimationCurve = Curves.linear,
        this.iconAnimationDuration = Duration.zero,
        this.selectedIconOpacity = iconOpacity,
        this.iconAnimationType = AnimationType.onSelected,
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder(
                values, dif, iconBuilder, Size.square(selectedIconRadius * 2)),
        this.animatedIconBuilder = _standardIconBuilder(iconBuilder,
            Size.square(iconRadius * 2), Size.square(iconRadius * 2)),
        this._iconsInStack = false,
        this.backgroundBuilder = null,
        super(key: key);

  @override
  _AnimatedToggleSwitchState createState() => _AnimatedToggleSwitchState<T>();

  static Widget Function(double value, Size size)
      _rollingForegroundIndicatorIconBuilder<T>(List<T> values, double dif,
          IconBuilder<T>? iconBuilder, Size iconSize) {
    return (value, indicatorSize) {
      double distance = dif + indicatorSize.width;
      double angleDistance = distance / iconSize.longestSide * 2;
      double transitionValue = value - value.floorToDouble();
      return Stack(
        children: [
          Transform.rotate(
            angle: transitionValue * angleDistance,
            child: Opacity(
                opacity: 1 - transitionValue,
                child:
                    iconBuilder?.call(values[value.floor()], iconSize, true)),
          ),
          Transform.rotate(
            angle: (transitionValue - 1) * angleDistance,
            child: Opacity(
                opacity: transitionValue,
                child: iconBuilder?.call(values[value.ceil()], iconSize, true)),
          ),
        ],
      );
    };
  }

  static AnimatedIconBuilder<T>? _standardIconBuilder<T>(
      IconBuilder<T>? iconBuilder, Size iconSize, Size selectedIconSize) {
    return iconBuilder == null
        ? null
        : (T t, double value, bool active) => iconBuilder(
              t,
              active ? selectedIconSize : iconSize,
              false,
            );
  }

  /// Defining an rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  AnimatedToggleSwitch.dual({
    Key? key,
    required this.current,
    required T first,
    required T second,
    IconBuilder<T>? iconBuilder,
    IconBuilder<T>? textBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(46.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.borderColor,
    this.innerColor,
    this.indicatorColor,
    this.colorBuilder,
    double iconRadius = 16.1,
    this.borderRadius,
    this.dif = 40.0,
    this.height = 50.0,
    this.iconAnimationDuration = const Duration(milliseconds: 500),
    this.iconAnimationCurve = Curves.easeInOut,
    this.borderColorBuilder,
    this.indicatorAnimationType = AnimationType.onHover,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    Function()? onTap,
    this.foregroundBorder,
    this.foregroundBoxShadow = const [],
    this.boxShadow = const [],
  })  : this.iconOpacity = 1.0,
        this.selectedIconOpacity = 1.0,
        this.values = [first, second],
        this.iconAnimationType = AnimationType.onHover,
        this.onTap = onTap ?? _dualOnTap(onChanged, [first, second], current),
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder(
                [first, second], dif, iconBuilder, Size.square(iconRadius * 2)),
        this.animatedIconBuilder = _dualIconBuilder(
            textBuilder, Size.square(iconRadius * 2), [first, second], dif),
        this._iconsInStack = true,
        this.backgroundBuilder = null,
        super(key: key);

  static Function() _dualOnTap<T>(
      Function(T)? onChanged, List<T> values, T current) {
    return () =>
        onChanged?.call(values.firstWhere((element) => element != current));
  }

  static AnimatedIconBuilder<T>? _dualIconBuilder<T>(
      IconBuilder<T>? textBuilder, Size iconSize, List<T> values, double dif) {
    return (T t, double value, bool active) {
      bool left = t == values[0];
      return Row(
        children: [
          !left
              ? Spacer()
              : SizedBox(
                  width: 8.0 + dif,
                ),
          Opacity(
              opacity: 1 - value,
              child: textBuilder?.call(
                  values.firstWhere((element) => element != t),
                  iconSize,
                  !active)),
          left
              ? Spacer()
              : SizedBox(
                  width: 8.0 + dif,
                ),
        ],
      );
    };
  }

  static List<Positioned> Function(
          Size size, Size indicatorSize, double dif, double positionValue)
      buildBackgroundStack<T>(List<T> values, IconBuilder<T> iconBuilder) {
    return (Size size, Size indicatorSize, double dif, double positionValue) =>
        List.generate(values.length, (index) => index).map((i) {
          double position = i * (indicatorSize.width + dif);
          T current = values[i];
          Size localSize = Size(2 * dif + indicatorSize.width, size.height);
          return Positioned(
            left: position - dif,
            width: localSize.width,
            height: localSize.height,
            child: iconBuilder(current, localSize, false),
          );
        }).toList();
  }
}

class _AnimatedToggleSwitchState<T> extends State<AnimatedToggleSwitch<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late _AnimationInfo _animationInfo;
  late CurvedAnimation _animation;
  bool hovering = false;

  @override
  void initState() {
    super.initState();

    _animationInfo =
        _AnimationInfo(widget.values.indexOf(widget.current).toDouble());
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addListener(() {
            SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
              setState(() {});
            });
          })
          ..addStatusListener((status) {
            if (status != AnimationStatus.completed) return;
            _animationInfo = _animationInfo.ended();
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
  void didUpdateWidget(covariant AnimatedToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = widget.animationDuration;
    _animation.curve = widget.animationCurve;

    if (oldWidget.current != widget.current) {
      int index = widget.values.indexOf(widget.current);
      _animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    double dif = widget.dif;
    double innerWidth = widget.indicatorSize.width * widget.values.length +
        (widget.values.length - 1) * dif;
    double width = innerWidth + 2 * widget.borderWidth;

    Size indicatorSize = Size(
        widget.indicatorSize.width,
        widget.indicatorSize.height.isInfinite
            ? widget.height - 2 * widget.borderWidth
            : widget.indicatorSize.height);

    return LayoutBuilder(builder: (context, constraints) {
      if (widget.fittingMode == FittingMode.preventHorizontalOverlapping &&
          width > constraints.maxWidth) {
        double factor =
            (constraints.maxWidth - (2 * widget.borderWidth)) / innerWidth;
        dif *= factor;
        width = constraints.maxWidth;
        innerWidth = width - 2 * widget.borderWidth;
        indicatorSize = Size(
            indicatorSize.width.isInfinite
                ? innerWidth / widget.values.length
                : factor * indicatorSize.width,
            indicatorSize.height);
      }

      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double positionValue = _animationInfo.valueAt(_animation.value);
          double position = (indicatorSize.width + dif) * positionValue +
              indicatorSize.width / 2;

          double doubleFromPosition(double x) {
            return (x.clamp(indicatorSize.width / 2 + widget.borderWidth,
                        width - indicatorSize.width / 2 - widget.borderWidth) -
                    indicatorSize.width / 2 -
                    widget.borderWidth) /
                ((indicatorSize.width + dif));
          }

          int indexFromPosition(double x) {
            return doubleFromPosition(x).round();
          }

          T valueFromPosition(double x) {
            return widget.values[indexFromPosition(x)];
          }

          BorderRadiusGeometry borderRadius = widget.borderRadius ??
              BorderRadius.all(
                Radius.circular(widget.height / 2),
              );

          Color indicatorColor =
              widget.indicatorColor ?? theme.colorScheme.secondary;

          List<Widget> foregroundStack = <Widget>[
                Positioned(
                    top: (widget.height - indicatorSize.height) / 2 -
                        widget.borderWidth,
                    left: position - indicatorSize.width / 2,
                    child: widget.indicatorAnimationType == AnimationType.onSelected
                        ? TweenAnimationBuilder<Color?>(
                            child: widget.foregroundIndicatorIconBuilder
                                ?.call(positionValue, indicatorSize),
                            duration: widget.animationDuration,
                            tween: ColorTween(
                                begin: widget.indicatorColor,
                                end: widget.colorBuilder?.call(widget.current) ??
                                    indicatorColor),
                            builder: (c, color, child) => _indicatorBuilder(
                                indicatorSize, color!, borderRadius, child))
                        : _indicatorBuilder(
                            indicatorSize,
                            Color.lerp(
                                    widget.colorBuilder?.call(widget.values[positionValue.floor()]) ?? indicatorColor,
                                    widget.colorBuilder?.call(widget.values[positionValue.ceil()]) ?? indicatorColor,
                                    positionValue - positionValue.floor()) ??
                                indicatorColor,
                            borderRadius,
                            widget.foregroundIndicatorIconBuilder?.call(positionValue, indicatorSize))),
              ] +
              (widget.animatedIconBuilder != null
                  ? (widget._iconsInStack
                      ? _buildBackgroundStack(
                          Size(width, widget.height - 2 * widget.borderWidth),
                          indicatorSize,
                          dif,
                          positionValue)
                      : _buildBackgroundRow(indicatorSize, positionValue))
                  : []);

          bool Function(double) isPositionOverIndicator = (dx) =>
              position - max((indicatorSize.width + dif) / 2, 24.0) <= dx &&
              dx <= (position + max((indicatorSize.width + dif) / 2, 24.0));

          bool Function(double) isPositionExactlyOverIndicator = (dx) =>
              position - max(indicatorSize.width / 2, 24.0) <= dx &&
              dx <= (position + max(indicatorSize.width / 2, 24.0));

          return MouseRegion(
            cursor: _animationInfo.moveMode == MoveMode.dragged
                ? SystemMouseCursors.grabbing
                : (hovering
                    ? SystemMouseCursors.grab
                    : SystemMouseCursors.click),
            onHover: (event) {
              if (hovering ==
                  (hovering =
                      isPositionExactlyOverIndicator(event.localPosition.dx)))
                return;
              // TODO: Encapsulate for better efficiency
              setState(() {});
            },
            onExit: (event) => hovering = false,
            child: GestureDetector(
              onTapUp: (details) {
                widget.onTap?.call();
                T newValue = valueFromPosition(details.localPosition.dx);
                if (newValue == widget.current) return;
                widget.onChanged?.call(newValue);
              },
              onHorizontalDragStart: (details) {
                if (!isPositionOverIndicator(details.localPosition.dx)) return;
                _onDragged(doubleFromPosition(details.localPosition.dx));
              },
              onHorizontalDragUpdate: (details) {
                _onDragUpdate(doubleFromPosition(details.localPosition.dx));
              },
              onHorizontalDragEnd: (details) {
                _onDragEnd();
              },
              child: TweenAnimationBuilder<Color?>(
                child: Stack(
                    children: widget.foregroundIndicatorIconBuilder == null
                        ? foregroundStack
                        : foregroundStack.reversed.toList()),
                duration: widget.animationDuration,
                tween: ColorTween(
                  begin: widget.borderColorBuilder?.call(widget.current) ??
                      widget.borderColor ??
                      theme.colorScheme.secondary,
                  end: widget.borderColorBuilder?.call(widget.current) ??
                      widget.borderColor ??
                      theme.colorScheme.secondary,
                ),
                builder: (c, color, child) => Container(
                  width: width,
                  height: widget.height,
                  clipBehavior: Clip.hardEdge,
                  foregroundDecoration: BoxDecoration(
                    border:
                        Border.all(color: color!, width: widget.borderWidth),
                    borderRadius: borderRadius,
                  ),
                  decoration: BoxDecoration(
                    color: widget.innerColor ?? theme.scaffoldBackgroundColor,
                    border: Border.all(
                        width: widget.borderWidth, color: Colors.transparent),
                    borderRadius: borderRadius,
                    boxShadow: widget.boxShadow,
                  ),
                  child: child,
                ),
              ),
            ),
          );
        },
      );
    });
  }

  List<Positioned> _buildBackgroundStack(
      Size size, Size indicatorSize, double dif, double positionValue) {
    return List.generate(widget.values.length, (index) => index).map((i) {
      double position = i * (indicatorSize.width + dif);
      T current = widget.values[i];
      return Positioned(
        left: position - dif,
        width: 2 * dif + indicatorSize.width,
        height: widget.height - widget.borderWidth * 2,
        child: _animatedOpacityIcon(_animatedSizeIcon(current, positionValue),
            current == widget.current),
      );
    }).toList();
  }

  List<Widget> _buildBackgroundRow(Size indicatorSize, double positionValue) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.values
            .map(
              (e) => SizedBox(
                width: indicatorSize.width,
                height: widget.height - 2 * widget.borderWidth,
                child: _animatedOpacityIcon(
                    _animatedSizeIcon(e, positionValue), e == widget.current),
              ),
            )
            .toList(),
      ),
    ];
  }

  Widget _animatedSizeIcon(T e, double position) {
    switch (widget.iconAnimationType) {
      case AnimationType.onSelected:
        return TweenAnimationBuilder(
          curve: widget.iconAnimationCurve,
          duration: widget.iconAnimationDuration ?? widget.animationDuration,
          tween:
              Tween<double>(begin: 0.0, end: widget.current == e ? 1.0 : 0.0),
          builder: (c, value, child) {
            value = value as double;
            return widget.animatedIconBuilder!(
              e,
              value,
              e == widget.current,
            );
          },
        );
      case AnimationType.onHover:
        double value = 0.0;
        double localPosition = position - position.floorToDouble();
        if (widget.values[position.floor()] == e)
          value = 1 - localPosition;
        else if (widget.values[position.ceil()] == e) value = localPosition;

        return widget.animatedIconBuilder!(
          e,
          value,
          e == widget.current,
        );
    }
  }

  Widget _animatedOpacityIcon(Widget icon, bool active) {
    return widget.iconOpacity >= 1.0 && widget.selectedIconOpacity >= 1.0
        ? icon
        : AnimatedOpacity(
            opacity: active ? widget.selectedIconOpacity : widget.iconOpacity,
            duration: widget.animationDuration,
            child: icon,
          );
  }

  void _animateTo(int index) {
    if (index.toDouble() != _animationInfo.end &&
        _animationInfo.moveMode != MoveMode.dragged) {
      _animationInfo = _animationInfo.toEnd(index.toDouble(),
          current: _animationInfo.valueAt(_animation.value));
      _controller.forward(from: 0.0);
    }
  }

  void _onDragged(double indexPosition) {
    _controller.reset();
    _animationInfo = _animationInfo.dragged(indexPosition);
    setState(() {});
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
    _animationInfo = _animationInfo.none();
    T newValue = widget.values[index];
    if (widget.current != newValue) widget.onChanged?.call(newValue);
    _animateTo(index);
  }

  Widget _indicatorBuilder(Size size, Color color,
      BorderRadiusGeometry borderRadius, Widget? child) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: widget.foregroundBorder,
        boxShadow: widget.foregroundBoxShadow,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}

class _AnimationInfo {
  final double start;
  final double end;
  final MoveMode moveMode;

  _AnimationInfo(this.start, {this.moveMode = MoveMode.none}) : end = start;

  _AnimationInfo.animating(this.start, this.end)
      : moveMode = MoveMode.animating;

  _AnimationInfo toEnd(double end, {double? current}) =>
      _AnimationInfo.animating(current ?? start, end);

  _AnimationInfo none({double? current}) =>
      _AnimationInfo(current ?? start, moveMode: MoveMode.none);

  _AnimationInfo ended() => _AnimationInfo(end);

  _AnimationInfo dragged(double current) =>
      _AnimationInfo(current, moveMode: MoveMode.dragged);

  double valueAt(num position) => start + (end - start) * position;
}
