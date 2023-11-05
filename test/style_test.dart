import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:animated_toggle_switch/src/test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch throws error if styleBuilder and customStyleBuilder are set both',
      (tester, buildSwitch, type, values) async {
    expect(
      () => buildSwitch(
        current: 100,
        styleBuilder: (v) => const ToggleStyle(),
        customStyleBuilder: (c, l, g) => const ToggleStyle(),
      ),
      throwsAssertionError,
    );
  });

  defaultTestAllSwitches(
      'Switch respects indicatorAnimationType: AnimationType.none',
      (tester, buildSwitch, type, values) async {
    const styleList = [
      ToggleStyle(indicatorColor: Colors.green),
      ToggleStyle(indicatorColor: Colors.red),
      ToggleStyle(indicatorColor: Colors.blue),
      ToggleStyle(indicatorColor: Colors.orange),
    ];
    final current = values[0];
    final next = values[1];
    final currentColor = styleList[0].indicatorColor;
    final nextColor = styleList[1].indicatorColor;
    final indicatorBoxFinder =
        find.byKey(AnimatedToggleSwitchTestKeys.indicatorDecoratedBoxKey);
    BoxDecoration findIndicatorBox() =>
        (tester.firstWidget(indicatorBoxFinder) as DecoratedBox).decoration
            as BoxDecoration;
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        styleList: styleList,
        indicatorAnimationType: AnimationType.none,
      ),
    ));
    expect(findIndicatorBox().color, equals(currentColor));
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
        styleList: styleList,
        indicatorAnimationType: AnimationType.none,
      ),
    ));
    expect(findIndicatorBox().color, equals(nextColor));
  }, testDual: false);
}
