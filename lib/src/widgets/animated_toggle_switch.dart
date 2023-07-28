part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

typedef SizeIconBuilder<T> = Widget Function(
  BuildContext context,
  SizeProperties<T> local,
  DetailedGlobalToggleProperties<T> global,
);

typedef SimpleSizeIconBuilder<T> = Widget Function(T value, Size size);

typedef SimpleIconBuilder<T> = Widget Function(T value);

typedef RollingIconBuilder<T> = Widget Function(
  BuildContext context,
  RollingProperties<T> local,
  DetailedGlobalToggleProperties<T> global,
);

typedef SimpleRollingIconBuilder<T> = Widget Function(
    T value, Size size, bool foreground);

typedef LoadingIconBuilder<T> = Widget Function(
    BuildContext context, DetailedGlobalToggleProperties<T> global);

/// A version of IconBuilder for writing a own Animation on the change of the selected item.
typedef AnimatedIconBuilder<T> = Widget Function(
    BuildContext context,
    AnimatedToggleProperties<T> local,
    DetailedGlobalToggleProperties<T> global);

typedef IconBuilder<T> = Widget Function(
  BuildContext context,
  StyledToggleProperties<T> local,
  DetailedGlobalToggleProperties<T> global,
);

typedef StyleBuilder<T> = ToggleStyle? Function(T value);

typedef CustomStyleBuilder<T> = ToggleStyle? Function(
  BuildContext context,
  StyledToggleProperties<T> local,
  GlobalToggleProperties<T> global,
);

class ToggleStyle {
  /// Background color of the indicator.
  final Color? indicatorColor;

  /// Background color of the switch.
  final Color? backgroundColor;

  /// Gradient of the background. Overwrites [innerColor] if not [null].
  final Gradient? backgroundGradient;

  /// Border color of the switch.
  ///
  /// For deactivating please set this to [Colors.transparent].
  final Color? borderColor;

  /// [BorderRadius] of the switch.
  ///
  /// If set, this value overwrites [AnimatedToggleSwitch.borderRadius].
  final BorderRadiusGeometry? borderRadius;

  /// [BorderRadius] of the indicator.
  ///
  /// If set, this value overwrites [AnimatedToggleSwitch.indicatorBorderRadius].
  final BorderRadiusGeometry? indicatorBorderRadius;

  /// Default constructor for [ToggleStyle].
  ///
  /// If you want to adapt the [BorderRadius], you should use [SwitchColors.withBorder] instead.
  const ToggleStyle({
    this.indicatorColor,
    this.backgroundColor,
    this.backgroundGradient,
    this.borderColor,
    this.borderRadius,
    this.indicatorBorderRadius,
  });

  /// Private constructor for setting all possible parameters.
  ToggleStyle._({
    required this.indicatorColor,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.borderColor,
    required this.borderRadius,
    required this.indicatorBorderRadius,
  });

  ToggleStyle _merge(ToggleStyle? other) => other == null
      ? this
      : ToggleStyle._(
          indicatorColor: other.indicatorColor ?? indicatorColor,
          backgroundColor: other.backgroundColor ?? backgroundColor,
          backgroundGradient: other.backgroundGradient ??
              (other.backgroundColor == null ? null : backgroundGradient),
          borderColor: other.borderColor ?? borderColor,
          borderRadius: other.borderRadius ?? borderRadius,
          indicatorBorderRadius: other.indicatorBorderRadius ??
              indicatorBorderRadius ??
              other.borderRadius ??
              borderRadius,
        );

  static ToggleStyle _lerp(ToggleStyle style1, ToggleStyle colors2, double t) =>
      ToggleStyle._(
        indicatorColor:
            Color.lerp(style1.indicatorColor, colors2.indicatorColor, t),
        backgroundColor:
            Color.lerp(style1.backgroundColor, colors2.backgroundColor, t),
        backgroundGradient: Gradient.lerp(
          style1.backgroundGradient ?? style1.backgroundColor?.toGradient(),
          colors2.backgroundGradient ?? colors2.backgroundColor?.toGradient(),
          t,
        ),
        borderColor: Color.lerp(style1.borderColor, colors2.borderColor, t),
        borderRadius: BorderRadiusGeometry.lerp(
          style1.borderRadius,
          colors2.borderRadius,
          t,
        ),
        indicatorBorderRadius: BorderRadiusGeometry.lerp(
          style1.indicatorBorderRadius ?? style1.borderRadius,
          colors2.indicatorBorderRadius ?? colors2.borderRadius,
          t,
        ),
      );
}

