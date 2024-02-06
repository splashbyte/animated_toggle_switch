import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:mocktail/mocktail.dart';

import 'helper.dart';
import 'mocks.dart';

void main() {
  defaultTestAllSwitches(
      'AnimatedToggleSwitch changes its state when current changes',
      (tester, buildSwitch, type, values) async {
    final current = values.first;
    final nextIndex = values.length - 1;
    final next = values[nextIndex];
    final positionListener = MockPositionListenerFunction<int>();
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        positionListener: positionListener,
      ),
    ));
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
        positionListener: positionListener,
      ),
    ));
    await tester.pump(const Duration(seconds: 1));
    verify(() => positionListener(PositionListenerInfo(
        value: next,
        index: nextIndex,
        position: nextIndex.toDouble(),
        mode: ToggleMode.none))).called(1);
  });
}
