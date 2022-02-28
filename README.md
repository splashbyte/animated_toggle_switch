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

### Examples
Standard AnimatedToggleSwitch.rolling()  
![animated_toggle_switch_example_1](https://user-images.githubusercontent.com/43761463/156060603-2d8fa9d0-d546-4f13-bede-ff918e7eafab.gif)  
Modified AnimatedToggleSwitch.rolling()  
![animated_toggle_switch_example_9](https://user-images.githubusercontent.com/43761463/156061462-29ffcc5d-515f-4642-bd50-2f89d7aa4a6b.gif)  
![animated_toggle_switch_example_2](https://user-images.githubusercontent.com/43761463/156060740-09aebb5e-2204-4171-bcd0-5522352879d1.gif)  
AnimatedToggleSwitch.dual()  
![animated_toggle_switch_example_3](https://user-images.githubusercontent.com/43761463/156060843-9dda0b45-b7c4-45e1-9aae-289ca0810104.gif)  
AnimatedToggleSwitch.size()  
![animated_toggle_switch_example_4](https://user-images.githubusercontent.com/43761463/156060925-ea3cfcf8-2a48-441f-89c7-c9d4b2b1e2e0.gif)  
Custom AnimatedToggleSwitch.size()  
![animated_toggle_switch_example_5](https://user-images.githubusercontent.com/43761463/156060966-9013d93a-b3ed-4ba8-94ab-3e07e5d1c279.gif)  
AnimatedToggleSwitch.size() with custom rolling animation  
![animated_toggle_switch_example_6](https://user-images.githubusercontent.com/43761463/156061043-3a7b222e-8b25-4f06-97d4-61d3f7d2f53b.gif)   
AnimatedToggleSwitch.rolling() with custom indicatorType  
![animated_toggle_switch_example_7](https://user-images.githubusercontent.com/43761463/156061700-0dccec36-389e-487f-8b57-1d8ebd79df83.gif)  
![animated_toggle_switch_example_8](https://user-images.githubusercontent.com/43761463/156061081-55e573fb-ce36-43f0-8cd7-95adb832aeba.gif)  

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
