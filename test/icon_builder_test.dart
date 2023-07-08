import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch builds only one foreground icon & all background icons once',
      (tester, buildSwitch, values) async {
    final current = values[1];
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, values);
  });
  defaultTestAllSwitches(
      'AnimatedToggleSwitch changes its state when current changes',
      (tester, buildSwitch, values) async {
    final current = values.first;
    final next = values.last;
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, values);
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: next,
        iconBuilder: iconBuilder,
      ),
    ));
    checkValidSwitchIconBuilderState(current, values);
    await tester.pump(const Duration(seconds: 1));
    checkValidSwitchIconBuilderState(next, values);
  });
}
