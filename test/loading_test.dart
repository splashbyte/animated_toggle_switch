import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
      'Switch starts loading by returning Future in onTap or onChanged',
      (tester, buildSwitch, values) async {
    final current = values.first;
    final next = values.last;
    const loadingDuration = Duration(seconds: 3);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        onTap: () => Future.delayed(loadingDuration),
        onChanged: (_) => Future.delayed(loadingDuration),
      ),
    ));
    final currentFinder = find.byKey(iconKey(current));
    final nextFinder = find.byKey(iconKey(next));
    final loadingFinder = find.byKey(loadingIconKey);

    Future<void> testLoading() async {
      expect(loadingFinder, findsNothing);
      await tester.pump(Duration.zero);
      await tester.pump(loadingDuration ~/ 2);
      expect(loadingFinder, findsOneWidget);
      await tester.pump(loadingDuration ~/ 2);
      await tester.pump(const Duration(milliseconds: 500));
      expect(loadingFinder, findsNothing);
    }

    // tests onChanged
    await tester.tap(nextFinder, warnIfMissed: false);
    await testLoading();

    // tests onTap
    await tester.tap(currentFinder, warnIfMissed: false);
    await testLoading();
  });

  defaultTestAllSwitches('Switch starts loading by setting loading parameter',
      (tester, buildSwitch, values) async {
    final current = values.first;

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: false,
      ),
    ));
    final loadingFinder = find.byKey(loadingIconKey);

    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: true,
      ),
    ));
    expect(loadingFinder, findsNothing);
    await tester.pump(const Duration(milliseconds: 500));
    expect(loadingFinder, findsOneWidget);
    await tester.pumpWidget(TestWrapper(
      child: buildSwitch(
        current: current,
        iconBuilder: iconBuilder,
        loading: false,
      ),
    ));
    expect(loadingFinder, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));
    expect(loadingFinder, findsNothing);
  });
}
