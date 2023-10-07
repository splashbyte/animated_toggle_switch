## 0.8.1

- adds `indicatorGradient` to `ToggleStyle` ([#44](https://github.com/splashbyte/animated_toggle_switch/issues/44))
- fixes problems with `backgroundGradient` and `backgroundColor` ([#46](https://github.com/splashbyte/animated_toggle_switch/issues/46))

## 0.8.0 (2023-09-02)

- adds tests for all `AnimatedToggleSwitch` constructors
- adds `separatorBuilder`, `customSeparatorBuilder`, `style` and `styleAnimationType` to `AnimatedToggleSwitch`
- adds `separatorBuilder` to `CustomAnimatedToggleSwitch`
- adds `active` to all constructors ([#30](https://github.com/splashbyte/animated_toggle_switch/issues/30))
- adds `styleBuilder` and `styleList` to `AnimatedToggleSwitch`
- adds `iconList` to `AnimatedToggleSwitch.size`, `AnimatedToggleSwitch.sizeByHeight`, `AnimatedToggleSwitch.rolling` and `AnimatedToggleSwitch.rollingByHeight`
- BREAKING: moves many parameters in `AnimatedToggleSwitch` to `style`:
  - `innerColor` (renamed to `backgroundColor`)
  - `innerGradient` (renamed to `backgroundGradient`)
  - `borderColor`
  - `indicatorColor`
  - `borderRadius`
  - `indicatorBorderColor`
  - `indicatorBorder`
  - `indicatorBorder`
  - `foregroundBoxShadow` (renamed to `indicatorBoxShadow`)
  - `boxShadow`
- BREAKING: moves all cursor parameters to `cursors`
- BREAKING: removes `borderColorBuilder` in favor of the new `styleBuilder`
- BREAKING: `indicatorAnimationType` handles `ToggleStyle.indicatorColor`, `ToggleStyle.indicatorBorderRadius`, `ToggleStyle.indicatorBorder` and `ToggleStyle.indicatorBoxShadow` now
- BREAKING: adds parameter to `onTap` ([#41](https://github.com/splashbyte/animated_toggle_switch/issues/41))
- BREAKING: changes default background color from `ThemeData.scaffoldBackgroundColor` to `ThemeData.colorScheme.surface`
- BREAKING: renames `dif` to `spacing` in all constructors
- BREAKING: replaces `transitionType` with `indicatorTransition` in `AnimatedToggleSwitch.rolling()`,
  `AnimatedToggleSwitch.rollingByHeight()` and `AnimatedToggleSwitch.dual()`
- BREAKING: removes `iconSize` and `selectedIconSize` in `AnimatedToggleSwitch` constructors
  - `rolling()`, `rollingByHeight()`, `dual()`: new parameter `indicatorIconScale` controls scaling now
  - `size()`, `sizeByHeight()`: new parameter `selectedIconScale` controls scaling now

## 0.7.0 (2023-06-19)

- adds possibility that no valid value is selected (by setting `allowUnlistedValues` to `true`)
- adds new parameters to almost all constructors: `allowUnlistedValues`, `indicatorAppearingBuilder`, `indicatorAppearingDuration`, `indicatorAppearingCurve`

## 0.6.2 (2023-03-09)

- adds screenshot to pubspec.yaml

## 0.6.1 (2022-12-22)

- adds examples for loading animation to README

## 0.6.0 (2022-12-22)

- fixes README
- fixes ([#28](https://github.com/splashbyte/animated_toggle_switch/issues/28))
- BREAKING: increases minimum SDK to 2.17
- BREAKING: renames `value` to `current` and `previousValue` to `previous` in `DetailedGlobalToggleProperties`
- BREAKING feature: Adds loading animation to all switches. You can disable it by setting `loading` to false.
- adds `innerGradient` to `AnimatedToggleSwitch`
- adds `transitionType` to `AnimatedToggleSwitch.rolling`, `AnimatedToggleSwitch.rollingByHeight` and `AnimatedToggleSwitch.dual`

## 0.5.2 (2022-04-22)

- minor performance improvement
- minor fixes
- improves code documentation
- adds `dragCursor` and `draggingCursor` to `CustomAnimatedToggleSwitch`
- adds `iconsTappable`, `defaultCursor`, `dragCursor` and `draggingCursor` to `AnimatedToggleSwitch`

## 0.5.1 (2022-04-21)

- fixes ([#20](https://github.com/splashbyte/animated_toggle_switch/issues/20))

## 0.5.0 (2022-04-20)

- minor performance improvement
- fixes problems with tight constraints
- BREAKING: changes default values of `animationOffset` and `clipAnimation` in `AnimatedToggleSwitch.dual`

## 0.4.0 (2022-04-03)

- minor fixes and performance improvements
- adds `indicatorBorderRadius` to `AnimatedToggleSwitch`
- adds `animationOffset`, `clipAnimation` and `opacityAnimation` to `AnimatedToggleSwitch.dual`
- BREAKING: sets default values of `animationOffset`, `clipAnimation` and `opacityAnimation` in `AnimatedToggleSwitch.dual`
- BREAKING: renames `foregroundBorder` to `indicatorBorder`

## 0.3.1 (2022-03-23)

- minor fixes

## 0.3.0 (2022-03-21)

- introduces `CustomAnimatedToggleSwitch` for maximum customizability
- most constructors of `AnimatedToggleSwitch` have a standard and a more customizable parameter for their builders now
- full support of `TextDirection.rtl`
- adds animation when dragging the switch
- adds `minTouchTargetSize`, `dragStartDuration`, `dragStartCurve` and `textDirection` to `AnimatedToggleSwitch`
- BREAKING: `TextDirection` is taken from `BuildContext` by default now!!!
- BREAKING: changes parameters and names of some builders
- BREAKING: renames `AnimatedToggleSwitch.byHeight` to `AnimatedToggleSwitch.customByHeight`
- BREAKING: adds default `textMargin` to `AnimatedToggleSwitch.dual`
- fixes ([#9](https://github.com/splashbyte/animated_toggle_switch/issues/9))

## 0.2.3 (2022-02-28)

- BREAKING: removes `indicatorType`
- BREAKING: changes default `innerColor`
- adds `BoxShadow` parameters

## 0.2.2 (2022-01-27)

- minor performance improvements

## 0.2.2 (2022-01-27)

- minor changes/fixes

## 0.2.1 (2021-10-03)

- migrates to Flutter 2.5
- minor changes/fixes

## 0.2.0 (2021-05-21)

- minor Changes
- fixes `FittingMode.preventHorizontalOverlapping`
- improves Web support

## 0.1.3 (2021-03-27)

- updates README.md

## 0.1.2 (2021-03-27)

- adds `AnimatedToggleSwitch.dual`
- adds some settings (`AnimationType`)

## 0.1.1 (2021-03-26)

- minor fix

## 0.1.0 (2021-03-26)

- initial release
