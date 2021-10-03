# AnimatedToggleSwitch

<a href="https://pub.dev/packages/animated_toggle_switch"><img src="https://img.shields.io/pub/v/animated_toggle_switch.svg?style=flat?logo=dart" alt="pub.dev"></a>
<a href="https://github.com/SplashByte/animated_toggle_switch"><img src="https://img.shields.io/static/v1?label=platform&message=flutter&color=1ebbfd" alt="github"></a>
[![likes](https://badges.bar/animated_toggle_switch/likes)](https://pub.dev/packages/animated_toggle_switch/score)
[![popularity](https://badges.bar/animated_toggle_switch/popularity)](https://pub.dev/packages/animated_toggle_switch/score)
[![pub points](https://badges.bar/animated_toggle_switch/pub%20points)](https://pub.dev/packages/animated_toggle_switch/score)
<a href="https://github.com/SplashByte/animated_toggle_switch/blob/main/LICENSE"><img src="https://img.shields.io/github/license/SplashByte/animated_toggle_switch.svg" alt="license"></a>

[![buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/splashbyte)

### If you like this package, please leave a like there on [pub.dev](https://pub.dev/packages/animated_toggle_switch) and star on [GitHub](https://github.com/SplashByte/animated_toggle_switch).

Simple and animated switch with multiple choices. It's an easy way if you don't want to use something like a DropDownMenuButton.

### Example Usage
![usage](https://user-images.githubusercontent.com/43761463/114942384-c1200d00-9e44-11eb-9904-3cb1d7296da4.gif)

### Example
![example](https://user-images.githubusercontent.com/43761463/112705599-ebaf2380-8e9f-11eb-90d1-ea46509fdddd.gif)

## Easy Usage

Easy to use and highly customizable.

### Simple Rolling Animation

```dart
AnimatedToggleSwitch<int>.rolling(
  current: value,
  values: [0, 1, 2, 3],
  onChanged: (i) => setState(() => value = i),
  iconBuilder: iconBuilder,
)
```

### Custom with Size Animation

```dart
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
        iconBuilder(i, size, active),
      ],
    );
  },
  borderColor: value.isEven ? Colors.blue : Colors.red,
  colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
  onChanged: (i) => setState(() => value = i),
)
```

### Self-made rolling animation (with foregroundIndicatorIconBuilder)

```dart
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
)
```
