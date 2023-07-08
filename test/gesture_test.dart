import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helper.dart';
import 'mocks.dart';

void main() {
  defaultTestAllSwitches('Switch handles taps correctly',
      (tester, buildSwitch, values) async {
    final current = values.first;
    final next = values.last;
    final tapFunction = MockFunction();
    final changedFunction = MockOnChangedFunction();

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: tapFunction,
        onChanged: changedFunction,
      ),
    ));
    verifyNever(() => tapFunction.call());
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));

    await tester.tap(currentFinder, warnIfMissed: false);
    verify(() => tapFunction()).called(1);

    await tester.tap(nextFinder, warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);
  });

  testWidgets('Tap on AnimatedToggleSwitch.dual triggers onChanged by default',
      (tester) async {
    final values = defaultValues.sublist(0, 2);
    final current = values.first;
    final next = values.last;
    final changedFunction = MockOnChangedFunction();

    await tester.pumpWidget(TestWrapper(
      child: AnimatedToggleSwitch.dual(
        current: current,
        first: values.first,
        second: values.last,
        iconBuilder: (value) => iconBuilder(value, true),
        onChanged: changedFunction,
      ),
    ));
    verifyNever(() => changedFunction(any()));
    final currentFinder = find.byKey(iconKey(current, foreground: true));

    await tester.tap(currentFinder, warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);
  });

  defaultTestAllSwitches('Switch handles swipes correctly',
      (tester, buildSwitch, values) async {
    final current = values.first;
    final next = values.last;
    final tapFunction = MockFunction();
    final changedFunction = MockOnChangedFunction();

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: tapFunction,
        onChanged: changedFunction,
      ),
    ));
    verifyNever(() => tapFunction.call());
    verifyNever(() => changedFunction(any()));
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));

    await tester.drag(currentFinder, tester.getCenter(nextFinder),
        warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);

    await tester.drag(currentFinder, tester.getCenter(nextFinder),
        warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);
    verifyNever(() => changedFunction(current));
  });
}
