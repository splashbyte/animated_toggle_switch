import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helper.dart';
import 'mocks.dart';

void main() {
  defaultTestAllSwitches('Switch handles taps correctly',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    final tapFunction = MockFunction();
    final changedFunction = MockOnChangedFunction<int>();

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
    verify(() => tapFunction()).called(1);

    verifyNoMoreInteractions(changedFunction);
  }, testDual: false);

  testWidgets('Tap on AnimatedToggleSwitch.dual triggers onChanged by default',
      (tester) async {
    final values = defaultValues.sublist(0, 2);
    final current = values.first;
    final next = values.last;
    final changedFunction = MockOnChangedFunction<int>();

    await tester.pumpWidget(TestWrapper(
      child: AnimatedToggleSwitch.dual(
        current: current,
        first: values.first,
        second: values.last,
        iconBuilder: (value) => iconBuilder(value, true),
        onChanged: changedFunction,
      ),
    ));
    final currentFinder = find.byKey(iconKey(current, foreground: true));

    verifyNoMoreInteractions(changedFunction);

    await tester.tap(currentFinder, warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);
    verifyNoMoreInteractions(changedFunction);
  });

  defaultTestAllSwitches('Switch handles drags correctly',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    final tapFunction = MockFunction();
    final changedFunction = MockOnChangedFunction<int>();

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: tapFunction,
        onChanged: changedFunction,
        // Necessary for AnimatedToggleSwitch.dual
        dif: 5.0,
      ),
    ));
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));

    verifyNoMoreInteractions(changedFunction);

    await tester.drag(currentFinder, tester.getCenter(nextFinder),
        warnIfMissed: false);
    verify(() => changedFunction(next)).called(1);

    await tester.drag(nextFinder, tester.getCenter(currentFinder),
        warnIfMissed: false);

    verifyNoMoreInteractions(changedFunction);
    verifyNoMoreInteractions(tapFunction);
  });

  defaultTestAllSwitches('Switch respects iconsTappable parameter',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final next = values.last;
    final tapFunction = MockFunction();
    final changedFunction = MockOnChangedFunction<int>();

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: tapFunction,
        onChanged: changedFunction,
        iconsTappable: false,
      ),
    ));
    verifyNever(() => tapFunction.call());
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));

    await tester.tap(currentFinder, warnIfMissed: false);
    verify(() => tapFunction()).called(1);

    await tester.tap(nextFinder, warnIfMissed: false);
    verify(() => tapFunction()).called(1);

    verifyNoMoreInteractions(changedFunction);
  }, testDual: false);
}
