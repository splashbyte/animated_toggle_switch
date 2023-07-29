import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void _verifyTextDirection<T>(
    WidgetTester tester, List<T> values, TextDirection textDirection) {
  final firstPos = tester.getCenter(find.byKey(iconKey(values.first)));
  final lastPos = tester.getCenter(find.byKey(iconKey(values.last)));
  switch (textDirection) {
    case TextDirection.ltr:
      expect((firstPos - lastPos).dx < 0, true,
          reason: 'First icon is to the left of the second');
      break;
    case TextDirection.rtl:
      expect((firstPos - lastPos).dx > 0, true,
          reason: 'First icon is to the right of the second');
      break;
  }
}

void main() {
  defaultTestAllSwitches('Switch respects TextDirection',
      (tester, buildSwitch, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      textDirection: TextDirection.ltr,
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    _verifyTextDirection(tester, values, TextDirection.ltr);

    await tester.pumpWidget(TestWrapper(
      textDirection: TextDirection.rtl,
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    _verifyTextDirection(tester, values, TextDirection.rtl);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        textDirection: TextDirection.ltr,
      ),
    ));
    _verifyTextDirection(tester, values, TextDirection.ltr);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        textDirection: TextDirection.rtl,
      ),
    ));
    _verifyTextDirection(tester, values, TextDirection.rtl);
  }, testDual: false);
}