/// Specifies when an value should be animated.
enum AnimationType {
  /// Starts an animation if an item is selected.
  onSelected,

  /// Starts an animation if an item is hovered by the indicator.
  onHover,
}

/// Different types of transitions for the foreground indicator.
///
/// Currently this enum is used only for deactivating the rolling animation in
/// some constructors.
enum ForegroundIndicatorTransitionType {
  /// Fades between the different icons.
  fading,

  /// Fades between the different icons and shows a rolling animation
  /// additionally.
  rolling,
}

/// A class with different constructors of different switches.
/// The constructors have sensible default values for their parameters,
/// but can also be customized.
///
/// If you want to implement a completely custom switch,
/// you should use [CustomAnimatedToggleSwitch], which is used by
/// [AnimatedToggleSwitch] in the background.
class AnimatedToggleSwitch<T> extends StatelessWidget {
  /// The currently selected value. It has to be set at [onChanged] or whenever for animating to this value.
  ///
  /// [current] has to be in [values] for working correctly if [allowUnlistedValues] is false.
  final T current;

  /// All possible values.
  final List<T> values;

  /// The IconBuilder for all icons with the specified size.
  final AnimatedIconBuilder<T>? animatedIconBuilder;

  /// The default style of this switch.
  ///
  /// This value can be overwritten by [styleBuilder].
  final ToggleStyle style;

  /// Builder for the style of the indicator depending on the current value.
  ///
  /// The returned style values overwrite the values of the [style] parameter if not [null].
  ///
  /// For a version of this builder with more parameters, please use [customStyleBuilder].
  final StyleBuilder<T>? styleBuilder;

  /// Custom builder for the style of the indicator.
  ///
  /// The returned style values overwrite the values of the [style] parameter if not [null].
  ///
  /// For a simpler version of this builder, please use [styleBuilder].
  final CustomStyleBuilder<T>? customStyleBuilder;

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

  /// Width of the border of the switch. For deactivating please set this to [0.0].
  final double borderWidth;

  /// Opacity for the icons.
  ///
  /// Please set [iconOpacity] and [selectedIconOpacity] to [1.0] for deactivating the AnimatedOpacity.
  final double iconOpacity;

  /// Opacity for the currently selected icon.
  ///
  /// Please set [iconOpacity] and [selectedIconOpacity] to [1.0] for deactivating the AnimatedOpacity.
  final double selectedIconOpacity;

  /// Space between the "indicator spaces" of the adjacent icons.
  final double dif;

  /// Total height of the widget.
  final double height;

  /// If null, the indicator is behind the icons. Otherwise an icon is in the indicator and is built using this function.
  final CustomIndicatorBuilder<T>? foregroundIndicatorIconBuilder;

  /// The [AnimationType] for the [animatedIconBuilder].
  final AnimationType iconAnimationType;

  /// The [AnimationType] for [styleBuilder].
  ///
  /// The [AnimationType] for [ToggleStyle.indicatorColor] and [ToggleStyle.indicatorBorderRadius]
  /// is managed separately with [indicatorAnimationType].
  final AnimationType styleAnimationType;

  /// The [AnimationType] for the [ToggleStyle.indicatorColor].
  ///
  /// For the other style parameters, please use [styleAnimationType].
  final AnimationType indicatorAnimationType;

  /// Callback for tapping anywhere on the widget.
  final Function()? onTap;

  final IconArrangement _iconArrangement;

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

  /// The [FittingMode] of the switch.
  ///
  /// Change this only if you don't want the switch to adjust when the constraints are too small.
  final FittingMode fittingMode;

