part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

typedef SimpleIconBuilder<T> = Widget Function(T value);

typedef RollingIconBuilder<T> = Widget Function(
  BuildContext context,
  RollingProperties<T> local,
  DetailedGlobalToggleProperties<T> global,
);

typedef SimpleRollingIconBuilder<T> = Widget Function(T value, bool foreground);

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

typedef StyleBuilder<T> = ToggleStyle Function(T value);

typedef CustomStyleBuilder<T> = ToggleStyle Function(
  BuildContext context,
  StyledToggleProperties<T> local,
  GlobalToggleProperties<T> global,
);

typedef SeparatorBuilder = Widget Function(int index);

/// Specifies when an value should be animated.
enum AnimationType {
  /// Starts an animation if an item is selected.
  onSelected,

  /// Starts an animation if an item is hovered by the indicator.
  onHover,
}

/// Super class of [AnimatedToggleSwitch] for holding assertions.
abstract class _AnimatedToggleSwitchParent<T> extends StatelessWidget {
  const _AnimatedToggleSwitchParent({
    super.key,
    required List<T> values,
    required StyleBuilder<T>? styleBuilder,
    required CustomStyleBuilder<T>? customStyleBuilder,
    required List<ToggleStyle>? styleList,
    required List<Widget>? iconList,
  })  : assert(
          (styleBuilder ?? customStyleBuilder) == null ||
              (styleBuilder ?? styleList) == null ||
              (customStyleBuilder ?? styleList) == null,
          'Only one parameter from styleBuilder, customStyleBuilder and styleList can be set.',
        ),
        assert(styleList == null || styleList.length == values.length,
            'styleList must be null or have the same length as values'),
        assert(iconList == null || iconList.length == values.length,
            'iconList must be null or have the same length as values');
}

