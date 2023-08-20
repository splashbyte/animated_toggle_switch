// This switch is inspired by https://github.com/pedromassango/crazy-switch

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class CrazySwitch extends StatefulWidget {
  const CrazySwitch({super.key});

  @override
  State<CrazySwitch> createState() => _CrazySwitchState();
}

class _CrazySwitchState extends State<CrazySwitch> {
  bool current = false;

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFFD0821);
    const green = Color(0xFF46E82E);
    const borderWidth = 10.0;
    const height = 58.0;
    const innerIndicatorSize = height - 4 * borderWidth;

    return CustomAnimatedToggleSwitch(
      current: current,
      spacing: 36.0,
      values: [false, true],
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.bounceOut,
      iconBuilder: (context, local, global) => const SizedBox(),
      onTap: (_) => setState(() => current = !current),
      iconsTappable: false,
      onChanged: (b) => setState(() => current = b),
      height: height,
      padding: const EdgeInsets.all(borderWidth),
      indicatorSize: const Size.square(height - 2 * borderWidth),
      foregroundIndicatorBuilder: (context, global) {
        final color = Color.lerp(red, green, global.position)!;
        // You can replace the Containers with DecoratedBox/SizedBox/Center
        // for slightly better performance
        return Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Container(
              width: innerIndicatorSize * 0.4 +
                  global.position * innerIndicatorSize * 0.6,
              height: innerIndicatorSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: color,
              )),
        );
      },
      wrapperBuilder: (context, global, child) {
        final color = Color.lerp(red, green, global.position)!;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(50.0),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.7),
                blurRadius: 12.0,
                offset: const Offset(0.0, 8.0),
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}
