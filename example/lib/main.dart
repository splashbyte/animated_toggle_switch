import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:example/crazy_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedToggleSwitch Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: MyHomePage(title: 'Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
        style: theme.textTheme.titleLarge ?? TextStyle(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 50.0,
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  boxShadow: const [
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
                styleBuilder: (b) =>
                    ToggleStyle(indicatorColor: b ? Colors.red : Colors.green),
                iconBuilder: (value) =>
                value
                    ? Icon(Icons.coronavirus_rounded)
                    : Icon(Icons.tag_faces_rounded),
                textBuilder: (value) =>
                value
                    ? Center(child: Text('Oh no...'))
                    : Center(child: Text('Nice :)')),
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 50.0,
                style: const ToggleStyle(
                  borderColor: Colors.transparent,
                  boxShadow: const [
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
                styleBuilder: (b) =>
                    ToggleStyle(
                      backgroundColor: b ? Colors.white : Colors.black,
                      indicatorColor: b ? Colors.blue : Colors.red,
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(4.0),
                          right: Radius.circular(50.0)),
                      indicatorBorderRadius: BorderRadius.circular(
                          b ? 50.0 : 4.0),
                    ),
                iconBuilder: (value) =>
                    Icon(
                      value
                          ? Icons.access_time_rounded
                          : Icons.power_settings_new_rounded,
                      size: 32.0,
                      color: value ? Colors.black : Colors.white,
                    ),
                textBuilder: (value) =>
                value
                    ? const Center(
                    child:
                    Text('On', style: TextStyle(color: Colors.black)))
                    : const Center(
                    child:
                    Text('Off', style: TextStyle(color: Colors.white))),
              ),
              SizedBox(height: 16.0),
              DefaultTextStyle.merge(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                child: IconTheme.merge(
                  data: IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    animationDuration: const Duration(milliseconds: 600),
                    style: ToggleStyle(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    customStyleBuilder: (context, local, global) {
                      if (global.position <= 0.0)
                        return ToggleStyle(backgroundColor: Colors.red[800]);
                      return ToggleStyle(
                          backgroundGradient: LinearGradient(
                            colors: [green, Colors.red[800]!],
                            stops: [
                              global.position -
                                  (1 - 2 * max(0, global.position - 0.5)) * 0.2,
                              global.position +
                                  max(0, 2 * (global.position - 0.5)) * 0.2,
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
                    iconBuilder: (value) =>
                    value
                        ? Icon(Icons.power_outlined, color: green, size: 32.0)
                        : Icon(Icons.power_settings_new_rounded,
                        color: Colors.red[800], size: 32.0),
                    textBuilder: (value) =>
                    value
                        ? Center(child: Text('Active'))
                        : Center(child: Text('Inactive')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual with loading animation:',
                  textAlign: TextAlign.center,
                ),
              ),
              DefaultTextStyle.merge(
                style: const TextStyle(color: Colors.white),
                child: IconTheme.merge(
                  data: IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      boxShadow: const [
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
                      return Future<dynamic>.delayed(Duration(seconds: 2));
                    },
                    styleBuilder: (b) =>
                        ToggleStyle(
                            indicatorColor: b ? Colors.purple : Colors.green),
                    iconBuilder: (value) =>
                    value
                        ? Icon(Icons.coronavirus_rounded)
                        : Icon(Icons.tag_faces_rounded),
                    textBuilder: (value) =>
                    value
                        ? Center(
                        child: Text('Oh no...',
                            style: const TextStyle(color: Colors.white)))
                        : Center(child: Text('Nice :)')),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                spacing: 45.0,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 600),
                style: ToggleStyle(
                  borderColor: Colors.transparent,
                  indicatorColor: Colors.white,
                  backgroundColor: Colors.amber,
                ),
                styleBuilder: (value) =>
                    ToggleStyle(
                        backgroundColor: value ? Colors.orange : Colors
                            .red[800]),
                borderWidth: 6.0,
                height: 60.0,
                loadingIconBuilder: (context, global) =>
                    CupertinoActivityIndicator(
                        color: Color.lerp(
                            Colors.red[800], Colors.orange, global.position)),
                onChanged: (b) {
                  setState(() => positive = b);
                  return Future<dynamic>.delayed(Duration(seconds: 2));
                },
                iconBuilder: (value) =>
                value
                    ? Icon(Icons.power_outlined,
                    color: Colors.orange, size: 32.0)
                    : Icon(Icons.power_settings_new_rounded,
                    color: Colors.red[800], size: 32.0),
                textBuilder: (value) =>
                    Center(
                        child: Text(
                          value ? 'Active' : 'Inactive',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600),
                        )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Switch inspired by package lite_rolling_switch',
                  textAlign: TextAlign.center,
                ),
              ),
              DefaultTextStyle.merge(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                child: IconTheme.merge(
                  data: IconThemeData(color: Colors.white),
                  child: AnimatedToggleSwitch<bool>.dual(
                    current: positive,
                    first: false,
                    second: true,
                    spacing: 45.0,
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 600),
                    style: ToggleStyle(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    styleBuilder: (value) =>
                        ToggleStyle(
                            backgroundColor: value ? green : Colors.red[800]),
                    borderWidth: 6.0,
                    height: 60.0,
                    loadingIconBuilder: (context, global) =>
                        CupertinoActivityIndicator(
                            color: Color.lerp(
                                Colors.red[800], green, global.position)),
                    onChanged: (b) {
                      setState(() => positive = b);
                      return Future<dynamic>.delayed(Duration(seconds: 2));
                    },
                    iconBuilder: (value) =>
                    value
                        ? Icon(Icons.power_outlined, color: green, size: 32.0)
                        : Icon(Icons.power_settings_new_rounded,
                        color: Colors.red[800], size: 32.0),
                    textBuilder: (value) =>
                    value
                        ? Center(child: Text('Active'))
                        : Center(child: Text('Inactive')),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Switch inspired by CrazySwitch (https://github.com/pedromassango/crazy-switch)',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: const CrazySwitch(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Standard AnimatedToggleSwitch.rolling:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                indicatorIconScale: sqrt2,
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() => value = i);
                  return Future<dynamic>.delayed(Duration(seconds: 3));
                },
                iconBuilder: rollingIconBuilder,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Switch with unselected value:',
                  textAlign: TextAlign.center,
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
                  final color = local.isValueListed ? null : Theme
                      .of(context)
                      .colorScheme
                      .error;
                  return ToggleStyle(borderColor: color, indicatorColor: color);
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Customized AnimatedToggleSwitch.rolling:',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rolling(
                active: false,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() {
                    value = i;
                    loading = true;
                  });
                  return Future<Object?>.delayed(Duration(seconds: 3))
                      .then((_) => setState(() => loading = false));
                },
                iconBuilder: rollingIconBuilder,
                style: ToggleStyle(
                  borderColor: Colors.transparent,
                  indicatorBoxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1.5),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              IconTheme.merge(
                data: IconThemeData(color: Colors.white),
                child: AnimatedToggleSwitch<int>.rolling(
                  current: value,
                  values: const [0, 1, 2, 3],
                  onChanged: (i) => setState(() => value = i),
                  style: ToggleStyle(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      )
                    ],
                  ),
                  iconBuilder: coloredRollingIconBuilder,
                  borderWidth: 3.0,
                  styleAnimationType: AnimationType.onHover,
                  styleBuilder: (value) =>
                      ToggleStyle(
                        backgroundColor: colorBuilder(value),
                        borderRadius: BorderRadius.circular(value * 10.0),
                        indicatorBorderRadius: BorderRadius.circular(
                            value * 10.0),
                      ),
                ),
              ),
              SizedBox(height: 16.0),
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
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<int?>.rolling(
                current: nullableValue,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onTap: () => setState(() => nullableValue = null),
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
                borderWidth: 4.5,
                style: ToggleStyle(
                  indicatorColor: Colors.white,
                  backgroundGradient:
                  const LinearGradient(colors: [Colors.red, Colors.blue]),
                  borderColor: Colors.transparent,
                ),
                height: 55,
                spacing: 20.0,
                loading: loading,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You can make any other switch with CustomAnimatedToggleSwitch:',
                  textAlign: TextAlign.center,
                ),
              ),
              CustomAnimatedToggleSwitch<bool>(
                current: positive,
                values: [false, true],
                spacing: 0.0,
                indicatorSize: Size.square(30.0),
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.linear,
                onChanged: (b) => setState(() => positive = b),
                iconBuilder: (context, local, global) {
                  return const SizedBox();
                },
                cursors: ToggleCursors(defaultCursor: SystemMouseCursors.click),
                onTap: () => setState(() => positive = !positive),
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
                              color: Color.lerp(
                                  Colors.black26,
                                  theme.colorScheme.background,
                                  global.position),
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
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with some custom settings:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: const Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                styleAnimationType: AnimationType.onHover,
                iconBuilder: (value) =>
                    Icon(
                        value.isEven ? Icons.cancel : Icons
                            .access_time_rounded),
                style: ToggleStyle(
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
                  return Future<dynamic>.delayed(Duration(seconds: 3));
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
                    BoxShadow(
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
                customIconBuilder: (context, local, global) =>
                    Text(
                        local.value ? 'RAM' : 'CPU',
                        style: TextStyle(
                            color: Color.lerp(
                                Colors.black, Colors.white,
                                local.animationValue))),
                borderWidth: 4.0,
                iconAnimationType: AnimationType.onHover,
                style: ToggleStyle(
                  indicatorColor: Colors.teal,
                  borderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Switch inspired by package toggle_switch',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: min(value, 2),
                style: ToggleStyle(
                  backgroundColor: Color(0xFF919191),
                  indicatorColor: Color(0xFFEC3345),
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
                child: Text(
                  'AnimatedToggleSwitch.size with a more custom icon and TextDirection.rtl:',
                  textAlign: TextAlign.center,
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
                style: ToggleStyle(borderColor: Colors.transparent),
                styleBuilder: (i) =>
                    ToggleStyle(
                        indicatorColor:
                        i.isEven == true ? Colors.amber : Colors.red),
                onChanged: (i) => setState(() => value = i),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with custom rotating animation:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: const [0, 1, 2, 3],
                iconOpacity: 1.0,
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
                styleBuilder: (i) =>
                    ToggleStyle(
                        indicatorColor:
                        i.isEven == true ? Colors.green : Colors.tealAccent),
                onChanged: (i) => setState(() => value = i),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.rollingByHeight with custom indicatorSize and borderRadius:',
                  textAlign: TextAlign.center,
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
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: const Size.square(1.5),
                style: ToggleStyle(borderRadius: BorderRadius.circular(75.0)),
              ),
              SizedBox(height: MediaQuery
                  .of(context)
                  .padding
                  .bottom + 16.0),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Color colorBuilder(int value) =>
      switch (value) {
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

  IconData iconDataByValue(int? value) =>
      switch (value) {
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