/// A class with constructors for different switches.
/// The constructors have sensible default values for their parameters,
/// but can also be customized.
///
/// If you want to implement a completely custom switch,
/// you should use [CustomAnimatedToggleSwitch], which is used by
/// [AnimatedToggleSwitch] in the background.
class AnimatedToggleSwitch<T extends Object?>
    extends _AnimatedToggleSwitchParent<T> {
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

  /// List of the styles for all values.
  ///
  /// [styleList] must have the same length as [values].
  final List<ToggleStyle>? styleList;

  /// Duration of the motion animation.
  final Duration animationDuration;

  /// If null, [animationDuration] is taken.
  ///
  /// [iconAnimationDuration] defines the duration of the [Animation] built in [animatedIconBuilder].
  /// In some constructors this is the Duration of the size animation.
  final Duration? iconAnimationDuration;

  /// Curve of the motion animation.
  final Curve animationCurve;

  /// [iconAnimationCurve] defines the [Duration] of the [Animation] built in [animatedIconBuilder].
  /// In some constructors this is the [Curve] of the size animation.
  final Curve iconAnimationCurve;

  /// Size of the indicator.
  final Size indicatorSize;

  /// Callback for selecting a new value. The new [current] should be set here.
  final ChangeCallback<T>? onChanged;

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

  /// Space between adjacent icons.
  final double spacing;

  /// Total height of the widget.
  final double height;

  /// If null, the indicator is behind the icons. Otherwise an icon is in the indicator and is built using this function.
  final CustomIndicatorBuilder<T>? foregroundIndicatorIconBuilder;

  /// The [AnimationType] for the [animatedIconBuilder].
  final AnimationType iconAnimationType;

  /// The [AnimationType] for [styleBuilder].
  ///
  /// The [AnimationType] for [ToggleStyle.indicatorColor], [ToggleStyle.indicatorBorderRadius],
  /// [ToggleStyle.indicatorBorder] and [ToggleStyle.indicatorBoxShadow].
  /// is managed separately with [indicatorAnimationType].
  final AnimationType styleAnimationType;

  /// The [AnimationType] for the [ToggleStyle.indicatorColor].
  ///
  /// For the other style parameters, please use [styleAnimationType].
  final AnimationType indicatorAnimationType;

  /// Callback for tapping anywhere on the widget.
  final TapCallback<T>? onTap;

  final IconArrangement _iconArrangement;

  /// The [MouseCursor] settings for this switch.
  final ToggleCursors cursors;

  /// The [FittingMode] of the switch.
  ///
  /// Change this only if you don't want the switch to adjust when the constraints are too small.
  final FittingMode fittingMode;

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
  /// The available width is specified by [spacing].
  ///
  /// This builder is supported by [IconArrangement.row] only.
  final SeparatorBuilder? separatorBuilder;

  /// Builder for divider or other separators between the icons. Consider using [separatorBuilder] for a simpler builder function.
  ///
  /// The available width is specified by [spacing].
  ///
  /// This builder is supported by [IconArrangement.row] only.
  final CustomSeparatorBuilder<T>? customSeparatorBuilder;

  /// Indicates if the switch is active.
  ///
  /// Please use [inactiveOpacity] for changing the opacity in inactive state.
  ///
  /// For controlling the [AnimatedOpacity] you can use [inactiveOpacityCurve] and [inactiveOpacityDuration].
  final bool active;

  /// Opacity of the switch when [active] is set to [false].
  ///
  /// Please set this to [1.0] for deactivating.
  final double inactiveOpacity;

  /// [Curve] of the animation when getting inactive.
  ///
  /// For deactivating this animation please set [inactiveOpacity] to [1.0].
  final Curve inactiveOpacityCurve;

  /// [Duration] of the animation when getting inactive.
  ///
  /// For deactivating this animation please set [inactiveOpacity] to [1.0].
  final Duration inactiveOpacityDuration;

  /// Constructor of AnimatedToggleSwitch with all possible settings.
  ///
  /// Consider using [CustomAnimatedToggleSwitch] for maximum customizability.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  const AnimatedToggleSwitch.custom({
    super.key,
    required this.current,
    required this.values,
    this.animatedIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size(48.0, double.infinity),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.spacing = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.height = 50.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
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
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
  })  : _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: null,
        );

  /// Special version of [AnimatedToggleSwitch.custom].
  ///
  /// All size values ([indicatorSize], [spacing]) are relative to the specified height.
  /// (So an [indicatorSize.width] of [1.0] means equality of [height] - 2*[borderWidth] and the width of the indicator)
  ///
  /// Consider using [CustomAnimatedToggleSwitch] for maximum customizability.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  const AnimatedToggleSwitch.customByHeight({
    super.key,
    this.height = 50.0,
    required this.current,
    required this.values,
    this.animatedIconBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size(1.0, 1.0),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    double spacing = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
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
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
  })  : spacing = spacing * (height - 2 * borderWidth),
        indicatorSize = indicatorSize * (height - 2 * borderWidth),
        _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: null,
        );

  /// Provides an [AnimatedToggleSwitch] with the standard size animation of the icons.
  ///
  /// Maximum one argument of [iconBuilder], [customIconBuilder] and [iconList] must be provided.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  AnimatedToggleSwitch.size({
    super.key,
    required this.current,
    required this.values,
    SimpleIconBuilder<T>? iconBuilder,
    AnimatedIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size.fromWidth(48.0),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    double selectedIconScale = sqrt2,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    this.selectedIconOpacity = 1.0,
    this.spacing = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.height = 50.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
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
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
  })  : animatedIconBuilder = _iconSizeBuilder<T>(
            iconBuilder, customIconBuilder, iconList, selectedIconScale),
        _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: iconList,
        );

  /// Special version of [AnimatedToggleSwitch.size].
  ///
  /// All size values ([indicatorSize], [iconSize]) are relative to the specified height.
  /// (So an [indicatorSize.width] of [1.0] means equality of [height] - 2*[borderWidth] and the width of the indicator)
  ///
  /// Maximum one argument of [iconBuilder], [customIconBuilder] and [iconList] must be provided.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  AnimatedToggleSwitch.sizeByHeight({
    super.key,
    this.height = 50.0,
    required this.current,
    required this.values,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size.square(1.0),
    SimpleIconBuilder<T>? iconBuilder,
    AnimatedIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    double selectedIconScale = sqrt2,
    this.iconAnimationCurve = Curves.easeOutBack,
    this.iconAnimationDuration,
    this.iconOpacity = 0.5,
    double spacing = 0.0,
    this.foregroundIndicatorIconBuilder,
    this.selectedIconOpacity = 1.0,
    this.iconAnimationType = AnimationType.onSelected,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
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
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
  })  : indicatorSize = indicatorSize * (height - 2 * borderWidth),
        spacing = spacing * (height - 2 * borderWidth),
        animatedIconBuilder = _iconSizeBuilder<T>(
            iconBuilder, customIconBuilder, iconList, selectedIconScale),
        _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: iconList,
        );

  static AnimatedIconBuilder<T>? _iconSizeBuilder<T>(
      SimpleIconBuilder<T>? iconBuilder,
      AnimatedIconBuilder<T>? customIconBuilder,
      List<Widget>? iconList,
      double selectedIconScale) {
    assert(
      (iconBuilder ?? customIconBuilder) == null ||
          (iconBuilder ?? iconList) == null ||
          (customIconBuilder ?? iconList) == null,
      'Only one parameter from iconBuilder, customIconBuilder and iconList can be set.',
    );

    final AnimatedIconBuilder<T>? finalIconBuilder;
    if (iconBuilder != null) {
      finalIconBuilder = (c, l, g) => iconBuilder(l.value);
    } else if (iconList != null) {
      finalIconBuilder = (c, l, g) => iconList[l.index];
    } else {
      finalIconBuilder = customIconBuilder;
    }

    return finalIconBuilder == null
        ? null
        : (context, local, global) => Transform.scale(
              scale: 1.0 + local.animationValue * (selectedIconScale - 1.0),
              child: finalIconBuilder!(context, local, global),
            );
  }

  /// This constructor defines a rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  ///
  /// [indicatorIconScale] defines the scale of the indicator icon.
  /// This is useful in combination with [iconList] if you want the icons in the foreground to be slightly bigger.
  ///
  /// Maximum one argument of [iconBuilder], [customIconBuilder] and [iconList] must be provided.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  AnimatedToggleSwitch.rolling({
    super.key,
    required this.current,
    required this.values,
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size.fromWidth(46.0),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    this.iconOpacity = 0.5,
    this.spacing = 0.0,
    this.height = 50.0,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransition indicatorTransition =
        const ForegroundIndicatorTransition.rolling(),
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
    double indicatorIconScale = 1.0,
  })  : iconAnimationCurve = Curves.linear,
        iconAnimationDuration = Duration.zero,
        selectedIconOpacity = iconOpacity,
        iconAnimationType = AnimationType.onSelected,
        foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder<T>(
                values,
                iconBuilder,
                customIconBuilder,
                iconList,
                height,
                borderWidth,
                indicatorTransition,
                indicatorIconScale),
        animatedIconBuilder = _standardIconBuilder(
            iconBuilder, customIconBuilder, iconList, height, borderWidth),
        _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: iconList,
        );

  /// Special version of [AnimatedToggleSwitch.rolling].
  ///
  /// All size values ([spacing], [indicatorSize], [selectedIconSize]) are relative to the specified height.
  /// (So an [indicatorSize.width] of [1.0] means equality of [height] - 2*[borderWidth] and the width of the indicator)
  ///
  /// [indicatorIconScale] defines the scale of the indicator icon.
  /// This is useful in combination with [iconList] if you want the icons in the foreground to be slightly bigger.
  ///
  /// Maximum one argument of [iconBuilder], [customIconBuilder] and [iconList] must be provided.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  AnimatedToggleSwitch.rollingByHeight({
    super.key,
    this.height = 50.0,
    required this.current,
    required this.values,
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size.square(1.0),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    this.iconOpacity = 0.5,
    double spacing = 0.0,
    this.styleAnimationType = AnimationType.onSelected,
    this.indicatorAnimationType = AnimationType.onHover,
    this.onTap,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.iconsTappable = true,
    this.cursors = const ToggleCursors(),
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransition indicatorTransition =
        const ForegroundIndicatorTransition.rolling(),
    this.allowUnlistedValues = false,
    this.indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
    this.indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    this.indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    this.separatorBuilder,
    this.customSeparatorBuilder,
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
    double indicatorIconScale = 1.0,
  })  : iconAnimationCurve = Curves.linear,
        spacing = spacing * (height - 2 * borderWidth),
        iconAnimationDuration = Duration.zero,
        indicatorSize = indicatorSize * (height - 2 * borderWidth),
        selectedIconOpacity = iconOpacity,
        iconAnimationType = AnimationType.onSelected,
        foregroundIndicatorIconBuilder =
            _rollingForegroundIndicatorIconBuilder<T>(
                values,
                iconBuilder,
                customIconBuilder,
                iconList,
                height,
                borderWidth,
                indicatorTransition,
                indicatorIconScale),
        animatedIconBuilder = _standardIconBuilder(
            iconBuilder, customIconBuilder, iconList, height, borderWidth),
        _iconArrangement = IconArrangement.row,
        super(
          values: values,
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: iconList,
        );

  static CustomIndicatorBuilder<T> _rollingForegroundIndicatorIconBuilder<T>(
    List<T> values,
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    double height,
    double borderWidth,
    ForegroundIndicatorTransition transition,
    double iconScale,
  ) {
    assert(
      (iconBuilder ?? customIconBuilder) == null ||
          (iconBuilder ?? iconList) == null ||
          (customIconBuilder ?? iconList) == null,
      'Only one parameter from iconBuilder, customIconBuilder and iconList can be set.',
    );

    final RollingIconBuilder<T>? finalIconBuilder;
    if (iconBuilder != null) {
      finalIconBuilder = (c, l, g) => iconBuilder(l.value, l.foreground);
    } else if (iconList != null) {
      finalIconBuilder = (c, l, g) => iconList[l.index];
    } else {
      finalIconBuilder = customIconBuilder;
    }

    final iconSize = (height - 2 * borderWidth) * sqrt2 * 0.5;
    if (finalIconBuilder == null) return (context, global) => const SizedBox();
    return (context, global) {
      double distance = global.spacing + global.indicatorSize.width;
      double angleDistance = 0.0;
      //TODO: Replace with pattern matching after upgrade to Dart 3
      if (transition is _RollingForegroundIndicatorTransition) {
        angleDistance = distance /
            (transition.rollingRadius ?? (iconSize / 2)) *
            (global.textDirection == TextDirection.rtl ? -1.0 : 1.0);
      } else if (transition is _FadingForegroundIndicatorTransition) {
      } else {
        throw UnsupportedError(
            '${transition.runtimeType} is not supported by _rollingForegroundIndicatorIconBuilder');
      }

      final pos = global.position;
      int first = pos.floor();
      int second = pos.ceil();
      double transitionValue = pos - first;
      return Transform.scale(
        scale: iconScale,
        child: Stack(
          children: [
            Transform.rotate(
              key: ValueKey(first),
              angle: transitionValue * angleDistance,
              child: Opacity(
                  opacity: 1 - transitionValue,
                  child: finalIconBuilder!(
                      context,
                      RollingProperties(
                        foreground: true,
                        value: values[first],
                        index: first,
                      ),
                      global)),
            ),
            if (first != second)
              Transform.rotate(
                key: ValueKey(second),
                angle: (transitionValue - 1) * angleDistance,
                child: Opacity(
                    opacity: transitionValue,
                    child: finalIconBuilder(
                        context,
                        RollingProperties(
                          foreground: true,
                          value: values[second],
                          index: second,
                        ),
                        global)),
              ),
          ],
        ),
      );
    };
  }

  static AnimatedIconBuilder<T>? _standardIconBuilder<T>(
    SimpleRollingIconBuilder<T>? iconBuilder,
    RollingIconBuilder<T>? customIconBuilder,
    List<Widget>? iconList,
    double height,
    double borderWidth,
  ) {
    assert(
      (iconBuilder ?? customIconBuilder) == null ||
          (iconBuilder ?? iconList) == null ||
          (customIconBuilder ?? iconList) == null,
      'Only one parameter from iconBuilder, customIconBuilder and iconList can be set.',
    );

    final RollingIconBuilder<T>? finalIconBuilder;
    if (iconBuilder != null) {
      finalIconBuilder = (c, l, g) => iconBuilder(l.value, l.foreground);
    } else if (iconList != null) {
      finalIconBuilder = (c, l, g) => iconList[l.index];
    } else {
      finalIconBuilder = customIconBuilder;
    }

    return finalIconBuilder == null
        ? null
        : (context, local, global) => finalIconBuilder!(
              context,
              RollingProperties._fromLocal(
                  foreground: false, properties: local),
              global,
            );
  }

  /// Defining an rolling animation using the [foregroundIndicatorIconBuilder] of [AnimatedToggleSwitch].
  ///
  /// Maximum one builder of [iconBuilder] and [customIconBuilder] must be provided.
  ///
  /// Maximum one builder of [textBuilder] and [customTextBuilder] must be provided.
  ///
  /// Maximum one argument of [styleBuilder], [customStyleBuilder] and [styleList] must be provided.
  AnimatedToggleSwitch.dual({
    super.key,
    required this.current,
    required T first,
    required T second,
    SimpleIconBuilder<T>? iconBuilder,
    IconBuilder<T>? customIconBuilder,
    SimpleIconBuilder<T>? textBuilder,
    AnimatedIconBuilder<T>? customTextBuilder,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOutCirc,
    this.indicatorSize = const Size.fromWidth(46.0),
    this.onChanged,
    this.borderWidth = 2.0,
    this.style = const ToggleStyle(),
    this.styleBuilder,
    this.customStyleBuilder,
    this.styleList,
    this.spacing = 40.0,
    this.height = 50.0,
    this.iconAnimationDuration = const Duration(milliseconds: 500),
    this.iconAnimationCurve = Curves.easeInOut,
    this.styleAnimationType = AnimationType.onHover,
    this.indicatorAnimationType = AnimationType.onHover,
    this.fittingMode = FittingMode.preventHorizontalOverlapping,
    TapCallback<T>? onTap,
    this.minTouchTargetSize = 48.0,
    this.textDirection,
    this.cursors = const ToggleCursors(defaultCursor: SystemMouseCursors.click),
    EdgeInsetsGeometry textMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    Offset animationOffset = const Offset(20.0, 0),
    bool clipAnimation = true,
    bool opacityAnimation = true,
    this.loadingIconBuilder = _defaultLoadingIconBuilder,
    this.loading,
    this.loadingAnimationDuration,
    this.loadingAnimationCurve,
    ForegroundIndicatorTransition indicatorTransition =
        const ForegroundIndicatorTransition.rolling(),
    this.active = true,
    this.inactiveOpacity = 0.6,
    this.inactiveOpacityCurve = Curves.easeInOut,
    this.inactiveOpacityDuration = const Duration(milliseconds: 350),
  })  : assert(clipAnimation || opacityAnimation),
        iconOpacity = 1.0,
        selectedIconOpacity = 1.0,
        values = [first, second],
        iconAnimationType = AnimationType.onHover,
        iconsTappable = false,
        onTap = onTap ?? _dualOnTap(onChanged, [first, second], current),
        foregroundIndicatorIconBuilder = _rollingForegroundIndicatorIconBuilder(
            [first, second],
            iconBuilder == null ? null : (v, f) => iconBuilder(v),
            customIconBuilder,
            null,
            height,
            borderWidth,
            indicatorTransition,
            1.0),
        animatedIconBuilder = _dualIconBuilder(
          textBuilder,
          customTextBuilder,
          [first, second],
          textMargin,
          animationOffset,
          clipAnimation,
          opacityAnimation,
        ),
        _iconArrangement = IconArrangement.overlap,
        allowUnlistedValues = false,
        indicatorAppearingBuilder = _defaultIndicatorAppearingBuilder,
        indicatorAppearingDuration =
            _defaultIndicatorAppearingAnimationDuration,
        indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
        separatorBuilder = null,
        customSeparatorBuilder = null,
        super(
          values: [first, second],
          styleBuilder: styleBuilder,
          customStyleBuilder: customStyleBuilder,
          styleList: styleList,
          iconList: null,
        );

  static TapCallback<T> _dualOnTap<T>(
      ChangeCallback<T>? onChanged, List<T> values, T? current) {
    return (info) =>
        onChanged?.call(values.firstWhere((element) => element != current));
  }

  static AnimatedIconBuilder<T>? _dualIconBuilder<T>(
    SimpleIconBuilder<T>? textBuilder,
    AnimatedIconBuilder<T>? customTextBuilder,
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
                        (2 * (global.indicatorSize.width + global.spacing))),
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

  static Widget _defaultLoadingIconBuilder(BuildContext context,
          DetailedGlobalToggleProperties<dynamic> properties) =>
      const _MyLoading();

  ToggleStyle? _styleBuilder(BuildContext context,
      StyledToggleProperties<T> local, GlobalToggleProperties<T> global) {
    if (customStyleBuilder != null) {
      return customStyleBuilder!(context, local, global);
    }
    if (styleBuilder != null) {
      return styleBuilder!(local.value);
    }
    if (styleList != null) {
      if (local.index < 0) return null;
      return styleList![local.index];
    }
    return null;
  }

  // END OF CONSTRUCTOR SECTION

  BorderRadiusGeometry get _indicatorBorderRadiusDifference =>
      BorderRadius.circular(borderWidth);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    BorderRadiusGeometry defaultBorderRadius =
        BorderRadius.circular(height / 2);
    final style = ToggleStyle._(
      indicatorColor: theme.colorScheme.secondary,
      backgroundColor: theme.colorScheme.surface,
      backgroundGradient: null,
      borderColor: theme.colorScheme.secondary,
      borderRadius: defaultBorderRadius,
      indicatorBorderRadius: null,
      indicatorBorder: null,
      indicatorBoxShadow: null,
      boxShadow: null,
    )._merge(this.style, _indicatorBorderRadiusDifference);

    return CustomAnimatedToggleSwitch<T>(
        animationCurve: animationCurve,
        animationDuration: animationDuration,
        fittingMode: fittingMode,
        spacing: spacing,
        height: height,
        onTap: onTap,
        current: current,
        values: values,
        onChanged: onChanged,
        indicatorSize: indicatorSize,
        iconArrangement: _iconArrangement,
        iconsTappable: iconsTappable,
        cursors: cursors,
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
                : (context, local, global) => separatorBuilder!(local.index)),
        backgroundIndicatorBuilder: foregroundIndicatorIconBuilder != null
            ? null
            : (context, properties) =>
                _indicatorBuilder(context, properties, style),
        foregroundIndicatorBuilder: foregroundIndicatorIconBuilder == null
            ? null
            : (context, properties) =>
                _indicatorBuilder(context, properties, style),
        iconBuilder: (context, local, global) => _animatedOpacityIcon(
            _animatedSizeIcon(context, local, global), local.value == current),
        padding: EdgeInsets.all(borderWidth),
        active: active,
        wrapperBuilder: (context, global, child) {
          return AnimatedOpacity(
            opacity: global.active ? 1.0 : inactiveOpacity,
            duration: inactiveOpacityDuration,
            curve: inactiveOpacityCurve,
            child: _animationTypeBuilder<ToggleStyle>(
              context,
              styleAnimationType,
              (local) => style._merge(
                _styleBuilder(context, local, global),
                _indicatorBorderRadiusDifference,
              ),
              ToggleStyle._lerp,
              (style) => DecoratedBox(
                decoration: BoxDecoration(
                  color: style.backgroundColor,
                  gradient: style.backgroundGradient,
                  borderRadius: style.borderRadius,
                  boxShadow: style.boxShadow,
                ),
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: borderWidth <= 0.0
                        ? null
                        : Border.all(
                            color: style.borderColor!,
                            width: borderWidth,
                          ),
                    borderRadius: style.borderRadius,
                  ),
                  child: ClipRRect(
                    borderRadius: style.borderRadius!,
                    child: child,
                  ),
                ),
              ),
              global,
            ),
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
    switch (animationType) {
      case AnimationType.onSelected:
        V currentValue = valueProvider(
          StyledToggleProperties(
              value: current, index: values.indexOf(current)),
        );
        return TweenAnimationBuilder<V>(
          curve: animationCurve,
          duration: animationDuration,
          tween: _CustomTween(lerp, begin: currentValue, end: currentValue),
          builder: (context, value, _) => builder(value),
        );
      case AnimationType.onHover:
        return _AnimationTypeHoverBuilder(
          valueProvider: valueProvider,
          lerp: lerp,
          builder: builder,
          properties: properties,
          animationDuration: animationDuration,
          animationCurve: animationCurve,
          indicatorAppearingDuration: indicatorAppearingDuration,
          indicatorAppearingCurve: indicatorAppearingCurve,
        );
    }
  }

  Widget _indicatorBuilder(BuildContext context,
      DetailedGlobalToggleProperties<T> properties, ToggleStyle style) {
    final child = foregroundIndicatorIconBuilder?.call(context, properties);
    return _animationTypeBuilder<ToggleStyle>(
      context,
      indicatorAnimationType,
      (local) => style._merge(
        _styleBuilder(context, local, properties),
        _indicatorBorderRadiusDifference,
      ),
      ToggleStyle._lerp,
      (style) => _customIndicatorBuilder(context, style, child, properties),
      properties,
    );
  }

  Widget _animatedIcon(BuildContext context, AnimatedToggleProperties<T> local,
      DetailedGlobalToggleProperties<T> global) {
    return Opacity(
        opacity: 1.0 - global.loadingAnimationValue,
        child: Center(child: animatedIconBuilder!(context, local, global)));
  }

  Widget _animatedSizeIcon(BuildContext context, LocalToggleProperties<T> local,
      DetailedGlobalToggleProperties<T> global) {
    if (animatedIconBuilder == null) return const SizedBox();
    switch (iconAnimationType) {
      case AnimationType.onSelected:
        double currentTweenValue = local.value == global.current ? 1.0 : 0.0;
        return TweenAnimationBuilder<double>(
          curve: iconAnimationCurve,
          duration: iconAnimationDuration ?? animationDuration,
          tween:
              Tween<double>(begin: currentTweenValue, end: currentTweenValue),
          builder: (c, value, child) {
            return _animatedIcon(
              c,
              AnimatedToggleProperties._fromLocal(
                animationValue: value,
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
        if (values[global.position.floor()] == local.value) {
          animationValue = 1 - localPosition;
        } else if (values[global.position.ceil()] == local.value) {
          animationValue = localPosition;
        }
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

  Widget _customIndicatorBuilder(BuildContext context, ToggleStyle style,
      Widget? child, DetailedGlobalToggleProperties<T> global) {
    final loadingValue = global.loadingAnimationValue;
    return DecoratedBox(
        decoration: BoxDecoration(
          color: style.indicatorColor,
          borderRadius: style.indicatorBorderRadius,
          border: style.indicatorBorder,
          boxShadow: style.indicatorBoxShadow,
        ),
        child: Center(
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              if (loadingValue < 1.0)
                Opacity(
                    key: const ValueKey(0),
                    opacity: 1.0 - loadingValue,
                    child: child),
              if (loadingValue > 0.0)
                Opacity(
                    key: const ValueKey(1),
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
    final size = IconTheme.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme.of(context).platform.isApple
          ? CupertinoActivityIndicator(color: color)
          : SizedBox.square(
              dimension: size,
              child: CircularProgressIndicator(color: color, strokeWidth: 3.0),
            ),
    );
  }
}

extension _XTargetPlatform on TargetPlatform {
  bool get isApple =>
      this == TargetPlatform.iOS || this == TargetPlatform.macOS;
}

extension _XColorToGradient on Color {
  Gradient toGradient() => LinearGradient(colors: [this, this]);
}
