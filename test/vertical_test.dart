import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void _verifyVertical<T>(WidgetTester tester, List<T> values) {
  final firstPos = tester.getCenter(find.byKey(iconKey(values.first)));
  final lastPos = tester.getCenter(find.byKey(iconKey(values.last)));
  expect((firstPos - lastPos).dx == 0, true,
      reason: 'Icons do not have the same x-coordinate');
  expect((firstPos - lastPos).dy < 0, true,
      reason: 'Icons should be ordered top down');
}

void main() {
  defaultTestAllSwitches('Vertical switch',
      (tester, buildSwitch, type, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ).vertical(),
    ));
    _verifyVertical(tester, values);
  });
}
