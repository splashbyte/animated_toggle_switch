import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch throws error if styleBuilder and customStyleBuilder are set both',
      (tester, buildSwitch, values) async {
    expect(
      () => buildSwitch(
        current: 100,
        styleBuilder: (v) => const ToggleStyle(),
        customStyleBuilder: (c, l, g) => const ToggleStyle(),
      ),
      throwsAssertionError,
    );
  });
}
