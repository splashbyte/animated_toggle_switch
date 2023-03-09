## 0.6.2 (2022-03-09)
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
