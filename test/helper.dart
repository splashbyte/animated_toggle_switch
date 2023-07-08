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

Widget iconBuilder<T>(T value, bool foreground) =>
    Text(key: iconKey(value, foreground: foreground), '$value');

Key iconKey<T>(T value, {bool foreground = false}) =>
    ValueKey((foreground, value));

typedef TestIconBuilder<T> = Widget Function(T value, bool foreground);

typedef SwitchBuilder<T> = AnimatedToggleSwitch Function({
  required T current,
  required List<T> values,
  TestIconBuilder<T>? iconBuilder,
  TextDirection? textDirection,
});

typedef SimpleSwitchBuilder<T> = AnimatedToggleSwitch Function({
  required T current,
  TestIconBuilder<T>? iconBuilder,
  TextDirection? textDirection,
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
            }) =>
                buildSwitch(
              current: current,
              values: defaultValues,
              iconBuilder: iconBuilder,
              textDirection: textDirection,
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
        }) =>
            AnimatedToggleSwitch.dual(
          current: current,
          first: defaultValues[0],
          second: defaultValues[1],
          iconBuilder:
              iconBuilder == null ? null : (value) => iconBuilder(value, true),
          textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.rolling(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size, foreground) =>
                        iconBuilder(value, foreground),
                textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.size(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size) => iconBuilder(value, false),
                textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.rollingByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size, foreground) =>
                        iconBuilder(value, foreground),
                textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.sizeByHeight(
                current: current,
                values: values,
                iconBuilder: iconBuilder == null
                    ? null
                    : (value, size) => iconBuilder(value, false),
                textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.custom(
                current: current,
                values: values,
                animatedIconBuilder: iconBuilder == null
                    ? null
                    : (context, local, global) =>
                        iconBuilder(local.value, false),
                textDirection: textDirection,
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
          }) =>
              AnimatedToggleSwitch<T>.customByHeight(
                current: current,
                values: values,
                animatedIconBuilder: iconBuilder == null
                    ? null
                    : (context, local, global) =>
                        iconBuilder(local.value, false),
                textDirection: textDirection,
              )));
}
