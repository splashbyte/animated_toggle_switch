import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void _checkValidSeparatorPositions<T>(
    WidgetTester tester, List<T> values, double dif) {
  for (int i = 0; i < values.length - 1; i++) {
    final separatorFinder = find.byKey(separatorKey(i));
    final firstIconFinder = find.byKey(iconKey(values[i]));
    final secondIconFinder = find.byKey(iconKey(values[i + 1]));
    expect(separatorFinder, findsOneWidget);
    expect(
      tester.getBottomRight(firstIconFinder) -
          tester.getBottomLeft(separatorFinder),
      Offset.zero,
      reason: 'separator is located right of the predecessor icon',
    );
    expect(
      tester.getBottomLeft(secondIconFinder) -
          tester.getBottomRight(separatorFinder),
      Offset.zero,
      reason: 'separator is located left of the successor icon',
    );
    expect(
      tester.getBottomRight(separatorFinder).dx -
          tester.getBottomLeft(separatorFinder).dx,
      dif,
      reason: 'separator has correct width',
    );
  }
}

void main() {
  defaultTestAllSwitches('Switch builds separator at correct position',
      (tester, buildSwitch, values) async {
    const difs = [5.0, 10.0, 17.0];
    final current = values[1];
    for (final dif in difs) {
      await tester.pumpWidget(
        TestWrapper(
          child: buildSwitch(
            current: current,
            dif: dif,
            iconBuilder: iconBuilder,
            separatorBuilder: separatorBuilder,
          ),
        ),
      );
      _checkValidSeparatorPositions(tester, values, dif);
    }
  }, testDual: false);
  defaultTestAllSwitches('separatorBuilder does not support dif = 0.0',
      (tester, buildSwitch, values) async {
    final current = values.first;
    await tester.pumpWidget(
      TestWrapper(
        child: buildSwitch(
          current: current,
          dif: 0.0,
          iconBuilder: iconBuilder,
          separatorBuilder: separatorBuilder,
        ),
      ),
    );
    expect(tester.takeException(), isAssertionError);
  }, testDual: false);
}