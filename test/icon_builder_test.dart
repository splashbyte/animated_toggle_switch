import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch builds only one foreground icon & all background icons once',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, type, values);
  });

  defaultTestAllSwitches(
      'Switch builds only one foreground icon & all background icons once when using iconList',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconList: iconList(values),
      ),
    ));
    for (var value in values) {
      final iconFinder = find.byKey(iconKey(value));
      expect(
          iconFinder,
          current == value && type.isRolling
              ? findsNWidgets(2)
              : findsOneWidget);
    }
  }, testDual: false, testCustom: false);

  defaultTestAllSwitches(
      'Only one parameter from iconBuilder and iconList can be set.',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    expect(
        () => buildSwitch(
              current: current,
              iconBuilder: iconBuilder,
              iconList: iconList(values),
            ),
        throwsAssertionError);
  }, testDual: false, testCustom: false);

  defaultTestAllSwitches('iconList must have the same length as values',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    expect(
        () => buildSwitch(
              current: current,
              iconList: iconList(values).sublist(1),
            ),
        throwsAssertionError);
  }, testDual: false, testCustom: false);

  defaultTestAllSwitches('iconList must have the same length as values',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    expect(
        () => buildSwitch(
              current: current,
              iconList: iconList(values).sublist(1),
            ),
        throwsAssertionError);
  }, testDual: false, testCustom: false);

  defaultTestAllSwitches(
      'AnimatedToggleSwitch changes its state when current changes',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, type, values);
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, type, values);
    await tester.pump(const Duration(seconds: 1));
    checkValidSwitchIconBuilderState(next, type, values);
  });

  defaultTestAllSwitches('rolling switch shows two icons during animation (fading)',
      (tester, buildSwitch, type, values) async {
    final current = values[0];
    final next = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
      ),
    ));
    await tester.pump(const Duration(milliseconds: 100));
    for (var value in values) {
      final iconFinder = find.byKey(iconKey(value));
      final iconForegroundFinder = find.byKey(iconKey(value, foreground: true));
      expect(iconFinder, findsOneWidget);
      expect(
        iconForegroundFinder,
        current == value || next == value && type.isRolling
            ? findsOneWidget
            : findsNothing,
      );
    }
  }, testCustom: false, testSize: false);
}
