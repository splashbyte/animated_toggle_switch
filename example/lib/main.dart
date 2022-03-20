import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

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
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        style: theme.textTheme.headline6 ?? TextStyle(),
        child: SingleChildScrollView(
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
                value: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
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
                value: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                borderColor: Colors.transparent,
                foregroundBoxShadow: const [
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
              AnimatedToggleSwitch<int>.rolling(
                value: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                borderWidth: 4.5,
                indicatorColor: Colors.purpleAccent,
                innerColor: Colors.amber,
                height: 55,
                dif: 20.0,
                borderColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.dual:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<bool>.dual(
                value: positive,
                first: false,
                second: true,
                dif: 40.0,
                onChanged: (b) => setState(() => positive = b),
                colorBuilder: (b) => b ? Colors.red : Colors.green,
                iconBuilder: (context, local, global) => local.value
                    ? Icon(Icons.coronavirus_rounded)
                    : Icon(Icons.tag_faces_rounded),
                textBuilder: (context, local, global) => local.value
                    ? Center(child: Text('Oh no...'))
                    : Center(child: Text('Nice :)')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AnimatedToggleSwitch.size with some custom settings:',
                  textAlign: TextAlign.center,
                ),
              ),
              AnimatedToggleSwitch<int>.size(
                value: value,
                values: [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: Size.fromWidth(100),
                iconAnimationType: AnimationType.onHover,
                animationType: AnimationType.onHover,
                iconBuilder: (context, local, global) {
                  IconData data = Icons.access_time_rounded;
                  if (local.value.isEven) data = Icons.cancel;
                  return Container(
                      child: Icon(
                    data,
                    size: min(local.iconSize.width, local.iconSize.height),
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
                value: value,
                values: [0, 1, 2, 3],
                iconOpacity: 0.2,
                indicatorSize: Size.fromWidth(100),
                iconBuilder: (context, local, global) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${local.value}'),
                      alternativeIconBuilder(context, local, global),
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
                value: value,
                values: [0, 1, 2, 3],
                iconOpacity: 1.0,
                indicatorSize: Size.fromWidth(25),
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
                selectedIconSize: Size.square(20),
                iconSize: Size.square(20),
                iconBuilder: sizeIconBuilder,
                colorBuilder: (i) =>
                    i.isEven ? Colors.green : Colors.tealAccent,
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
                value: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                indicatorSize: Size.fromWidth(2),
              ),
              SizedBox(
                height: 16.0,
              ),
              AnimatedToggleSwitch<int>.rollingByHeight(
                height: 50.0,
                value: value,
                values: [0, 1, 2, 3],
                onChanged: (i) => setState(() => value = i),
                iconBuilder: rollingIconBuilder,
                borderRadius: BorderRadius.circular(75.0),
                indicatorSize: Size(1.5, 1.5),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16.0),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget iconBuilder(int value, Size iconSize) {
    IconData data = Icons.access_time_rounded;
    if (value.isEven) data = Icons.cancel;
    return Icon(
      data,
      size: iconSize.shortestSide,
    );
  }

  Widget sizeIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    return iconBuilder(local.value, local.iconSize);
  }

  Widget rollingIconBuilder(BuildContext context, RollingProperties<int> local,
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
