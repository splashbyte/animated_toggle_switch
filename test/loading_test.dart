import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch starts loading by returning Future in onTap or onChanged',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    const loadingDuration = Duration(seconds: 3);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: () => Future<dynamic>.delayed(loadingDuration),
        onChanged: (_) => Future<dynamic>.delayed(loadingDuration),
      ),
    ));
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));
    final loadingFinder = find.byKey(loadingIconKey);

    Future<void> testLoading() async {
      expect(loadingFinder, findsNothing);
      await tester.pump(Duration.zero);
      await tester.pump(loadingDuration ~/ 2);
      expect(loadingFinder, findsOneWidget);
      await tester.pump(loadingDuration ~/ 2);
      await tester.pump(const Duration(milliseconds: 500));
      expect(loadingFinder, findsNothing);
    }

    // tests onChanged
    await tester.tap(nextFinder, warnIfMissed: false);
    await testLoading();

    // tests onTap
    await tester.tap(currentFinder, warnIfMissed: false);
    await testLoading();
  });

  defaultTestAllSwitches('Switch starts loading by setting loading parameter',
      (tester, buildSwitch, type, values) async {
    final current = values.first;

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: false,
      ),
    ));
    final loadingFinder = find.byKey(loadingIconKey);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: true,
      ),
    ));
    expect(loadingFinder, findsNothing);
    await tester.pump(const Duration(milliseconds: 500));
    expect(loadingFinder, findsOneWidget);
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: false,
      ),
    ));
    expect(loadingFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
    expect(loadingFinder, findsNothing);
  }, testDual: false);

  defaultTestAllSwitches('Switch supports initial loading',
      (tester, buildSwitch, type, values) async {
    final current = values.first;

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: true,
      ),
    ));
    final currentFinder = find.byKey(iconKey(current, foreground: true));
    final loadingFinder = find.byKey(loadingIconKey);

    expect(loadingFinder, findsOneWidget);
    expect(currentFinder, findsNothing);
  });

  defaultTestAllSwitches('Switch disables loading by setting loading to false',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    const loadingDuration = Duration(seconds: 3);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: () => Future<dynamic>.delayed(loadingDuration),
        onChanged: (_) => Future<dynamic>.delayed(loadingDuration),
        loading: false,
      ),
    ));
    final nextFinder = find.byKey(iconKey(next));
    final loadingFinder = find.byKey(loadingIconKey);

    expect(loadingFinder, findsNothing);

    await tester.tap(nextFinder, warnIfMissed: false);
    await tester.pump(Duration.zero);
    await tester.pump(const Duration(milliseconds: 500));

    expect(loadingFinder, findsNothing);

    await tester.pump(loadingDuration);
  });

  testWidgets(
    'Default loading animation switches between TargetPlatform',
    (tester) async {
      const values = defaultValues;
      final current = values.first;

      final circularProgressIndicatorFinder =
          find.byType(CircularProgressIndicator);
      final cupertinoActivityIndicatorFinder =
          find.byType(CupertinoActivityIndicator);

      await tester.pumpWidget(TestWrapper(
        platform: TargetPlatform.android,
        child: AnimatedToggleSwitch.rolling(
          current: current,
          values: values,
          loading: true,
        ),
      ));
      expect(circularProgressIndicatorFinder, findsOneWidget);
      expect(cupertinoActivityIndicatorFinder, findsNothing);

      await tester.pumpWidget(TestWrapper(
        platform: TargetPlatform.iOS,
        child: AnimatedToggleSwitch.rolling(
          current: current,
          values: values,
          loading: true,
        ),
      ));
      expect(circularProgressIndicatorFinder, findsNothing);
      expect(cupertinoActivityIndicatorFinder, findsOneWidget);
    },
  );
}
