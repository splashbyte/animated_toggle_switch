import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    return Directionality(textDirection: textDirection, child: child);
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

Widget iconBuilder<T>(T value, bool foreground) =>
    Text(key: iconKey(value, foreground: foreground), '$value');

Key iconKey<T>(T value, {bool foreground = false}) =>
    ValueKey((foreground, value));

final loadingIconKey = GlobalKey();

Widget _loadingIconBuilder<T>(
        BuildContext context, GlobalToggleProperties<T> global) =>
    SizedBox(key: loadingIconKey);

typedef TestIconBuilder<T> = Widget Function(T value, bool foreground);

typedef SwitchBuilder<T> = AnimatedToggleSwitch Function({
  required T current,
  required List<T> values,
  TestIconBuilder<T>? iconBuilder,
  TextDirection? textDirection,
  Function(T)? onChanged,
  Function()? onTap,
  bool? loading,
});

typedef SimpleSwitchBuilder<T> = AnimatedToggleSwitch Function({
  required T current,
  TestIconBuilder<T>? iconBuilder,
  TextDirection? textDirection,
  Function(T)? onChanged,
  Function()? onTap,
  bool? loading,
});

/// Tests all AnimatedToggleSwitch constructors
void defaultTestAllSwitches(
    String description,
    FutureOr<void> Function(WidgetTester tester,
            SimpleSwitchBuilder<int> buildSwitch, List<int> values)
        test,
    {bool testDual = false}) {
  testAllSwitches<int>(
      description,
      (tester, buildSwitch) => test(
            tester,
            ({
              required int current,
              TestIconBuilder<int>? iconBuilder,
              TextDirection? textDirection,
              Function(int)? onChanged,
              Function()? onTap,
              bool? loading,
            }) =>
                buildSwitch(
              current: current,
              values: defaultValues,
              iconBuilder: iconBuilder,
              textDirection: textDirection,
              onChanged: onChanged,
              onTap: onTap,
              loading: loading,
            ),
            defaultValues,
          ));
  if (testDual) {
    testWidgets(
      '$description (AnimatedToggleSwitch.dual)',
      (tester) async => await test(
        tester,
        ({
          required int current,
          TestIconBuilder<int>? iconBuilder,
          TextDirection? textDirection,
          Function(int)? onChanged,
          Function()? onTap,
          LoadingIconBuilder? loadingIconBuilder,
          bool? loading,
        }) =>
            AnimatedToggleSwitch.dual(
          current: current,
          first: defaultValues[0],
          second: defaultValues[1],
          iconBuilder:
              iconBuilder == null ? null : (value) => iconBuilder(value, true),
          textDirection: textDirection,
          loading: loading,
        ),
        defaultValues.sublist(0, 2),
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
            Function(T)? onChanged,
            Function()? onTap,
            LoadingIconBuilder? loadingIconBuilder,
            bool? loading,
          }) =>
              AnimatedToggleSwitch<T>.rolling(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size, foreground) =>
                        iconBuilder(value, foreground),
                textDirection: textDirection,
                onTap: onTap,
                onChanged: onChanged,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
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
            Function(T)? onChanged,
            Function()? onTap,
            LoadingIconBuilder? loadingIconBuilder,
            bool? loading,
          }) =>
              AnimatedToggleSwitch<T>.size(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size) => iconBuilder(value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
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
            Function(T)? onChanged,
            Function()? onTap,
            LoadingIconBuilder? loadingIconBuilder,
            bool? loading,
          }) =>
              AnimatedToggleSwitch<T>.rollingByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size, foreground) =>
                        iconBuilder(value, foreground),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
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
            Function(T)? onChanged,
            Function()? onTap,
            LoadingIconBuilder? loadingIconBuilder,
            bool? loading,
          }) =>
              AnimatedToggleSwitch<T>.sizeByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size) => iconBuilder(value, false),
                textDirection: textDirection,
                onChanged: onChanged,
                onTap: onTap,
                loadingIconBuilder: _loadingIconBuilder,
                loading: loading,
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
            Function(T)? onChanged,
            Function()? onTap,
            LoadingIconBuilder? loadingIconBuilder,
            bool? loading,
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
            Function(T)? onChanged,
            Function()? onTap,
            bool? loading,
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
              )));
}
