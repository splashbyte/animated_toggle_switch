import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'keys.dart';

const defaultValues = [0, 1, 2, 3];

class TestWrapper extends StatelessWidget {
  final Widget child;
  final TextDirection textDirection;
  final TargetPlatform platform;

  const TestWrapper({
    Key? key,
    required this.child,
    this.textDirection = TextDirection.ltr,
    this.platform = TargetPlatform.android,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(platform: platform),
      child: Directionality(
        textDirection: textDirection,
        child: Center(child: child),
      ),
    );
  }
}

void checkValidSwitchIconBuilderState<T>(
    T current, ConstructorType type, List<T> values) {
  for (var value in values) {
    final iconFinder = find.byKey(iconKey(value));
    final iconForegroundFinder = find.byKey(iconKey(value, foreground: true));
    expect(iconFinder, findsOneWidget);
    expect(iconForegroundFinder,
        current == value && type.isRolling ? findsOneWidget : findsNothing);
  }
}

List<Widget> iconList<T>(List<T> values) =>
    values.map((value) => iconBuilder(value, false)).toList();

Widget iconBuilder<T>(T value, bool foreground) => SizedBox.expand(
      key: iconKey(value, foreground: foreground),
      child: const ColoredBox(color: Colors.black),
    );

Key iconKey<T>(T value, {bool foreground = false}) =>
    IconKey(value, foreground: foreground);

Widget separatorBuilder<T>(int index) =>
    SizedBox.expand(key: separatorKey(index));

Key separatorKey(int index) => SeparatorKey(index);

final loadingIconKey = GlobalKey();

Widget _loadingIconBuilder<T>(
        BuildContext context, GlobalToggleProperties<T> global) =>
    SizedBox(key: loadingIconKey);

typedef TestIconBuilder<T> = Widget Function(T value, bool foreground);

typedef SwitchBuilder<T> = AnimatedToggleSwitch<T> Function({
  required T current,
  required List<T> values,
  TestIconBuilder<T>? iconBuilder,
  List<Widget>? iconList,
  TextDirection? textDirection,
  ChangeCallback<T>? onChanged,
  TapCallback? onTap,
  bool? loading,
  bool allowUnlistedValues,
  ToggleStyle? style,
  StyleBuilder<T>? styleBuilder,
  CustomStyleBuilder<T>? customStyleBuilder,
  List<ToggleStyle>? styleList,
  bool? iconsTappable,
  double? spacing,
  SeparatorBuilder? separatorBuilder,
  FittingMode? fittingMode,
  Size? indicatorSize,
});

typedef SimpleSwitchBuilder<T> = AnimatedToggleSwitch<T> Function({
  required T current,
  TestIconBuilder<T>? iconBuilder,
  List<Widget>? iconList,
  TextDirection? textDirection,
  ChangeCallback<T>? onChanged,
  TapCallback? onTap,
  bool? loading,
  bool allowUnlistedValues,
  ToggleStyle? style,
  StyleBuilder<T>? styleBuilder,
  CustomStyleBuilder<T>? customStyleBuilder,
  List<ToggleStyle>? styleList,
  bool? iconsTappable,
  double? spacing,
  SeparatorBuilder? separatorBuilder,
  FittingMode? fittingMode,
  Size? indicatorSize,
});