  final BoxBorder? indicatorBorder;

  /// Shadow for the indicator [Container].
  final List<BoxShadow> indicatorBoxShadow;

  /// Shadow for the [Container] in the background.
  final List<BoxShadow> boxShadow;

  /// Indicates if [onChanged] is called when an icon is tapped.
  /// If [false] the user can change the value only by dragging the indicator.
  final bool iconsTappable;

  /// The minimum size of the indicator's hitbox.
  ///
  /// Helpful if the indicator is so small that you can hardly grip it.
  final double minTouchTargetSize;

  /// The direction in which the icons are arranged.
  ///
  /// If [null], the [TextDirection] is taken from the [BuildContext].
  final TextDirection? textDirection;

  /// A builder for the loading icon.
  final LoadingIconBuilder<T> loadingIconBuilder;

  /// Indicates if the switch is currently loading.
  ///
  /// If set to [null], the switch is loading automatically when a [Future] is
  /// returned by [onChanged] or [onTap].
  final bool? loading;

  /// Duration of the loading animation.
  ///
  /// Defaults to [animationDuration].
  final Duration? loadingAnimationDuration;

  /// Curve of the loading animation.
  ///
  /// Defaults to [animationCurve].
  final Curve? loadingAnimationCurve;

  /// Indicates that no error should be thrown if [current] is not contained in [values].
  ///
  /// If [allowUnlistedValues] is [true] and [values] does not contain [current],
  /// the indicator disappears with the specified [indicatorAppearingBuilder].
  final bool allowUnlistedValues;

  /// Custom builder for the appearing animation of the indicator.
  ///
  /// If you want to use this feature, you have to set [allowUnlistedValues] to [true].
  ///
  /// An indicator can appear if [current] was previously not contained in [values].
  final IndicatorAppearingBuilder indicatorAppearingBuilder;

  /// Duration of the appearing animation.
  final Duration indicatorAppearingDuration;

  /// Curve of the appearing animation.
  final Curve indicatorAppearingCurve;

  /// Builder for divider or other separators between the icons. Consider using [customSeparatorBuilder] for maximum customizability.
  ///
  /// The available width is specified by [dif].
  ///
  /// This builder is supported by [IconArrangement.row] only.
  final IndexedWidgetBuilder? separatorBuilder;

  /// Builder for divider or other separators between the icons. Consider using [separatorBuilder] for a simpler builder function.
  ///
  /// The available width is specified by [dif].
  ///
  /// This builder is supported by [IconArrangement.row] only.
  final CustomSeparatorBuilder<T>? customSeparatorBuilder;

