## 0.8.0-beta.7

- updates README

## 0.8.0-beta.6 (2023-08-22)

- BREAKING: adds parameter to `onTap` ([#41](https://github.com/splashbyte/animated_toggle_switch/issues/41))

## 0.8.0-beta.5 (2023-08-18)

- fixes `AnimationType.onHover`

## 0.8.0-beta.4 (2023-08-18)

- BREAKING: removes `IconTheme` for controlling default size of `Icon`s
- BREAKING: changes default background color from `ThemeData.scaffoldBackgroundColor` to `ThemeData.colorScheme.surface`
- BREAKING: renames `dif` to `spacing` in all constructors

## 0.8.0-beta.3 (2023-08-11)

- BREAKING: replaces `transitionType` with `indicatorTransition` in `AnimatedToggleSwitch.rolling()`,
  `AnimatedToggleSwitch.rollingByHeight()` and `AnimatedToggleSwitch.dual()`
- BREAKING: replaces `iconSize` and `selectedIconSize` in `AnimatedToggleSwitch` constructors
  - `rolling()`, `rollingByHeight()`, `dual()`: now uses IconTheme for controlling default size of `Icon`s
  - `size()`, `sizeByHeight()`: new parameter `selectedIconScale` controls scaling

## 0.8.0-beta.2 (2023-08-01)

- minor fixes
- updates README

## 0.8.0-beta.1 (2023-07-31)

- adds `active` to all constructors
- closes [#30](https://github.com/splashbyte/animated_toggle_switch/issues/30)
- minor improvements
- BREAKING: changes `separatorBuilder` parameters
- BREAKING: moves all cursor parameters to `cursors`

## 0.8.0-beta.0 (2023-07-29)

- adds tests for all `AnimatedToggleSwitch` constructors
- adds `separatorBuilder`, `customSeparatorBuilder`, `style` and `styleAnimationType` to `AnimatedToggleSwitch`
- adds `separatorBuilder` to `CustomAnimatedToggleSwitch`
- fixes initial loading
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
- BREAKING: merges `borderColorBuilder` with `styleBuilder`
- BREAKING: `indicatorAnimationType` handles `ToggleStyle.indicatorColor`, `ToggleStyle.indicatorBorderRadius`, `ToggleStyle.indicatorBorder` and `ToggleStyle.indicatorBoxShadow` now

## 0.7.0 (2023-06-19)

- adds possibility that no valid value is selected (by setting `allowUnlistedValues` to `true`)
- adds new parameters to almost all constructors: `allowUnlistedValues`, `indicatorAppearingBuilder`, `indicatorAppearingDuration`, `indicatorAppearingCurve`

## 0.6.2 (2023-03-09)

- adds screenshot to pubspec.yaml

## 0.6.1 (2022-12-22)

- adds examples for loading animation to README

## 0.6.0 (2022-12-22)

- fixes README
- fixes #28
- BREAKING: Increases minimum SDK to 2.17
- BREAKING: Renames `value` to `current` and `previousValue` to `previous` in `DetailedGlobalToggleProperties`
- BREAKING Feature: Adds loading animation to all switches. You can disable it by setting `loading` to false.
- Adds `innerGradient` to `AnimatedToggleSwitch`
- Adds `transitionType` to `AnimatedToggleSwitch.rolling`, `AnimatedToggleSwitch.rollingByHeight` and `AnimatedToggleSwitch.dual`

## 0.5.2 (2022-04-22)

- Minor performance improvement
- Minor fixes
- Improves code documentation
- Adds `dragCursor` and `draggingCursor` to `CustomAnimatedToggleSwitch`
- Adds `iconsTappable`, `defaultCursor`, `dragCursor` and `draggingCursor` to `AnimatedToggleSwitch`

## 0.5.1 (2022-04-21)

- Fixes #20

## 0.5.0 (2022-04-20)

- Minor performance improvement
- Fixes problems with tight constraints
- BREAKING: Changes default values of `animationOffset` and `clipAnimation` in `AnimatedToggleSwitch.dual`

## 0.4.0 (2022-04-03)

- Minor fixes and performance improvements
- Adds `indicatorBorderRadius` to `AnimatedToggleSwitch`
- Adds `animationOffset`, `clipAnimation` and `opacityAnimation` to `AnimatedToggleSwitch.dual`
- BREAKING: Sets default values of `animationOffset`, `clipAnimation` and `opacityAnimation` in `AnimatedToggleSwitch.dual`
- BREAKING: Renames `foregroundBorder` to `indicatorBorder`

## 0.3.1 (2022-03-23)

- Minor fixes

## 0.3.0 (2022-03-21)

- Introduces `CustomAnimatedToggleSwitch` for maximum customizability
- Most constructors of `AnimatedToggleSwitch` have a standard and a more customizable parameter for their builders now
- Full support of `TextDirection.rtl`
- Adds animation when dragging the switch
- Adds `minTouchTargetSize`, `dragStartDuration`, `dragStartCurve` and `textDirection` to `AnimatedToggleSwitch`
- BREAKING: `TextDirection` is taken from `BuildContext` by default now!!!
- BREAKING: Changes parameters and names of some builders
- BREAKING: Renames `AnimatedToggleSwitch.byHeight` to `AnimatedToggleSwitch.customByHeight`
- BREAKING: Adds default `textMargin` to `AnimatedToggleSwitch.dual`
- Fixes #9

## 0.2.3 (2022-02-28)

- BREAKING: Removes `indicatorType`
- BREAKING: Changes default `innerColor`
- Adds `BoxShadow` parameters

## 0.2.2 (2022-01-27)

- Minor performance improvements

## 0.2.2 (2022-01-27)

- Minor changes/fixes

## 0.2.1 (2021-10-03)

- Migrates to Flutter 2.5
- Minor changes/fixes

## 0.2.0 (2021-05-21)

- Minor Changes
- Fixes `FittingMode.preventHorizontalOverlapping`
- Improves Web support

## 0.1.3 (2021-03-27)

- Updates README.md

## 0.1.2 (2021-03-27)

- Adds `AnimatedToggleSwitch.dual`
- Adds some settings (`AnimationType`)

## 0.1.1 (2021-03-26)

- Minor fix

## 0.1.0 (2021-03-26)

- Initial release