/// Tests all AnimatedToggleSwitch constructors
void defaultTestAllSwitches(
  String description,
  FutureOr<void> Function(
          WidgetTester tester,
          SimpleSwitchBuilder<int> buildSwitch,
          ConstructorType type,
          List<int> values)
      test, {
  bool testDual = true,
  bool testCustom = true,
  bool testSize = true,
}) {
  testAllSwitches<int>(
    description,
    (tester, buildSwitch, type) => test(
      tester,
      ({
        required int current,
        TestIconBuilder<int>? iconBuilder,
        List<Widget>? iconList,
        TextDirection? textDirection,
        ChangeCallback<int>? onChanged,
        TapCallback? onTap,
        bool? loading,
        bool allowUnlistedValues = false,
        ToggleStyle? style,
        StyleBuilder<int>? styleBuilder,
        CustomStyleBuilder<int>? customStyleBuilder,
        List<ToggleStyle>? styleList,
        bool? iconsTappable,
        double? spacing,
        SeparatorBuilder? separatorBuilder,
        FittingMode? fittingMode,
        Size? indicatorSize,
      }) =>
          buildSwitch(
        current: current,
        values: defaultValues,
        iconBuilder: iconBuilder,
        iconList: iconList,
        textDirection: textDirection,
        onChanged: onChanged,
        onTap: onTap,
        loading: loading,
        allowUnlistedValues: allowUnlistedValues,
        style: style,
        styleBuilder: styleBuilder,
        customStyleBuilder: customStyleBuilder,
        styleList: styleList,
        iconsTappable: iconsTappable,
        spacing: spacing,
        separatorBuilder: separatorBuilder,
        fittingMode: fittingMode,
        indicatorSize: indicatorSize,
      ),
      type,
      defaultValues,
    ),
    testCustom: testCustom,
    testSize: testSize,
  );
  if (testDual) {
    final values = defaultValues.sublist(0, 2);
    testWidgets(
      '$description (AnimatedToggleSwitch.dual)',
      (tester) async => await test(
        tester,
        ({
          required int current,
          TestIconBuilder<int>? iconBuilder,
          List<Widget>? iconList,
          TextDirection? textDirection,
          ChangeCallback<int>? onChanged,
          TapCallback? onTap,
          bool? loading,
          bool allowUnlistedValues = false,
          ToggleStyle? style,
          StyleBuilder<int>? styleBuilder,
          CustomStyleBuilder<int>? customStyleBuilder,
          List<ToggleStyle>? styleList,
          bool? iconsTappable,
          double? spacing,
          SeparatorBuilder? separatorBuilder,
          FittingMode? fittingMode,
          Size? indicatorSize,
        }) =>
            AnimatedToggleSwitch<int>.dual(
          current: current,
          first: values[0],
          second: values[1],
          iconBuilder:
              iconBuilder == null ? null : (value) => iconBuilder(value, true),
          textBuilder: iconBuilder == null
              ? null
              : (value) =>
                  iconBuilder(values[(values.indexOf(value) + 1) % 2], false),
          textDirection: textDirection,
          onTap: onTap,
          onChanged: onChanged,
          loadingIconBuilder: _loadingIconBuilder,
          loading: loading,
          style: style ?? const ToggleStyle(),
          styleBuilder: styleBuilder,
          styleList: styleList,
          customStyleBuilder: customStyleBuilder,
          spacing: spacing ?? 40,
          fittingMode: fittingMode ?? FittingMode.preventHorizontalOverlapping,
          indicatorSize: indicatorSize ?? const Size.fromWidth(46.0),
        ),
        ConstructorType.dual,
        values,
      ),
    );
  }
}

