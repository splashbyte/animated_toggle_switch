import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'keys.dart';

const defaultValues = [0, 1, 2, 3];

class TestWrapper extends StatelessWidget {
  final Widget child;
  final TextDirection textDirection;

  const TestWrapper({
    Key? key,
    required this.child,
    this.textDirection = TextDirection.ltr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: Center(child: child),
    );
  }
}

void checkValidSwitchIconBuilderState<T>(T current, List<T> values) {
  for (var value in values) {
    final iconFinder = find.byKey(iconKey(value));
    final iconForegroundFinder = find.byKey(iconKey(value, foreground: true));
    expect(iconFinder, findsOneWidget);
    expect(iconForegroundFinder,
        current == value ? anyOf(findsNothing, findsOneWidget) : findsNothing);
  }
}

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
  TextDirection? textDirection,
  ChangeCallback<T>? onChanged,
  TapCallback? onTap,
  bool? loading,
  bool allowUnlistedValues,
  ToggleStyle? style,
  StyleBuilder<T>? styleBuilder,
  CustomStyleBuilder<T>? customStyleBuilder,
  bool? iconsTappable,
  double? dif,
  SeparatorBuilder? separatorBuilder,
});

typedef SimpleSwitchBuilder<T> = AnimatedToggleSwitch<T> Function({
  required T current,
  TestIconBuilder<T>? iconBuilder,
  TextDirection? textDirection,
  ChangeCallback<T>? onChanged,
  TapCallback? onTap,
  bool? loading,
  bool allowUnlistedValues,
  ToggleStyle? style,
  StyleBuilder<T>? styleBuilder,
  CustomStyleBuilder<T>? customStyleBuilder,
  bool? iconsTappable,
  double? dif,
  SeparatorBuilder? separatorBuilder,
});

/// Tests all AnimatedToggleSwitch constructors
void defaultTestAllSwitches(
    String description,
    FutureOr<void> Function(WidgetTester tester,
            SimpleSwitchBuilder<int> buildSwitch, List<int> values)
        test,
    {bool testDual = true}) {
  testAllSwitches<int>(
      description,
      (tester, buildSwitch) => test(
            tester,
            ({
              required int current,
              TestIconBuilder<int>? iconBuilder,
              TextDirection? textDirection,
              ChangeCallback<int>? onChanged,
              TapCallback? onTap,
              bool? loading,
              bool allowUnlistedValues = false,
              ToggleStyle? style,
              StyleBuilder<int>? styleBuilder,
              CustomStyleBuilder<int>? customStyleBuilder,
              bool? iconsTappable,
              double? dif,
              SeparatorBuilder? separatorBuilder,
            }) =>
                buildSwitch(
              current: current,
              values: defaultValues,
              iconBuilder: iconBuilder,
              textDirection: textDirection,
              onChanged: onChanged,
              onTap: onTap,
              loading: loading,
              allowUnlistedValues: allowUnlistedValues,
              style: style,
              styleBuilder: styleBuilder,
              customStyleBuilder: customStyleBuilder,
              iconsTappable: iconsTappable,
              dif: dif,
              separatorBuilder: separatorBuilder,
            ),
            defaultValues,
          ));
  if (testDual) {
    final values = defaultValues.sublist(0, 2);
    testWidgets(
      '$description (AnimatedToggleSwitch.dual)',
      (tester) async => await test(
        tester,
        ({
          required int current,
          TestIconBuilder<int>? iconBuilder,
          TextDirection? textDirection,
          ChangeCallback<int>? onChanged,
          TapCallback? onTap,
          bool? loading,
          bool allowUnlistedValues = false,
          ToggleStyle? style,
          StyleBuilder<int>? styleBuilder,
          CustomStyleBuilder<int>? customStyleBuilder,
          bool? iconsTappable,
          double? dif,
          SeparatorBuilder? separatorBuilder,
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
          customStyleBuilder: customStyleBuilder,
          dif: dif ?? 40,
        ),
        values,
      ),
    );
  }
}

/// Tests all AnimatedToggleSwitch constructors except [AnimatedToggleSwitch.dual]
void testAllSwitches<T>(
    String description,
    FutureOr<void> Function(WidgetTester tester, SwitchBuilder<T> buildSwitch)
        test) {
  testWidgets(
      '$description (AnimatedToggleSwitch.rolling)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
          }) =>
              AnimatedToggleSwitch<T>.rolling(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, foreground) => iconBuilder(value, foreground),
                textDirection: textDirection,
                onTap: onTap,
                onChanged: onChanged,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                iconsTappable: iconsTappable ?? true,
                dif: dif ?? 0.0,
                separatorBuilder: separatorBuilder,
              )));
  testWidgets(
      '$description (AnimatedToggleSwitch.size)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
          }) =>
              AnimatedToggleSwitch<T>.size(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value) => iconBuilder(value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                iconsTappable: iconsTappable ?? true,
                dif: dif ?? 0.0,
                separatorBuilder: separatorBuilder,
                selectedIconScale: 1.0,
              )));
  testWidgets(
      '$description (AnimatedToggleSwitch.rollingByHeight)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
          }) =>
              AnimatedToggleSwitch<T>.rollingByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder,
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                iconsTappable: iconsTappable ?? true,
                dif: _convertToByHeightValue(dif ?? 0.0, 50.0, 2.0),
                separatorBuilder: separatorBuilder,
              )));
  testWidgets(
      '$description (AnimatedToggleSwitch.sizeByHeight)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
          }) =>
              AnimatedToggleSwitch<T>.sizeByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value) => iconBuilder(value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
                allowUnlistedValues: allowUnlistedValues,
                style: style ?? const ToggleStyle(),
                styleBuilder: styleBuilder,
                customStyleBuilder: customStyleBuilder,
                iconsTappable: iconsTappable ?? true,
                dif: _convertToByHeightValue(dif ?? 0.0, 50.0, 2.0),
                separatorBuilder: separatorBuilder,
                selectedIconScale: 1.0,
              )));
  testWidgets(
      '$description (AnimatedToggleSwitch.custom)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
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
                iconsTappable: iconsTappable ?? true,
                dif: dif ?? 0.0,
                separatorBuilder: separatorBuilder,
              )));
  testWidgets(
      '$description (AnimatedToggleSwitch.customByHeight)',
      (tester) async => await test(
          tester,
          ({
            required T current,
            required List<T> values,
            TestIconBuilder<T>? iconBuilder,
            TextDirection? textDirection,
            ChangeCallback<T>? onChanged,
            TapCallback? onTap,
            bool? loading,
            bool allowUnlistedValues = false,
            ToggleStyle? style,
            StyleBuilder<T>? styleBuilder,
            CustomStyleBuilder<T>? customStyleBuilder,
            bool? iconsTappable,
            double? dif,
            SeparatorBuilder? separatorBuilder,
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
                iconsTappable: iconsTappable ?? true,
                dif: _convertToByHeightValue(dif ?? 0.0, 50.0, 2.0),
                separatorBuilder: separatorBuilder,
              )));
}

double _convertToByHeightValue(
        double value, double height, double borderWidth) =>
    value / (height - 2 * borderWidth);
