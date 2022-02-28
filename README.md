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
For a slider with a similar look, you can check out [action_slider](https://pub.dev/packages/action_slider).

### Example Usage
![usage](https://user-images.githubusercontent.com/43761463/114942384-c1200d00-9e44-11eb-9904-3cb1d7296da4.gif)

### Example
Standard AnimatedToggleSwitch.rolling()
![animated_toggle_switch_example_1](https://user-images.githubusercontent.com/43761463/155883140-77250e6a-dcce-4268-9444-7a745b875014.gif)
Modified AnimatedToggleSwitch.rolling()  
![animated_toggle_switch_example_2](https://user-images.githubusercontent.com/43761463/155883156-95d49242-53fc-41fd-ba25-6e4cb8addb2f.gif)
AnimatedToggleSwitch.dual()  
![animated_toggle_switch_example_3](https://user-images.githubusercontent.com/43761463/155883162-c4b59c85-df8c-49c4-b620-6297a61b4076.gif)
AnimatedToggleSwitch.size()  
![animated_toggle_switch_example_4](https://user-images.githubusercontent.com/43761463/155883167-ab8fa30f-6364-4ca3-acf3-288b7539aeeb.gif)
Custom AnimatedToggleSwitch.size()  
![animated_toggle_switch_example_5](https://user-images.githubusercontent.com/43761463/155883169-82448d84-3ddd-452e-abfd-df4446f961aa.gif)
AnimatedToggleSwitch.size() with custom rolling animation  
![animated_toggle_switch_example_6](https://user-images.githubusercontent.com/43761463/155883172-549c4d7a-5582-4213-ba2e-dfbeebd232be.gif)
AnimatedToggleSwitch.rolling() with custom indicatorType  
![animated_toggle_switch_example_7](https://user-images.githubusercontent.com/43761463/155883174-fec7a628-7708-4006-9843-2b3c9ec30a6b.gif)
![animated_toggle_switch_example_8](https://user-images.githubusercontent.com/43761463/155883176-8445df3d-17ad-44d3-b7cc-a2ed9636739c.gif)

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
