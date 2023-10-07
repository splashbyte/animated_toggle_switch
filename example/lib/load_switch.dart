// This switch is inspired by https://pub.dev/packages/load_switch

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class LoadSwitch extends StatefulWidget {
  const LoadSwitch({super.key});

  @override
  State<LoadSwitch> createState() => _LoadSwitchState();
}

class _LoadSwitchState extends State<LoadSwitch> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    const height = 50.0;
    const borderWidth = 5.0;
    return CustomAnimatedToggleSwitch(
      height: height,
      indicatorSize: Size.square(height),
      current: value,
      values: [false, true],
      onChanged: (newValue) {
        setState(() => value = newValue);
        return Future.delayed(const Duration(seconds: 2));
      },
      animationDuration: const Duration(milliseconds: 350),
      iconArrangement: IconArrangement.overlap,
      spacing: -16.0,
      wrapperBuilder: (context, global, child) => DecoratedBox(
          decoration: BoxDecoration(
              color: Color.lerp(
                  Color.lerp(Colors.red, Colors.green, global.position),
                  Colors.grey,
                  global.loadingAnimationValue),
              borderRadius:
                  const BorderRadius.all(Radius.circular(height / 2))),
          child: child),
      foregroundIndicatorBuilder: (context, global) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(borderWidth),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(borderWidth / 2),
              child: CircularProgressIndicator(
                strokeWidth: borderWidth,
                color: Colors.blue.withOpacity(global.loadingAnimationValue),
              ),
            ),
          ],
        );
      },
      iconBuilder: (context, local, global) => const SizedBox(),
    );
  }
}
