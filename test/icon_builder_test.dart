import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void _checkValidSwitchIconBuilderState<T>(T current, List<T> values) {
  for (var value in values) {
    final iconFinder = find.byKey(iconKey(value));
    final iconForegroundFinder = find.byKey(iconKey(value, foreground: true));
    expect(iconFinder, findsOneWidget);
    expect(iconForegroundFinder,
        current == value ? anyOf(findsNothing, findsOneWidget) : findsNothing);
  }
}

void main() {
  defaultTestAllSwitches(
      'Switch builds only one foreground icon & all background icons once',
      (tester, buildSwitch, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    _checkValidSwitchIconBuilderState(current, values);
  });
  defaultTestAllSwitches(
      'AnimatedToggleSwitch changes its state when current changes',
      (tester, buildSwitch, values) async {
    final current = values.first;
    final next = values.last;
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    _checkValidSwitchIconBuilderState(current, values);
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
      ),
    ));
    _checkValidSwitchIconBuilderState(current, values);
    await tester.pump(const Duration(seconds: 1));
    _checkValidSwitchIconBuilderState(next, values);
  });
}
