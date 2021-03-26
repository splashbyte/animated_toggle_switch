import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:animated_toggle_switch/src/utils.dart';
import 'package:flutter/material.dart';

typedef IconBuilder<T> = Widget Function(T t, Size size, bool active);

/// A version of IconBuilder for writing a own Animation on the change of the selected item.
typedef AnimatedIconBuilder<T> = Widget Function(T t, double value, bool active);

typedef ColorBuilder<T> = Color? Function(T t);

enum IndicatorType { circle, rectangle, roundedRectangle }

class AnimatedToggleSwitch<T> extends StatefulWidget {
  /// The currently selected value. It has to be set at [onChanged] or whenever for animating to this value.
  ///
  /// [current] has to be in [values] for working correctly.
  final T current;

  /// All possible values.
  final List<T> values;

  /// The IconBuilder for all icons with the specified size.
  final AnimatedIconBuilder<T>? animatedIconBuilder;

  //final TitleBuilder<T>? titleBuilder;

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

  /// Callback for selecting a new value. Here the new [current] should be set.
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

  /// Defines the Shape of the indicator.
  final IndicatorType indicatorType;

  /// Space between the "indicator rooms" of the adjacent icons.
  final double dif;

  /// Total height of the widget.
  final double height;

  /// If null, the indicator is behind the icons. Otherwise an icon is in the indicator and is built using this Function.
  final Widget Function(double value, Size size)? foregroundIndicatorIconBuilder;

  /// Standard Indicator Color
  final Color? indicatorColor;

  /// A builder for the Color of the Border. Can be used alternatively to [borderColor].
  final ColorBuilder<T>? borderColorBuilder;

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
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.borderColorBuilder,
  }) : super(key: key);

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
    iconSize = const Size(25.0, 25.0),
    selectedIconSize = const Size(45.0, 45.0),
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.borderColorBuilder,
  })  : animatedIconBuilder = _iconSizeBuilder<T>(iconBuilder, iconSize, selectedIconSize),
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
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.borderColorBuilder,
  })  : this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        animatedIconBuilder = _iconSizeBuilder<T>(iconBuilder, iconSize * (height + 2 * borderWidth), selectedIconSize * (height + 2 * borderWidth)),
        super(key: key);

  static AnimatedIconBuilder<T>? _iconSizeBuilder<T>(IconBuilder<T>? iconBuilder, Size iconSize, Size selectedIconSize) {
    return iconBuilder == null
        ? null
        : (T t, double value, bool active) => iconBuilder(
              t,
              Size(iconSize.width + (selectedIconSize.width - iconSize.width) * value, iconSize.height + (selectedIconSize.height - iconSize.height) * value),
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
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.borderColorBuilder,
  })  : this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
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
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.borderColorBuilder,
  })  : this.iconAnimationCurve = Curves.linear,
        this.iconAnimationDuration = Duration.zero,
        this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this.selectedIconOpacity = iconOpacity,
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder(values, dif, iconBuilder, Size.square(selectedIconRadius * 2 * (height - 2 * borderWidth))),
        animatedIconBuilder = _standardIconBuilder(
            iconBuilder, Size.square(iconRadius * 2 * (height - 2 * borderWidth)), Size.square(iconRadius * 2 * (height - 2 * borderWidth))),
        super(key: key);

  /// Defining an rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  AnimatedToggleSwitch.rolling({
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
    double iconRadius = 12.5,
    double selectedIconRadius = 12.5,
    this.iconOpacity = 0.5,
    this.indicatorType = IndicatorType.circle,
    this.borderRadius,
    this.dif = 0.0,
    this.height = 50.0,
    this.borderColorBuilder,
  })  : this.iconAnimationCurve = Curves.linear,
        this.iconAnimationDuration = Duration.zero,
        this.selectedIconOpacity = iconOpacity,
        this.foregroundIndicatorIconBuilder = _rollingForegroundIndicatorIconBuilder(values, dif, iconBuilder, Size.square(selectedIconRadius * 2)),
        this.animatedIconBuilder = _standardIconBuilder(iconBuilder, Size.square(iconRadius * 2), Size.square(iconRadius * 2)),
        super(key: key);

  @override
  _AnimatedToggleSwitchState createState() => _AnimatedToggleSwitchState<T>();

  static Widget Function(double value, Size size) _rollingForegroundIndicatorIconBuilder<T>(
      List<T> values, double dif, IconBuilder<T>? iconBuilder, Size iconSize) {
    return (value, indicatorSize) {
      double distance = dif + indicatorSize.width;
      double angleDistance = distance / iconSize.longestSide * 2;
      double transitionValue = value - value.floorToDouble();
      return Stack(
        children: [
          Transform.rotate(
            angle: transitionValue * angleDistance,
            child: Opacity(opacity: 1 - transitionValue, child: iconBuilder?.call(values[value.floor()], iconSize, true)),
          ),
          Transform.rotate(
            angle: (transitionValue - 1) * angleDistance,
            child: Opacity(opacity: transitionValue, child: iconBuilder?.call(values[value.ceil()], iconSize, true)),
          ),
        ],
      );
    };
  }

  static AnimatedIconBuilder<T>? _standardIconBuilder<T>(IconBuilder<T>? iconBuilder, Size iconSize, Size selectedIconSize) {
    return iconBuilder == null
        ? null
        : (T t, double value, bool active) => iconBuilder(
              t,
              active ? selectedIconSize : iconSize,
              active,
            );
  }
}

