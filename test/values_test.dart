import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches('Switch does not allow unlisted values',
      (tester, buildSwitch, values) async {
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: 100,
        iconBuilder: iconBuilder,
      ),
    ));

    expect(tester.takeException(), isA<ArgumentError>());
  });

  defaultTestAllSwitches(
    'Switch respects allowUnlistedValues',
    (tester, buildSwitch, values) async {
      await tester.pumpWidget(TestWrapper(
        child: buildSwitch(
          current: 100,
          iconBuilder: iconBuilder,
          allowUnlistedValues: true,
        ),
      ));

      expect(tester.takeException(), null);
    },
    testDual: false,
  );
}
