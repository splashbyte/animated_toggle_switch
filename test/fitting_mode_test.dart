import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
    'Switch overflows with FittingMode.none',
    (tester, buildSwitch, values) async {
      final current = values.first;

      await tester.pumpWidget(TestWrapper(
          child: SizedBox(width: 10.0, child: buildSwitch(current: current))));
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(TestWrapper(
          child: SizedBox(
              width: 30.0,
              child: buildSwitch(
                current: current,
                fittingMode: FittingMode.none,
              ))));
      expect(tester.takeException(), isA<FlutterError>());
    },
  );
}