  /// Constructor of AnimatedToggleSwitch with all possible settings.
  ///
  /// Consider using [CustomAnimatedToggleSwitch] for maximum customizability.
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
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  /// Provides an [AnimatedToggleSwitch] with the standard size animation of the icons.
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  AnimatedToggleSwitch.size({
    Key? key,
    required this.current,
    required this.values,
    SimpleSizeIconBuilder<T>? iconBuilder,
    SizeIconBuilder<T>? customIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    iconSize = const Size(23.0, 23.0),
    selectedIconSize = const Size(34.5, 34.5),
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.selectedIconOpacity = 1.0,
    this.dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.height = 50.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : animatedIconBuilder = _iconSizeBuilder<T>(
            iconBuilder, customIconBuilder, iconSize, selectedIconSize),
        this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  /// All size values ([indicatorWidth], [iconSize], [selectedIconSize]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  AnimatedToggleSwitch.sizeByHeight({
    Key? key,
    this.height = 50.0,
    required this.current,
    required this.values,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    SimpleSizeIconBuilder<T>? iconBuilder,
    SizeIconBuilder<T>? customIconBuilder,
    this.onChanged,
    this.borderWidth = 2,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    iconSize = const Size(0.5, 0.5),
    selectedIconSize = const Size(0.75, 0.75),
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this.dif = dif * (height - 2 * borderWidth),
        animatedIconBuilder = _iconSizeBuilder<T>(
            iconBuilder,
            customIconBuilder,
            iconSize * (height + 2 * borderWidth),
            selectedIconSize * (height + 2 * borderWidth)),
        this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  static AnimatedIconBuilder<T>? _iconSizeBuilder<T>(
      SimpleSizeIconBuilder<T>? iconBuilder,
      SizeIconBuilder<T>? customIconBuilder,
      Size iconSize,
      Size selectedIconSize) {
    assert(iconBuilder == null || customIconBuilder == null);
    if (customIconBuilder == null && iconBuilder != null)
      customIconBuilder = (c, l, g) => iconBuilder(l.value, l.iconSize);
    return customIconBuilder == null
        ? null
        : (context, local, global) => customIconBuilder!(
              context,
              SizeProperties.fromAnimated(
                  iconSize: Size(
                      iconSize.width +
                          (selectedIconSize.width - iconSize.width) *
                              local.animationValue,
                      iconSize.height +
                          (selectedIconSize.height - iconSize.height) *
                              local.animationValue),
                  properties: local),
              global,
            );
  }

  /// Another version of [AnimatedToggleSwitch.custom].
  ///
  /// All size values ([indicatorWidth]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  ///
  /// Consider using [CustomAnimatedToggleSwitch] for maximum customizability.
  const AnimatedToggleSwitch.customByHeight({
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
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    dif = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : this.dif = dif * (height - 2 * borderWidth),
        this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  /// Special version of [AnimatedToggleSwitch.customByHeight].
  ///
  /// It is not recommended to use [iconRadius] and [selectedIconRadius]
  /// but to use the [foreground] argument of [iconBuilder] to determine which size to use.
  /// If you still want to get the sizes in the builder, you have to use the [customIconBuilder] instead of [iconBuilder].
  ///
  /// All size values ([indicatorWidth], [indicatorSize], [selectedIconSize]) are relative to the specified height.
  /// (So an [indicatorWidth] of 1.0 means equality of [height] - 2*[borderWidth] and [indicatorWidth])
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  AnimatedToggleSwitch.rollingByHeight({
    Key? key,
    this.height = 50.0,
    required this.current,
    required this.values,
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    this.onChanged,
    this.borderWidth = 2,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    double iconRadius = 0.25,
    double selectedIconRadius = 0.35,
    this.iconOpacity = 0.5,
    double dif = 0.0,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransitionType transitionType =
        ForegroundIndicatorTransitionType.rolling,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : this.iconAnimationCurve = Curves.linear,
        this.dif = dif * (height - 2 * borderWidth),
        this.iconAnimationDuration = Duration.zero,
        this.indicatorSize = indicatorSize * (height - 2 * borderWidth),
        this.selectedIconOpacity = iconOpacity,
        this.iconAnimationType = AnimationType.onSelected,
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder<T>(
                values,
                iconBuilder,
                customIconBuilder,
                Size.square(
                    selectedIconRadius * 2 * (height - 2 * borderWidth)),
                transitionType),
        animatedIconBuilder = _standardIconBuilder(
            iconBuilder,
            customIconBuilder,
            Size.square(iconRadius * 2 * (height - 2 * borderWidth)),
            Size.square(iconRadius * 2 * (height - 2 * borderWidth))),
        this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  /// Defining a rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  ///
  /// It is not recommended to use [iconRadius] and [selectedIconRadius]
  /// but to use the [foreground] argument of [iconBuilder] to determine which size to use.
  /// If you still want to get the sizes in the builder, you have to use the [customIconBuilder] instead of [iconBuilder].
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  AnimatedToggleSwitch.rolling({
    Key? key,
    required this.current,
    required this.values,
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(46.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    double iconRadius = 11.5,
    double selectedIconRadius = 16.1,
    this.iconOpacity = 0.5,
    this.dif = 0.0,
    this.height = 50.0,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransitionType transitionType =
        ForegroundIndicatorTransitionType.rolling,
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
  })  : this.iconAnimationCurve = Curves.linear,
        this.iconAnimationDuration = Duration.zero,
        this.selectedIconOpacity = iconOpacity,
        this.iconAnimationType = AnimationType.onSelected,
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder<T>(
                values,
                iconBuilder,
                customIconBuilder,
                Size.square(selectedIconRadius * 2),
                transitionType),
        this.animatedIconBuilder = _standardIconBuilder(
            iconBuilder,
            customIconBuilder,
            Size.square(iconRadius * 2),
            Size.square(iconRadius * 2)),
        this._iconArrangement = IconArrangement.row,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  static CustomIndicatorBuilder<T> _rollingForegroundIndicatorIconBuilder<T>(
      List<T> values,
      SimpleRollingIconBuilder<T>? iconBuilder,
      RollingIconBuilder<T>? customIconBuilder,
      Size iconSize,
      ForegroundIndicatorTransitionType transitionType) {
    assert(iconBuilder == null || customIconBuilder == null);
    if (customIconBuilder == null && iconBuilder != null)
      customIconBuilder =
          (c, l, g) => iconBuilder(l.value, l.iconSize, l.foreground);
    return (context, global) {
      if (customIconBuilder == null) return SizedBox();
      double distance = global.dif + global.indicatorSize.width;
      double angleDistance =
          transitionType == ForegroundIndicatorTransitionType.rolling
              ? distance /
                  iconSize.longestSide *
                  2 *
                  (global.textDirection == TextDirection.rtl ? -1.0 : 1.0)
              : 0.0;
      final pos = global.position;
      int first = pos.floor();
      double transitionValue = pos - first;
      return Stack(
        children: [
          Transform.rotate(
            angle: transitionValue * angleDistance,
            child: Opacity(
                opacity: 1 - transitionValue,
                child: customIconBuilder(
                    context,
                    RollingProperties(
                      iconSize: iconSize,
                      foreground: true,
                      value: values[first],
                      index: first,
                    ),
                    global)),
          ),
          if (first != pos)
            Transform.rotate(
              angle: (transitionValue - 1) * angleDistance,
              child: Opacity(
                  opacity: transitionValue,
                  child: customIconBuilder(
                      context,
                      RollingProperties(
                        iconSize: iconSize,
                        foreground: true,
                        value: values[pos.ceil()],
                        index: first,
                      ),
                      global)),
            ),
        ],
      );
    };
  }

  static AnimatedIconBuilder<T>? _standardIconBuilder<T>(
      SimpleRollingIconBuilder<T>? iconBuilder,
      RollingIconBuilder<T>? customIconBuilder,
      Size iconSize,
      Size selectedIconSize) {
    assert(iconBuilder == null || customIconBuilder == null);
    if (customIconBuilder == null && iconBuilder != null)
      customIconBuilder =
          (c, l, g) => iconBuilder(l.value, l.iconSize, l.foreground);
    return customIconBuilder == null
        ? null
        : (t, local, global) => customIconBuilder!(
              t,
              RollingProperties._fromLocal(
                  iconSize: iconSize, foreground: false, properties: local),
              global,
            );
  }

  /// Defining an rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  /// Maximum one builder of [textBuilder] and [customTextBuilder] must be provided.
  AnimatedToggleSwitch.dual({
    Key? key,
    required this.current,
    required T first,
    required T second,
    SimpleIconBuilder<T>? iconBuilder,
    IconBuilder<T>? customIconBuilder,
    SimpleIconBuilder<T>? textBuilder,
    AnimatedIconBuilder<T>? customTextBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(46.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    double iconRadius = 16.1,
    this.dif = 40.0,
    this.height = 50.0,
    this.iconAnimationDuration = const Duration(milliseconds: 500),
    this.iconAnimationCurve = Curves.easeInOut,
    this.styleAnimationType = AnimationType.onHover,
    this.indicatorAnimationType = AnimationType.onHover,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    Function()? onTap,
    this.indicatorBorder,
    this.indicatorBoxShadow = const [],
    this.boxShadow = const [],
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.defaultCursor = SystemMouseCursors.click,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    EdgeInsetsGeometry textMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    Offset animationOffset = const Offset(20.0, 0),
    bool clipAnimation = true,
    bool opacityAnimation = true,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransitionType transitionType =
        ForegroundIndicatorTransitionType.rolling,
  })  : assert(clipAnimation || opacityAnimation),
        this.iconOpacity = 1.0,
        this.selectedIconOpacity = 1.0,
        this.values = [first, second],
        this.iconAnimationType = AnimationType.onHover,
        this.iconsTappable = false,
        this.onTap = onTap ?? _dualOnTap(onChanged, [first, second], current),
        this.foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder(
                [first, second],
                iconBuilder == null ? null : (v, s, f) => iconBuilder(v),
                customIconBuilder,
                Size.square(iconRadius * 2),
                transitionType),
        this.animatedIconBuilder = _dualIconBuilder(
          textBuilder,
          customTextBuilder,
          Size.square(iconRadius * 2),
          [first, second],
          textMargin,
          animationOffset,
          clipAnimation,
          opacityAnimation,
        ),
        this._iconArrangement = IconArrangement.overlap,
        this.allowUnlistedValues = false,
        this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
        this.indicatorAppearingDuration =
            _defaultIndicatorAppearingAnimationDuration,
        this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
        this.separatorBuilder = null,
        this.customSeparatorBuilder = null,
        assert(styleBuilder == null || customStyleBuilder == null),
        super(key: key);

  static Function() _dualOnTap<T>(
      Function(T)? onChanged, List<T> values, T? current) {
    return () =>
        onChanged?.call(values.firstWhere((element) => element != current));
  }

  static AnimatedIconBuilder<T>? _dualIconBuilder<T>(
    SimpleIconBuilder<T>? textBuilder,
    AnimatedIconBuilder<T>? customTextBuilder,
    Size iconSize,
    List<T> values,
    EdgeInsetsGeometry textMargin,
    Offset offset,
    bool clipAnimation,
    bool opacityAnimation,
  ) {
    assert(textBuilder == null || customTextBuilder == null);
    return (context, local, global) {
      bool start = local.index == 0;
      bool left = (global.textDirection == TextDirection.rtl) ^ start;
      int index = start ? 1 : 0;
      T value = values[index];
      AlignmentGeometry alignment = start
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd;

      return Align(
        alignment: alignment,
        child: _CustomClipRect(
          clipBehavior: clipAnimation ? Clip.hardEdge : Clip.none,
          child: Align(
            alignment: alignment,
            widthFactor: min(
                1,
                1 -
                    local.animationValue +
                    global.indicatorSize.width /
                        (2 * (global.indicatorSize.width + global.dif))),
            child: Padding(
              padding: textMargin,
              child: Transform.translate(
                offset: offset * local.animationValue * (left ? 1 : -1),
                child: Opacity(
                    opacity: opacityAnimation ? 1 - local.animationValue : 1,
                    child: textBuilder?.call(value) ??
                        customTextBuilder?.call(
                          context,
                          local.copyWith(
                            value: value,
                            index: index,
                          ),
                          global,
                        )),
              ),
            ),
          ),
        ),
      );
    };
  }

  static Widget _defaultLoadingIconBuilder(
          BuildContext context, dynamic properties) =>
      const _MyLoading();

  ToggleStyle? _styleBuilder(BuildContext context,
      StyledToggleProperties<T> local, GlobalToggleProperties<T> global) {
    if (customStyleBuilder != null) {
      return customStyleBuilder!(context, local, global);
    }
    if (styleBuilder != null) {
      return styleBuilder!(local.value);
    }
    return null;
  }

  // END OF CONSTRUCTOR SECTION

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    BorderRadiusGeometry defaultBorderRadius =
        BorderRadius.circular(height / 2);
    final colors = ToggleStyle._(
      indicatorColor: theme.colorScheme.secondary,
      backgroundColor: theme.scaffoldBackgroundColor,
      backgroundGradient: null,
      borderColor: theme.colorScheme.secondary,
      borderRadius: defaultBorderRadius,
      indicatorBorderRadius: defaultBorderRadius,
    )._merge(this.style);

    return CustomAnimatedToggleSwitch<T>(
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        fittingMode: fittingMode,
        dif: dif,
        height: height,
        onTap: onTap,
        current: current,
        values: values,
        onChanged: onChanged,
        indicatorSize: indicatorSize,
        iconArrangement: _iconArrangement,
        iconsTappable: iconsTappable,
        defaultCursor: defaultCursor,
        dragCursor: dragCursor,
        draggingCursor: draggingCursor,
        loadingCursor: loadingCursor,
        minTouchTargetSize: minTouchTargetSize,
        textDirection: textDirection,
        loading: loading,
        loadingAnimationCurve: loadingAnimationCurve,
        loadingAnimationDuration: loadingAnimationDuration,
        allowUnlistedValues: allowUnlistedValues,
        indicatorAppearingBuilder: indicatorAppearingBuilder,
        indicatorAppearingDuration: indicatorAppearingDuration,
        indicatorAppearingCurve: indicatorAppearingCurve,
        separatorBuilder: customSeparatorBuilder ??
            (separatorBuilder == null
                ? null
                : (context, local, global) =>
                    separatorBuilder!(context, local.index)),
        backgroundIndicatorBuilder: foregroundIndicatorIconBuilder != null
            ? null
            : (context, properties) =>
                _indicatorBuilder(context, properties, colors),
        foregroundIndicatorBuilder: foregroundIndicatorIconBuilder == null
            ? null
            : (context, properties) =>
                _indicatorBuilder(context, properties, colors),
        iconBuilder: (context, local, global) => _animatedOpacityIcon(
            _animatedSizeIcon(context, local, global), local.value == current),
        padding: EdgeInsets.all(borderWidth),
        wrapperBuilder: (context, global, child) {
          //TODO: extract this method to separate widget
          return _animationTypeBuilder<ToggleStyle>(
            context,
            styleAnimationType,
            (local) => colors._merge(_styleBuilder(context, local, global)),
            ToggleStyle._lerp,
            (colors) => DecoratedBox(
              decoration: BoxDecoration(
                color: colors.backgroundColor,
                gradient: colors.backgroundGradient,
                borderRadius: colors.borderRadius,
                boxShadow: boxShadow,
              ),
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  border: borderWidth <= 0.0
                      ? null
                      : Border.all(
                          color: colors.borderColor!,
                          width: borderWidth,
                        ),
                  borderRadius: colors.borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: colors.borderRadius,
                  child: child,
                ),
              ),
            ),
            global,
          );
        });
  }

  Widget _animationTypeBuilder<V>(
    BuildContext context,
    AnimationType animationType,
    V Function(StyledToggleProperties<T> local) valueProvider,
    V Function(V value1, V value2, double t) lerp,
    Widget Function(V value) builder,
    GlobalToggleProperties<T> properties,
  ) {
    double pos = properties.position;
    switch (animationType) {
      case AnimationType.onSelected:
        V currentValue = valueProvider(
          StyledToggleProperties(
              value: current, index: values.indexOf(current)),
        );
        return TweenAnimationBuilder<V>(
            duration: animationDuration,
            tween: _CustomTween(lerp, begin: currentValue, end: currentValue),
            builder: (context, v, _) => builder(v));
      case AnimationType.onHover:
        final index1 = pos.floor();
        final index2 = pos.ceil();
        return builder(lerp(
          valueProvider(
              StyledToggleProperties(value: values[index1], index: index1)),
          valueProvider(
              StyledToggleProperties(value: values[index2], index: index2)),
          pos - pos.floor(),
        ));
    }
  }

  Widget _indicatorBuilder(BuildContext context,
      DetailedGlobalToggleProperties<T> properties, ToggleStyle colors) {
    final child = foregroundIndicatorIconBuilder?.call(context, properties);
    return _animationTypeBuilder<ToggleStyle>(
      context,
      indicatorAnimationType,
      (local) => colors._merge(_styleBuilder(context, local, properties)),
      ToggleStyle._lerp,
      (colors) => _customIndicatorBuilder(
        context,
        colors.indicatorColor!,
        colors.indicatorBorderRadius!,
        child,
        properties,
      ),
      properties,
    );
  }

  Widget _animatedIcon(BuildContext context, AnimatedToggleProperties<T> local,
      DetailedGlobalToggleProperties<T> global) {
    return Opacity(
        opacity: 1.0 - global.loadingAnimationValue,
        child: animatedIconBuilder!(context, local, global));
  }

  Widget _animatedSizeIcon(BuildContext context, LocalToggleProperties<T> local,
      DetailedGlobalToggleProperties<T> global) {
    if (animatedIconBuilder == null) return const SizedBox();
    switch (iconAnimationType) {
      case AnimationType.onSelected:
        double currentTweenValue = local.value == global.current ? 1.0 : 0.0;
        return TweenAnimationBuilder(
          curve: iconAnimationCurve,
          duration: iconAnimationDuration ?? animationDuration,
          tween:
              Tween<double>(begin: currentTweenValue, end: currentTweenValue),
          builder: (c, value, child) {
            return _animatedIcon(
              c,
              AnimatedToggleProperties._fromLocal(
                animationValue: value as double,
                properties: local,
              ),
              global,
            );
          },
        );
      case AnimationType.onHover:
        double animationValue = 0.0;
        double localPosition =
            global.position - global.position.floorToDouble();
        if (values[global.position.floor()] == local.value)
          animationValue = 1 - localPosition;
        else if (values[global.position.ceil()] == local.value)
          animationValue = localPosition;
        return _animatedIcon(
          context,
          AnimatedToggleProperties._fromLocal(
            animationValue: animationValue,
            properties: local,
          ),
          global,
        );
    }
  }

  Widget _animatedOpacityIcon(Widget icon, bool active) {
    return iconOpacity >= 1.0 && selectedIconOpacity >= 1.0
        ? icon
        : AnimatedOpacity(
            opacity: active ? selectedIconOpacity : iconOpacity,
            duration: animationDuration,
            child: icon,
          );
  }

  Widget _customIndicatorBuilder(
      BuildContext context,
      Color color,
      BorderRadiusGeometry borderRadius,
      Widget? child,
      DetailedGlobalToggleProperties<T> global) {
    final loadingValue = global.loadingAnimationValue;
    return DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: indicatorBorder,
          boxShadow: indicatorBoxShadow,
        ),
        child: Center(
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              if (loadingValue < 1.0)
                Opacity(
                    key: ValueKey(0),
                    opacity: 1.0 - loadingValue,
                    child: child),
              if (loadingValue > 0.0)
                Opacity(
                    key: ValueKey(1),
                    opacity: loadingValue,
                    child: loadingIconBuilder(context, global)),
            ],
          ),
        ));
  }
}

class _CustomClipRect extends StatefulWidget {
  final Clip clipBehavior;
  final Widget child;

