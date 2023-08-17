import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  defaultTestAllSwitches(
    'Switch overflows with FittingMode.none',
    (tester, buildSwitch, type, values) async {
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

  defaultTestAllSwitches(
    'Switch expands its size when forced by constraints',
    (tester, buildSwitch, type, values) async {
      final current = values.first;
      final switchFinder = find.byType(AnimatedToggleSwitch<int>);
      const width = 500.0;

      await tester.pumpWidget(TestWrapper(
          child: SizedBox(
              width: width,
              child: buildSwitch(
                current: current,
              ))));

      expect(tester.getSize(switchFinder).width, width);
    },
  );

  defaultTestAllSwitches(
    'Switch expands its size when dif is set to infinite',
    (tester, buildSwitch, type, values) async {
      final current = values.first;
      final switchFinder = find.byType(AnimatedToggleSwitch<int>);
      const width = 500.0;

      await tester.pumpWidget(Center(
        child: SizedBox(
            width: width,
            child: TestWrapper(
              child: buildSwitch(
                current: current,
                dif: double.infinity,
              ),
            )),
      ));
      expect(tester.getSize(switchFinder).width, width);
    },
  );

  defaultTestAllSwitches(
    'Switch expands its size when indicatorSize.width is set to infinite',
    (tester, buildSwitch, type, values) async {
      final current = values.first;
      final switchFinder = find.byType(AnimatedToggleSwitch<int>);
      const width = 500.0;

      await tester.pumpWidget(Center(
        child: SizedBox(
            width: width,
            child: TestWrapper(
              child: buildSwitch(
                current: current,
                indicatorSize: Size.infinite,
              ),
            )),
      ));
      expect(tester.getSize(switchFinder).width, width);
    },
  );

  defaultTestAllSwitches(
    'Switch throws error when two of dif, indicatorSize.width and constraints are infinite',
    (tester, buildSwitch, type, values) async {
      final current = values.first;
      const width = 500.0;

      await tester.pumpWidget(Center(
        child: SizedBox(
            width: width,
            child: TestWrapper(
              child: buildSwitch(
                current: current,
                indicatorSize: Size.infinite,
                dif: double.infinity,
              ),
            )),
      ));
      expect(tester.takeException(), isAssertionError);

      await tester.pumpWidget(TestWrapper(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildSwitch(
              current: current,
              dif: double.infinity,
            ),
          ],
        ),
      ));
      expect(tester.takeException(), isAssertionError);

      await tester.pumpWidget(TestWrapper(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildSwitch(
              current: current,
              indicatorSize: Size.infinite,
            ),
          ],
        ),
      ));
      expect(tester.takeException(), isAssertionError);
    },
  );
}