class _AnimatedToggleSwitchState<T> extends State<AnimatedToggleSwitch<T>> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late _AnimationInfo _animationInfo;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationInfo = _AnimationInfo(widget.values.indexOf(widget.current).toDouble());
    _controller = AnimationController(vsync: this, duration: widget.animationDuration)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status != AnimationStatus.completed) return;
        _animationInfo = _animationInfo.ended();
        _controller.duration = widget.animationDuration;
      });

    _animation = CurvedAnimation(parent: _controller, curve: widget.animationCurve);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    _animation = CurvedAnimation(parent: _controller, curve: widget.animationCurve);
    if (_controller.isCompleted) _controller.duration = widget.animationDuration;

    double dif = widget.dif;
    double innerWidth = widget.indicatorSize.width * widget.values.length + (widget.values.length - 1) * dif;
    double width = innerWidth + 2 * widget.borderWidth;

    int index = widget.values.indexOf(widget.current);

    _animateTo(index);
    double positionValue = _animationInfo.valueAt(_animation.value);
    double position = (widget.indicatorSize.width + dif) * positionValue + widget.indicatorSize.width / 2;

    double doubleFromPosition(double x) {
      return (x.clamp(widget.indicatorSize.width / 2 + widget.borderWidth, width - widget.indicatorSize.width / 2 - widget.borderWidth) -
              widget.indicatorSize.width / 2 -
              widget.borderWidth) /
          ((widget.indicatorSize.width + dif));
    }

    Size indicatorSize = Size(widget.indicatorSize.width, widget.indicatorSize.height.isInfinite ? widget.height : widget.indicatorSize.height);
    if (widget.indicatorType == IndicatorType.circle) indicatorSize = Size.square(indicatorSize.longestSide);

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

    List<Widget> foregroundStack = <Widget>[
      Positioned(
          top: (widget.height - indicatorSize.height) / 2 - widget.borderWidth,
          left: position - indicatorSize.width / 2,
          child: TweenAnimationBuilder(
              child: widget.foregroundIndicatorIconBuilder?.call(positionValue, indicatorSize),
              duration: widget.animationDuration,
              tween: ColorTween(begin: widget.indicatorColor, end: widget.colorBuilder?.call(widget.current) ?? widget.indicatorColor ?? theme.accentColor),
              builder: (c, color, child) => indicatorBuilder(indicatorSize, color as Color, borderRadius, child))),
      if (widget.animatedIconBuilder != null)
        Positioned(
          top: (widget.height - indicatorSize.height) / 2 - widget.borderWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.values
                .map(
                  (T e) => Container(
                    width: indicatorSize.width,
                    height: indicatorSize.height,
                    child: animatedOpacityIcon(animatedSizeIcon(e), e == widget.current),
                  ),
                )
                .toList(),
          ),
        ),
    ];

    return GestureDetector(
      onTapUp: (details) {
        T newValue = valueFromPosition(details.localPosition.dx);
        if (newValue == widget.current) return;
        widget.onChanged?.call(newValue);
      },
      onHorizontalDragStart: (details) {
        if (position - max(indicatorSize.width / 2 + dif, 24.0) > details.localPosition.dx ||
            details.localPosition.dx > (position + max(indicatorSize.width / 2 + dif, 24.0))) return;
        _onDragged(doubleFromPosition(details.localPosition.dx));
      },
      onHorizontalDragUpdate: (details) {
        _onDragUpdate(doubleFromPosition(details.localPosition.dx));
      },
      onHorizontalDragEnd: (details) {
        _onDragEnd();
      },
      child: TweenAnimationBuilder(
        child: Stack(children: widget.foregroundIndicatorIconBuilder == null ? foregroundStack : foregroundStack.reversed.toList()),
        duration: widget.animationDuration,
        tween: ColorTween(
            begin: widget.borderColorBuilder?.call(widget.current) ?? widget.borderColor ?? theme.accentColor,
            end: widget.borderColorBuilder?.call(widget.current) ?? widget.borderColor ?? theme.accentColor),
        builder: (c, color, child) => Container(
          width: width,
          height: widget.height,
          clipBehavior: Clip.hardEdge,
          foregroundDecoration: BoxDecoration(
            border: Border.all(color: color as Color, width: widget.borderWidth),
            borderRadius: borderRadius,
          ),
          decoration: BoxDecoration(
            color: widget.innerColor ?? theme.splashColor,
            border: Border.all(width: widget.borderWidth, color: Colors.transparent),
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget animatedSizeIcon(T e) {
    return TweenAnimationBuilder(
      curve: widget.iconAnimationCurve,
      duration: widget.iconAnimationDuration ?? widget.animationDuration,
      tween: Tween<double>(begin: 0.0, end: widget.current == e ? 1.0 : 0.0),
      builder: (c, value, child) {
        value = value as double;
        return widget.animatedIconBuilder!(
          e,
          value,
          e == widget.current,
        );
      },
    );
  }

  Widget animatedOpacityIcon(Widget icon, bool active) {
    return widget.iconOpacity >= 1.0 && widget.selectedIconOpacity >= 1.0
        ? icon
        : AnimatedOpacity(
            opacity: active ? widget.selectedIconOpacity : widget.iconOpacity,
            duration: widget.animationDuration,
            child: icon,
          );
  }

  void _animateTo(int index) {
    if (index.toDouble() != _animationInfo.end && _animationInfo.moveMode != MoveMode.dragged) {
      _animationInfo = _animationInfo.toEnd(index.toDouble(), current: _animationInfo.valueAt(_animation.value));
      _controller.forward(from: 0.0);
    }
  }

  void _onDragged(double indexPosition) {
    _controller.reset();
    _animationInfo = _animationInfo.dragged(indexPosition);
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

  Widget indicatorBuilder(Size size, Color color, BorderRadiusGeometry borderRadius, Widget? child) {
    BoxDecoration decoration;
    switch (widget.indicatorType) {
      case IndicatorType.circle:
        decoration = BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        );
        break;
      case IndicatorType.rectangle:
        decoration = BoxDecoration(
          color: color,
        );
        break;
      case IndicatorType.roundedRectangle:
        decoration = BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        );
        break;
    }
    return Container(
      width: size.width,
      height: size.height,
      decoration: decoration,
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

  _AnimationInfo.animating(this.start, this.end) : moveMode = MoveMode.animating;

  _AnimationInfo toEnd(double end, {double? current}) => _AnimationInfo.animating(current ?? start, end);

  _AnimationInfo none({double? current}) => _AnimationInfo(current ?? start, moveMode: MoveMode.none);

  _AnimationInfo ended() => _AnimationInfo(end);

  _AnimationInfo dragged(double current) => _AnimationInfo(current, moveMode: MoveMode.dragged);

  double valueAt(num position) => start + (end - start) * position;
}
