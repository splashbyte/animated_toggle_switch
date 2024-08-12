import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:example/crazy_switch.dart';
import 'package:example/load_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedToggleSwitch Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const MyHomePage(title: 'AnimatedToggleSwitch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value = 0;
  int? nullableValue;
  bool positive = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    const green = Color(0xFF45CC0D);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: theme.textTheme.titleLarge!,
        textAlign: TextAlign.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual:',
                ),
              ),
              SizedBox(
                child: AnimatedToggleSwitch<bool>.dual(
                  current: positive,
                  first: false,
                  second: true,
                  spacing: 50.0,
                  style: const ToggleStyle(
                    borderColor: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                  borderWidth: 5.0,
                  height: 55,
                  onChanged: (b) => setState(() => positive = b),
                  styleBuilder: (b) => ToggleStyle(
                      indicatorColor: b ? Colors.red : Colors.green),
                  iconBuilder: (value) => value
                      ? const Icon(Icons.coronavirus_rounded)
                      : const Icon(Icons.tag_faces_rounded),
                  textBuilder: (value) => value
                      ? const Center(child: Text('Oh no...'))
                      : const Center(child: Text('Nice :)')),
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 50.0,
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                borderWidth: 5.0,
                height: 55,
                onChanged: (b) => setState(() => positive = b),
                styleBuilder: (b) => ToggleStyle(
                  backgroundColor: b ? Colors.white : Colors.black,
                  indicatorColor: b ? Colors.blue : Colors.red,
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(4.0), right: Radius.circular(50.0)),
                  indicatorBorderRadius: BorderRadius.circular(b ? 50.0 : 4.0),
                ),
                iconBuilder: (value) => Icon(
                  value
                      ? Icons.access_time_rounded
                      : Icons.power_settings_new_rounded,
                  size: 32.0,
                  color: value ? Colors.black : Colors.white,
                ),
                textBuilder: (value) => value
                    ? const Center(
                        child:
                            Text('On', style: TextStyle(color: Colors.black)))
                    : const Center(
                        child:
                            Text('Off', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(height: 16.0),
              DefaultTextStyle.merge(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                child: IconTheme.merge(
                  data: const IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    animationDuration: const Duration(milliseconds: 600),
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    customStyleBuilder: (context, local, global) {
                      if (global.position <= 0.0) {
                        return ToggleStyle(backgroundColor: Colors.red[800]);
                      }
                      return ToggleStyle(
                          backgroundGradient: LinearGradient(
                        colors: [green, Colors.red[800]!],
                        stops: [
                          global.position -
                              (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                          global.position +
                              max(0, 2 * (global.position - 0.5)) * 0.7,
                        ],
                      ));
                    },
                    borderWidth: 6.0,
                    height: 60.0,
                    loadingIconBuilder: (context, global) =>
                        CupertinoActivityIndicator(
                            color: Color.lerp(
                                Colors.red[800], green, global.position)),
                    onChanged: (b) => setState(() => positive = b),
                    iconBuilder: (value) => value
                        ? const Icon(Icons.power_outlined,
                            color: green, size: 32.0)
                        : Icon(Icons.power_settings_new_rounded,
                            color: Colors.red[800], size: 32.0),
                    textBuilder: (value) => value
                        ? const Center(child: Text('Active'))
                        : const Center(child: Text('Inactive')),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual with loading animation:',
                ),
              ),
              DefaultTextStyle.merge(
                style: const TextStyle(color: Colors.white),
                child: IconTheme.merge(
                  data: const IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 0.5),
                        ),
                      ],
                    ),
                    borderWidth: 10.0,
                    height: 50,
                    loadingIconBuilder: (context, global) =>
                        const CupertinoActivityIndicator(color: Colors.white),
                    onChanged: (b) {
                      setState(() => positive = b);
                      return Future<dynamic>.delayed(
                          const Duration(seconds: 2));
                    },
                    styleBuilder: (b) => ToggleStyle(
                        indicatorColor: b ? Colors.purple : Colors.green),
                    iconBuilder: (value) => value
                        ? const Icon(Icons.coronavirus_rounded)
                        : const Icon(Icons.tag_faces_rounded),
                    textBuilder: (value) => value
                        ? const Center(
                            child: Text('Oh no...',
                                style: TextStyle(color: Colors.white)))
                        : const Center(child: Text('Nice :)')),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 45.0,
                animationDuration: const Duration(milliseconds: 600),
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  indicatorColor: Colors.white,
                  backgroundColor: Colors.amber,
                ),
                customStyleBuilder: (context, local, global) => ToggleStyle(
                    backgroundGradient: LinearGradient(
                  colors: const [Colors.green, Colors.red],
                  stops: [
                    global.position -
                        (1 - 2 * max(0, global.position - 0.5)) * 0.5,
                    global.position + max(0, 2 * (global.position - 0.5)) * 0.5,
                  ],
                )),
                borderWidth: 6.0,
                height: 60.0,
                loadingIconBuilder: (context, global) =>
                    CupertinoActivityIndicator(
                        color: Color.lerp(
                            Colors.red, Colors.green, global.position)),
                onChanged: (b) {
                  setState(() => positive = b);
                  return Future<dynamic>.delayed(const Duration(seconds: 2));
                },
                iconBuilder: (value) => value
                    ? const Icon(Icons.power_outlined,
                        color: Colors.green, size: 32.0)
                    : const Icon(Icons.power_settings_new_rounded,
                        color: Colors.red, size: 32.0),
                textBuilder: (value) => Center(
                    child: Text(
                  value ? 'On' : 'Off',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Switch inspired by package '),
                    TextSpan(
                        text: 'lite_rolling_switch',
                        style: tappableTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(liteRollingSwitchUrl))
                  ]),
                ),
              ),
              DefaultTextStyle.merge(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                child: IconTheme.merge(
                  data: const IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 600),
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    styleBuilder: (value) => ToggleStyle(
                        backgroundColor: value ? green : Colors.red[800]),
                    borderWidth: 6.0,
                    height: 60.0,
                    loadingIconBuilder: (context, global) =>
                        CupertinoActivityIndicator(
                            color: Color.lerp(
                                Colors.red[800], green, global.position)),
                    onChanged: (b) => setState(() => positive = b),
                    iconBuilder: (value) => value
                        ? const Icon(Icons.lightbulb_outline_rounded,
                            color: green, size: 28.0)
                        : Icon(Icons.power_settings_new_rounded,
                            color: Colors.red[800], size: 30.0),
                    textBuilder: (value) => value
                        ? const Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('Active'))
                        : const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text('Inactive')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Switch inspired by package '),
                    TextSpan(
                        text: 'toggle_switch',
                        style: tappableTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(toggleSwitchUrl))
                  ]),
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: min(value, 2),
                style: ToggleStyle(
                  backgroundColor: const Color(0xFF919191),
                  indicatorColor: const Color(0xFFEC3345),
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  indicatorBorderRadius: BorderRadius.zero,
                ),
                values: const [0, 1, 2],
                iconOpacity: 1.0,
                selectedIconScale: 1.0,
                indicatorSize: const Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                styleAnimationType: AnimationType.onHover,
                spacing: 2.0,
                customSeparatorBuilder: (context, local, global) {
                  final opacity =
                      ((global.position - local.position).abs() - 0.5)
                          .clamp(0.0, 1.0);
                  return VerticalDivider(
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white38.withOpacity(opacity));
                },
                customIconBuilder: (context, local, global) {
                  final text = const ['not', 'only', 'icons'][local.index];
                  return Center(
                      child: Text(text,
                          style: TextStyle(
                              color: Color.lerp(Colors.black, Colors.white,
                                  local.animationValue))));
                },
                borderWidth: 0.0,
                onChanged: (i) => setState(() => value = i),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Switch inspired by '),
                    TextSpan(
                        text: 'Crazy Switch',
                        style: tappableTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(crazySwitchUrl))
                  ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: CrazySwitch(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                  TextSpan(children: [
                    const TextSpan(text: 'Switch inspired by '),
                    TextSpan(
                        text: 'load_switch',
                        style: tappableTextStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(loadSwitchUrl))
                  ]),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: LoadSwitch(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Standard AnimatedToggleSwitch.rolling:',
                ),
              ),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                indicatorIconScale: sqrt2,
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() => value = i);
                  return Future<dynamic>.delayed(const Duration(seconds: 3));
                },
                iconBuilder: rollingIconBuilder,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Switch with unselected value:',
                ),
              ),
              AnimatedToggleSwitch<int?>.rolling(
                allowUnlistedValues: true,
                styleAnimationType: AnimationType.onHover,
                current: nullableValue,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
                customStyleBuilder: (context, local, global) {
                  final color = local.isValueListed
                      ? null
                      : Theme.of(context).colorScheme.error;
                  return ToggleStyle(borderColor: color, indicatorColor: color);
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'You can make any switch vertical:',
                ),
              ),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                values: const [0, 1, 2, 3],
                indicatorIconScale: sqrt2,
                style: const ToggleStyle(
                  indicatorColor: Colors.blue,
                  borderColor: Colors.blue,
                  backgroundColor: Colors.white,
                ),
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                loading: false,
              ).vertical(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Customized AnimatedToggleSwitch.rolling:',
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rolling(
                active: false,
                current: value,
                values: const [0, 1, 2, 3],
                indicatorIconScale: sqrt2,
                onChanged: (i) {
                  setState(() {
                    value = i;
                    loading = true;
                  });
                  return Future<Object?>.delayed(const Duration(seconds: 3))
                      .then((_) => setState(() => loading = false));
                },
                iconBuilder: rollingIconBuilder,
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  indicatorBoxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              IconTheme.merge(
                data: const IconThemeData(color: Colors.white),
                child: AnimatedToggleSwitch<int>.rolling(
                  current: value,
                  values: const [0, 1, 2, 3],
                  onChanged: (i) => setState(() => value = i),
                  style: const ToggleStyle(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      )
                    ],
                  ),
                  indicatorIconScale: sqrt2,
                  iconBuilder: coloredRollingIconBuilder,
                  borderWidth: 3.0,
                  styleAnimationType: AnimationType.onHover,
                  styleBuilder: (value) => ToggleStyle(
                    backgroundColor: colorBuilder(value),
                    borderRadius: BorderRadius.circular(value * 10.0),
                    indicatorBorderRadius: BorderRadius.circular(value * 10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                separatorBuilder: (index) => const VerticalDivider(),
                borderWidth: 4.5,
                style: ToggleStyle(
                  indicatorColor: Colors.white,
                  backgroundColor: Colors.amber,
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                styleBuilder: (i) => ToggleStyle(
                  indicatorGradient: LinearGradient(
                      colors: [colorBuilder(i), colorBuilder((i + 1) % 4)]),
                ),
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int?>.rolling(
                current: nullableValue,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onTap: (info) {
                  if (nullableValue == info.tapped?.value) {
                    setState(() => nullableValue = null);
                  }
                },
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
                borderWidth: 4.5,
                style: const ToggleStyle(
                  indicatorColor: Colors.white,
                  backgroundGradient:
                      LinearGradient(colors: [Colors.red, Colors.blue]),
                  borderColor: Colors.transparent,
                ),
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'You can make any other switch with CustomAnimatedToggleSwitch:',
                ),
              ),
              CustomAnimatedToggleSwitch<bool>(
                current: positive,
                values: const [false, true],
                spacing: 0.0,
                indicatorSize: const Size.square(30.0),
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.linear,
                onChanged: (b) => setState(() => positive = b),
                iconBuilder: (context, local, global) {
                  return const SizedBox();
                },
                cursors: const ToggleCursors(
                    defaultCursor: SystemMouseCursors.click),
                onTap: (_) => setState(() => positive = !positive),
                iconsTappable: false,
                wrapperBuilder: (context, global, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          left: 10.0,
                          right: 10.0,
                          height: 20.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Color.lerp(Colors.black26,
                                  theme.colorScheme.surface, global.position),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                            ),
                          )),
                      child,
                    ],
                  );
                },
                foregroundIndicatorBuilder: (context, global) {
                  return SizedBox.fromSize(
                    size: global.indicatorSize,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.lerp(
                            Colors.white, theme.primaryColor, global.position),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 0.05,
                              blurRadius: 1.1,
                              offset: Offset(0.0, 0.8))
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with some custom settings:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                styleAnimationType: AnimationType.onHover,
                iconBuilder: (value) => Icon(
                    value.isEven ? Icons.cancel : Icons.access_time_rounded),
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                ),
                borderWidth: 0.0,
                styleBuilder: (i) {
                  final color = colorBuilder(i);
                  return ToggleStyle(
                    backgroundColor: color.withOpacity(0.3),
                    indicatorColor: color,
                  );
                },
                onChanged: (i) {
                  setState(() => value = i);
                  return Future<dynamic>.delayed(const Duration(seconds: 3));
                },
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.size(
                textDirection: TextDirection.rtl,
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                iconBuilder: iconBuilder,
                borderWidth: 4.0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                styleBuilder: (i) =>
                    ToggleStyle(indicatorColor: colorBuilder(i)),
                onChanged: (i) => setState(() => value = i),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.size(
                current: positive,
                values: const [false, true],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                customIconBuilder: (context, local, global) => Text(
                    local.value ? 'RAM' : 'CPU',
                    style: TextStyle(
                        color: Color.lerp(
                            Colors.black, Colors.white, local.animationValue))),
                borderWidth: 4.0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  indicatorColor: Colors.teal,
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    ),
                  ],
                ),
                selectedIconScale: 1.0,
                onChanged: (b) => setState(() => positive = b),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with a more custom icon and TextDirection.rtl:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                textDirection: TextDirection.rtl,
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                customIconBuilder: (context, local, global) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${local.value}'),
                      alternativeIconBuilder(context, local, global),
                    ],
                  );
                },
                style: const ToggleStyle(borderColor: Colors.transparent),
                styleBuilder: (i) => ToggleStyle(
                    indicatorColor:
                        i.isEven == true ? Colors.amber : Colors.red),
                onChanged: (i) => setState(() => value = i),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with custom rotating animation:',
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 1.0,
                selectedIconScale: 1.0,
                indicatorSize: const Size.fromWidth(25),
                foregroundIndicatorIconBuilder: (context, global) {
                  double pos = global.position;
                  double transitionValue = pos - pos.floorToDouble();
                  return Transform.rotate(
                      angle: 2.0 * pi * transitionValue,
                      child: Stack(children: [
                        Opacity(
                            opacity: 1 - transitionValue,
                            child: iconBuilder(pos.floor())),
                        Opacity(
                            opacity: transitionValue,
                            child: iconBuilder(pos.ceil()))
                      ]));
                },
                iconBuilder: iconBuilder,
                style: const ToggleStyle(
                  borderColor: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  indicatorBorderRadius: BorderRadius.zero,
                ),
                styleBuilder: (i) => ToggleStyle(
                    indicatorColor:
                        i.isEven == true ? Colors.green : Colors.tealAccent),
                onChanged: (i) => setState(() => value = i),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.rollingByHeight with custom indicatorSize and borderRadius:',
                ),
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: const Size.fromWidth(2),
              ),
              const SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: const Size.square(1.5),
                style: ToggleStyle(borderRadius: BorderRadius.circular(75.0)),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16.0),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Color colorBuilder(int value) => switch (value) {
        0 => Colors.blueAccent,
        1 => Colors.green,
        2 => Colors.orangeAccent,
        _ => Colors.red,
      };

  Widget coloredRollingIconBuilder(int value, bool foreground) {
    final color = foreground ? colorBuilder(value) : null;
    return Icon(
      iconDataByValue(value),
      color: color,
    );
  }

  Widget iconBuilder(int value) {
    return rollingIconBuilder(value, false);
  }

  Widget rollingIconBuilder(int? value, bool foreground) {
    return Icon(iconDataByValue(value));
  }

  IconData iconDataByValue(int? value) => switch (value) {
        0 => Icons.access_time_rounded,
        1 => Icons.check_circle_outline_rounded,
        2 => Icons.power_settings_new_rounded,
        _ => Icons.lightbulb_outline_rounded,
      };

  Widget sizeIconBuilder(BuildContext context,
      AnimatedToggleProperties<int> local, GlobalToggleProperties<int> global) {
    return iconBuilder(local.value);
  }

  Widget alternativeIconBuilder(BuildContext context,
      AnimatedToggleProperties<int> local, GlobalToggleProperties<int> global) {
    IconData data = Icons.access_time_rounded;
    switch (local.value) {
      case 0:
        data = Icons.ac_unit_outlined;
        break;
      case 1:
        data = Icons.account_circle_outlined;
        break;
      case 2:
        data = Icons.assistant_navigation;
        break;
      case 3:
        data = Icons.arrow_drop_down_circle_outlined;
        break;
    }
    return Icon(data);
  }
}

const tappableTextStyle = TextStyle(color: Colors.blue);

final toggleSwitchUrl = Uri.parse('https://pub.dev/packages/toggle_switch');
final liteRollingSwitchUrl =
    Uri.parse('https://pub.dev/packages/lite_rolling_switch');
final crazySwitchUrl =
    Uri.parse('https://github.com/pedromassango/crazy-switch');
final loadSwitchUrl = Uri.parse('https://pub.dev/packages/load_switch');
