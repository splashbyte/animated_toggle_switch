import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
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
      theme: ThemeData(),
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
                dif: 50.0,
                colors: const SwitchColors(borderColor: Colors.transparent),
                borderWidth: 5.0,
                height: 55,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1.5),
                  ),
                ],
                onChanged: (b) => setState(() => positive = b),
                colorBuilder: (b) =>
                    SwitchColors(indicatorColor: b ? Colors.red : Colors.green),
                iconBuilder: (value) => value
                    ? Icon(Icons.coronavirus_rounded)
                    : Icon(Icons.tag_faces_rounded),
                textBuilder: (value) => value
                    ? Center(child: Text('Oh no...'))
                    : Center(child: Text('Nice :)')),
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<bool>.dual(
                current: positive,
                first: false,
                second: true,
                dif: 50.0,
                colors: const SwitchColors(borderColor: Colors.transparent),
                borderWidth: 5.0,
                height: 55,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1.5),
                  ),
                ],
                onChanged: (b) => setState(() => positive = b),
                colorBuilder: (b) => SwitchColors.withBorder(
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
                ),
                textBuilder: (value) => value
                    ? const Center(
                        child:
                            Text('On', style: TextStyle(color: Colors.black)))
                    : const Center(
                        child:
                            Text('Off', style: TextStyle(color: Colors.white))),
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
                    dif: 45.0,
                    colors: const SwitchColors(
                      borderColor: Colors.transparent,
                      backgroundColor: Colors.black,
                    ),
                    borderWidth: 10.0,
                    height: 50,
                    loadingIconBuilder: (context, global) =>
                        const CupertinoActivityIndicator(color: Colors.white),
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0.5),
                      ),
                    ],
                    onChanged: (b) {
                      setState(() => positive = b);
                      return Future.delayed(Duration(seconds: 2));
                    },
                    colorBuilder: (b) => SwitchColors(
                        indicatorColor: b ? Colors.purple : Colors.green),
                    iconBuilder: (value) => value
                        ? Icon(Icons.coronavirus_rounded)
                        : Icon(Icons.tag_faces_rounded),
                    textBuilder: (value) => value
                        ? Center(
                            child: Text('Oh no...',
                                style: const TextStyle(color: Colors.white)))
                        : Center(child: Text('Nice :)')),
                  ),
                ),
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
                    dif: 45.0,
                    colors: SwitchColors(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    colorBuilder: (value) => SwitchColors(
                        backgroundColor: value ? green : Colors.red[800]),
                    borderWidth: 6.0,
                    height: 60.0,
                    loadingIconBuilder: (context, global) =>
                        CupertinoActivityIndicator(
                            color: Color.lerp(
                                Colors.red[800], green, global.position)),
                    onChanged: (b) {
                      setState(() => positive = b);
                      return Future.delayed(Duration(seconds: 2));
                    },
                    iconBuilder: (value) => value
                        ? Icon(Icons.power_outlined, color: green, size: 32.0)
                        : Icon(Icons.power_settings_new_rounded,
                            color: Colors.red[800], size: 32.0),
                    textBuilder: (value) => value
                        ? Center(child: Text('Active'))
                        : Center(child: Text('Inactive')),
                  ),
                ),
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
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() => value = i);
                  return Future.delayed(Duration(seconds: 3));
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
                current: nullableValue,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => nullableValue = i),
                iconBuilder: rollingIconBuilder,
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
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) {
                  setState(() {
                    value = i;
                    loading = true;
                  });
                  return Future.delayed(Duration(seconds: 3))
                      .then((_) => setState(() => loading = false));
                },
                iconBuilder: rollingIconBuilder,
                colors: SwitchColors(borderColor: Colors.transparent),
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
              SizedBox(height: 16.0),
              IconTheme.merge(
                data: IconThemeData(color: Colors.white),
                child: AnimatedToggleSwitch<int>.rolling(
                  current: value,
                  values: const [0, 1, 2, 3],
                  onChanged: (i) => setState(() => value = i),
                  colors: SwitchColors(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                  ),
                  iconBuilder: coloredRollingIconBuilder,
                  borderWidth: 3.0,
                  colorAnimationType: AnimationType.onHover,
                  colorBuilder: (value) => SwitchColors.withBorder(
                    backgroundColor: colorBuilder(value),
                    borderRadius: BorderRadius.circular(value * 10.0),
                    indicatorBorderRadius: BorderRadius.circular(value * 10.0),
                  ),
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
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                allowUnlistedValues: true,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                separatorBuilder: (context, index) => const VerticalDivider(),
                borderWidth: 4.5,
                colors: SwitchColors(
                  indicatorColor: Colors.white,
                  backgroundColor: Colors.amber,
                  borderColor: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10.0),
                height: 55,
                dif: 20.0,
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
                colors: SwitchColors(
                  indicatorColor: Colors.white,
                  backgroundGradient:
                      const LinearGradient(colors: [Colors.red, Colors.blue]),
                  borderColor: Colors.transparent,
                ),
                height: 55,
                dif: 20.0,
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
                dif: 0.0,
                indicatorSize: Size.square(30.0),
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.linear,
                onChanged: (b) => setState(() => positive = b),
                iconBuilder: (context, local, global) {
                  return const SizedBox();
                },
                defaultCursor: SystemMouseCursors.click,
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
                colorAnimationType: AnimationType.onHover,
                iconBuilder: (value, size) {
                  IconData data = Icons.access_time_rounded;
                  if (value.isEven) data = Icons.cancel;
                  return Icon(
                    data,
                    size: min(size.width, size.height),
                  );
                },
                colors: const SwitchColors(borderColor: Colors.transparent),
                borderWidth: 0.0,
                colorBuilder: (i) => SwitchColors(
                    indicatorColor:
                        i.isEven == true ? Colors.amber : Colors.red),
                onChanged: (i) {
                  setState(() => value = i);
                  return Future.delayed(Duration(seconds: 3));
                },
              ),
              SizedBox(height: 16.0),
              AnimatedToggleSwitch<int>.size(
                current: min(value, 2),
                borderRadius: BorderRadius.circular(10.0),
                indicatorBorderRadius: BorderRadius.zero,
                colors: SwitchColors(
                  backgroundColor: Color(0xFF919191),
                  indicatorColor: Color(0xFFEC3345),
                  borderColor: Colors.transparent,
                ),
                values: const [0, 1, 2],
                iconOpacity: 1.0,
                indicatorSize: const Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                colorAnimationType: AnimationType.onHover,
                dif: 2.0,
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
                colors: SwitchColors(borderColor: Colors.transparent),
                colorBuilder: (i) => SwitchColors(
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
                            child:
                                iconBuilder(pos.floor(), global.indicatorSize)),
                        Opacity(
                            opacity: transitionValue,
                            child:
                                iconBuilder(pos.ceil(), global.indicatorSize))
                      ]));
                },
                selectedIconSize: const Size.square(20),
                iconSize: const Size.square(20),
                iconBuilder: iconBuilder,
                colors: const SwitchColors(borderColor: Colors.red),
                colorBuilder: (i) => SwitchColors(
                    indicatorColor:
                        i.isEven == true ? Colors.green : Colors.tealAccent),
                onChanged: (i) => setState(() => value = i),
                borderRadius: BorderRadius.circular(8.0),
                indicatorBorderRadius: BorderRadius.zero,
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
              SizedBox(
                height: 16.0,
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: const [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                borderRadius: BorderRadius.circular(75.0),
                indicatorSize: const Size.square(1.5),
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

  Widget coloredRollingIconBuilder(int value, Size iconSize, bool foreground) {
    final color = foreground ? colorBuilder(value) : null;
    return Icon(
      switch (value) {
        0 => Icons.access_time_rounded,
        1 => Icons.check_circle_outline_rounded,
        2 => Icons.power_settings_new_rounded,
        _ => Icons.lightbulb_outline_rounded,
      },
      color: color,
      size: iconSize.shortestSide,
    );
  }

  Widget iconBuilder(int value, Size iconSize) {
    return rollingIconBuilder(value, iconSize, false);
  }

  Widget rollingIconBuilder(int? value, Size iconSize, bool foreground) {
    IconData data = Icons.access_time_rounded;
    if (value?.isEven ?? false) data = Icons.cancel;
    return Icon(
      data,
      size: iconSize.shortestSide,
    );
  }

  Widget sizeIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    return iconBuilder(local.value, local.iconSize);
  }

  Widget alternativeIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
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
    return Icon(
      data,
      size: local.iconSize.shortestSide,
    );
  }
}