/// Tests all AnimatedToggleSwitch constructors except [AnimatedToggleSwitch.dual]
void testAllSwitches<T>(
  String description,
  FutureOr<void> Function(WidgetTester tester, SwitchBuilder<T> buildSwitch,
          ConstructorType type)
      test, {
  bool testCustom = true,
  bool testSize = true,
}) {
  testWidgets(
      '$description (AnimatedToggleSwitch.rolling)',
      (tester) async => await test(
            tester,
            ({
              required T current,
              required List<T> values,
              TestIconBuilder<T>? iconBuilder,
              List<Widget>? iconList,
              TextDirection? textDirection,
              ChangeCallback<T>? onChanged,
              TapCallback? onTap,
              bool? loading,
              bool allowUnlistedValues = false,
              ToggleStyle? style,
              StyleBuilder<T>? styleBuilder,
              CustomStyleBuilder<T>? customStyleBuilder,
              List<ToggleStyle>? styleList,
              bool? iconsTappable,
              double? spacing,
              SeparatorBuilder? separatorBuilder,
              FittingMode? fittingMode,
              Size? indicatorSize,
            }) =>
                AnimatedToggleSwitch<T>.rolling(
              current: current,
              values: values,
              iconBuilder: iconBuilder,
              iconList: iconList,
              textDirection: textDirection,
              onTap: onTap,
              onChanged: onChanged,
              loadingIconBuilder: _loadingIconBuilder,
              loading: loading,
              allowUnlistedValues: allowUnlistedValues,
              style: style ?? const ToggleStyle(),
              styleBuilder: styleBuilder,
              customStyleBuilder: customStyleBuilder,
              styleList: styleList,
              iconsTappable: iconsTappable ?? true,
              spacing: spacing ?? 0.0,
              separatorBuilder: separatorBuilder,
              fittingMode:
                  fittingMode ?? FittingMode.preventHorizontalOverlapping,
              indicatorSize: indicatorSize ?? const Size.fromWidth(46.0),
            ),
            ConstructorType.rolling,
          ));

  testWidgets(
      '$description (AnimatedToggleSwitch.rollingByHeight)',
      (tester) async => await test(
            tester,
            ({
              required T current,
              required List<T> values,
              TestIconBuilder<T>? iconBuilder,
              List<Widget>? iconList,
              TextDirection? textDirection,
              ChangeCallback<T>? onChanged,
              TapCallback? onTap,
              bool? loading,
              bool allowUnlistedValues = false,
              ToggleStyle? style,
              StyleBuilder<T>? styleBuilder,
              CustomStyleBuilder<T>? customStyleBuilder,
              List<ToggleStyle>? styleList,
              bool? iconsTappable,
              double? spacing,
              SeparatorBuilder? separatorBuilder,
              FittingMode? fittingMode,
              Size? indicatorSize,
            }) =>
                AnimatedToggleSwitch<T>.rollingByHeight(
              current: current,
              values: values,
              iconBuilder: iconBuilder,
              iconList: iconList,
              textDirection: textDirection,
              onChanged: onChanged,
              onTap: onTap,
              loadingIconBuilder: _loadingIconBuilder,
              loading: loading,
              allowUnlistedValues: allowUnlistedValues,
              style: style ?? const ToggleStyle(),
              styleBuilder: styleBuilder,
              customStyleBuilder: customStyleBuilder,
              styleList: styleList,
              iconsTappable: iconsTappable ?? true,
              spacing: _convertToByHeightValue(spacing ?? 0.0, 50.0, 2.0),
              separatorBuilder: separatorBuilder,
              fittingMode:
                  fittingMode ?? FittingMode.preventHorizontalOverlapping,
              indicatorSize: indicatorSize == null
                  ? const Size.square(1.0)
                  : Size(
                      _convertToByHeightValue(indicatorSize.width, 50.0, 2.0),
                      _convertToByHeightValue(indicatorSize.height, 50.0, 2.0)),
            ),
            ConstructorType.rolling,
          ));
  if (testSize) {
    testWidgets(
        '$description (AnimatedToggleSwitch.size)',
        (tester) async => await test(
              tester,
              ({
                required T current,
                required List<T> values,
                TestIconBuilder<T>? iconBuilder,
                List<Widget>? iconList,
                TextDirection? textDirection,
                ChangeCallback<T>? onChanged,
                TapCallback? onTap,
                bool? loading,
                bool allowUnlistedValues = false,
                ToggleStyle? style,
                StyleBuilder<T>? styleBuilder,
                CustomStyleBuilder<T>? customStyleBuilder,
                List<ToggleStyle>? styleList,
                bool? iconsTappable,
                double? spacing,
                SeparatorBuilder? separatorBuilder,
                FittingMode? fittingMode,
                Size? indicatorSize,
              }) =>
                  AnimatedToggleSwitch<T>.size(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value) => iconBuilder(value, false),
                iconList: iconList,
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                styleList: styleList,
                iconsTappable: iconsTappable ?? true,
                spacing: spacing ?? 0.0,
                separatorBuilder: separatorBuilder,
                selectedIconScale: 1.0,
                fittingMode:
                    fittingMode ?? FittingMode.preventHorizontalOverlapping,
                indicatorSize: indicatorSize ?? const Size.fromWidth(46.0),
              ),
              ConstructorType.size,
            ));
    testWidgets(
        '$description (AnimatedToggleSwitch.sizeByHeight)',
        (tester) async => await test(
              tester,
              ({
                required T current,
                required List<T> values,
                TestIconBuilder<T>? iconBuilder,
                List<Widget>? iconList,
                TextDirection? textDirection,
                ChangeCallback<T>? onChanged,
                TapCallback? onTap,
                bool? loading,
                bool allowUnlistedValues = false,
                ToggleStyle? style,
                StyleBuilder<T>? styleBuilder,
                CustomStyleBuilder<T>? customStyleBuilder,
                List<ToggleStyle>? styleList,
                bool? iconsTappable,
                double? spacing,
                SeparatorBuilder? separatorBuilder,
                FittingMode? fittingMode,
                Size? indicatorSize,
              }) =>
                  AnimatedToggleSwitch<T>.sizeByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value) => iconBuilder(value, false),
                iconList: iconList,
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                styleList: styleList,
                iconsTappable: iconsTappable ?? true,
                spacing: _convertToByHeightValue(spacing ?? 0.0, 50.0, 2.0),
                separatorBuilder: separatorBuilder,
                selectedIconScale: 1.0,
                fittingMode:
                    fittingMode ?? FittingMode.preventHorizontalOverlapping,
                indicatorSize: indicatorSize == null
                    ? const Size.square(1.0)
                    : Size(
                        _convertToByHeightValue(indicatorSize.width, 50.0, 2.0),
                        _convertToByHeightValue(
                            indicatorSize.height, 50.0, 2.0)),
              ),
              ConstructorType.size,
            ));
  }
  if (testCustom) {
    testWidgets(
        '$description (AnimatedToggleSwitch.custom)',
        (tester) async => await test(
              tester,
              ({
                required T current,
                required List<T> values,
                TestIconBuilder<T>? iconBuilder,
                List<Widget>? iconList,
                TextDirection? textDirection,
                ChangeCallback<T>? onChanged,
                TapCallback? onTap,
                bool? loading,
                bool allowUnlistedValues = false,
                ToggleStyle? style,
                StyleBuilder<T>? styleBuilder,
                CustomStyleBuilder<T>? customStyleBuilder,
                List<ToggleStyle>? styleList,
                bool? iconsTappable,
                double? spacing,
                SeparatorBuilder? separatorBuilder,
                FittingMode? fittingMode,
                Size? indicatorSize,
              }) =>
                  AnimatedToggleSwitch<T>.custom(
                current: current,
                values: values,
                animatedIconBuilder: iconBuilder == null
                    ? null
                    : (context, local, global) =>
                        iconBuilder(local.value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                styleList: styleList,
                iconsTappable: iconsTappable ?? true,
                spacing: spacing ?? 0.0,
                separatorBuilder: separatorBuilder,
                fittingMode:
                    fittingMode ?? FittingMode.preventHorizontalOverlapping,
                indicatorSize: indicatorSize ?? const Size.fromWidth(46.0),
              ),
              ConstructorType.custom,
            ));
    testWidgets(
        '$description (AnimatedToggleSwitch.customByHeight)',
        (tester) async => await test(
              tester,
              ({
                required T current,
                required List<T> values,
                TestIconBuilder<T>? iconBuilder,
                List<Widget>? iconList,
                TextDirection? textDirection,
                ChangeCallback<T>? onChanged,
                TapCallback? onTap,
                bool? loading,
                bool allowUnlistedValues = false,
                ToggleStyle? style,
                StyleBuilder<T>? styleBuilder,
                CustomStyleBuilder<T>? customStyleBuilder,
                List<ToggleStyle>? styleList,
                bool? iconsTappable,
                double? spacing,
                SeparatorBuilder? separatorBuilder,
                FittingMode? fittingMode,
                Size? indicatorSize,
              }) =>
                  AnimatedToggleSwitch<T>.customByHeight(
                current: current,
                values: values,
                animatedIconBuilder: iconBuilder == null
                    ? null
                    : (context, local, global) =>
                        iconBuilder(local.value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                styleList: styleList,
                iconsTappable: iconsTappable ?? true,
                spacing: _convertToByHeightValue(spacing ?? 0.0, 50.0, 2.0),
                separatorBuilder: separatorBuilder,
                fittingMode:
                    fittingMode ?? FittingMode.preventHorizontalOverlapping,
                indicatorSize: indicatorSize == null
                    ? const Size.square(1.0)
                    : Size(
                        _convertToByHeightValue(indicatorSize.width, 50.0, 2.0),
                        _convertToByHeightValue(
                            indicatorSize.height, 50.0, 2.0)),
              ),
              ConstructorType.custom,
            ));
  }
}

double _convertToByHeightValue(
        double value, double height, double borderWidth) =>
    value / (height - 2 * borderWidth);

enum ConstructorType {
  custom,
  size,
  rolling(isRolling: true),
  dual(isRolling: true);

  final bool isRolling;

  const ConstructorType({this.isRolling = false});
}