  const _CustomClipRect({
    Key? key,
    this.clipBehavior = Clip.hardEdge,
    required this.child,
  }) : super(key: key);

  @override
  _CustomClipRectState createState() => _CustomClipRectState();
}

class _CustomClipRectState extends State<_CustomClipRect> {
  final _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget child = _WidgetWrapper(key: _childKey, child: widget.child);
    if (widget.clipBehavior == Clip.none) return child;
    return ClipRect(
      clipBehavior: widget.clipBehavior,
      child: child,
    );
  }
}

class _WidgetWrapper extends StatelessWidget {
  final Widget child;

  const _WidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _MyLoading extends StatelessWidget {
  const _MyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).iconTheme.color;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Theme.of(context).platform.isApple
            ? CupertinoActivityIndicator(color: color)
            : CircularProgressIndicator(color: color));
  }
}

class _CustomTween<V> extends Tween<V> {
  final V Function(V value1, V value2, double t) lerpFunction;

  _CustomTween(this.lerpFunction, {super.begin, super.end});

  @override
  V lerp(double t) => lerpFunction(begin!, end!, t);
}

extension _XTargetPlatform on TargetPlatform {
  bool get isApple =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

extension _XColorToGradient on Color {
  Gradient toGradient() => LinearGradient(colors: [this, this]);
}
