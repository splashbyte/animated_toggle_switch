import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: theme.textTheme.headline6 ?? TextStyle(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Standard AnimatedToggleSwitch.rolling:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.rolling(
                current: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: iconBuilder,
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
                values: [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: Size.fromWidth(100),
                indicatorType: IndicatorType.rectangle,
                iconBuilder: (i, size, active) {
                  IconData data = Icons.access_time_rounded;
                  if (i.isEven) data = Icons.cancel;
                  return Container(
                      child: Icon(
                    data,
                    size: min(size.width, size.height),
                  ));
                },
                borderWidth: 0.0,
                borderColor: Colors.transparent,
                colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
                onChanged: (i) => setState(() => value = i),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with a more custom icon',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                current: value,
                values: [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: Size.fromWidth(100),
                indicatorType: IndicatorType.rectangle,
                iconBuilder: (i, size, active) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$i'),
                      alternativeIconBuilder(i, size, active),
                    ],
                  );
                },
                borderColor: value.isEven ? Colors.blue : Colors.red,
                colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
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
                values: [0, 1, 2, 3],
                iconOpacity: 1.0,
                indicatorSize: Size.fromWidth(25),
                foregroundIndicatorIconBuilder: (d, indicatorSize) {
                  double transitionValue = d - d.floorToDouble();
                  return Transform.rotate(
                      angle: 2.0 * pi * transitionValue,
                      child: Stack(children: [
                        Opacity(opacity: 1 - transitionValue, child: iconBuilder(d.floor(), indicatorSize, true)),
                        Opacity(opacity: transitionValue, child: iconBuilder(d.ceil(), indicatorSize, true))
                      ]));
                },
                selectedIconSize: Size.square(20),
                iconSize: Size.square(20),
                indicatorType: IndicatorType.rectangle,
                iconBuilder: iconBuilder,
                colorBuilder: (i) => i.isEven ? Colors.green : Colors.tealAccent,
                onChanged: (i) => setState(() => value = i),
                borderRadius: BorderRadius.circular(8.0),
                borderColor: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.rollingByHeight with custom indicatorSize and indicatorType:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: iconBuilder,
                indicatorType: IndicatorType.roundedRectangle,
                indicatorSize: Size.fromWidth(2),
              ),
              SizedBox(
                height: 16.0,
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                current: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: iconBuilder,
                indicatorType: IndicatorType.circle,
                indicatorSize: Size.fromWidth(1.5),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget iconBuilder(int i, Size size, bool active) {
    IconData data = Icons.access_time_rounded;
    if (i.isEven) data = Icons.cancel;
    return Icon(
      data,
      size: size.shortestSide,
    );
  }

  Widget alternativeIconBuilder(int i, Size size, bool active) {
    IconData data = Icons.access_time_rounded;
    switch (i) {
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
      size: size.shortestSide,
    );
  }
}
