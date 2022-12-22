# AnimatedToggleSwitch

[![pub.dev](https://img.shields.io/pub/v/animated_toggle_switch.svg?style=flat?logo=dart)](https://pub.dev/packages/animated_toggle_switch)
[![github](https://img.shields.io/static/v1?label=platform&message=flutter&color=1ebbfd)](https://github.com/SplashByte/animated_toggle_switch)
[![likes](https://img.shields.io/pub/likes/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![popularity](https://img.shields.io/pub/popularity/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![pub points](https://img.shields.io/pub/points/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![license](https://img.shields.io/github/license/SplashByte/animated_toggle_switch.svg)](https://github.com/SplashByte/animated_toggle_switch/blob/main/LICENSE)

[![buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/splashbyte)

### If you like this package, please leave a like there on [pub.dev](https://pub.dev/packages/animated_toggle_switch) and star on [GitHub](https://github.com/SplashByte/animated_toggle_switch).

Simple and animated switch with multiple choices and smooth loading animation. It's an easy way if you don't want to use something like a `DropDownMenuButton`.  
`LTR` and `RTL` are both supported.  
Most builder arguments of `AnimatedToggleSwitch` have a standard and a custom version. This ensures that you can get started easily and still customize a lot if necessary.

For a slider with a similar look, you can check out [action_slider](https://pub.dev/packages/action_slider).

### Example Usage
![usage](https://user-images.githubusercontent.com/43761463/114942384-c1200d00-9e44-11eb-9904-3cb1d7296da4.gif)

### Examples
`AnimatedToggleSwitch.dual()`  
![animated_toggle_switch_example_dual](https://user-images.githubusercontent.com/43761463/161432631-e6dd3d16-7b64-410b-a9fa-c956d3442598.gif)  
`AnimatedToggleSwitch.dual()` with loading animation  
![animated_toggle_switch_example_dual_loading](https://user-images.githubusercontent.com/43761463/209120973-1d4d4fdc-3274-4747-9f6e-9523a75830e7.gif)  

`AnimatedToggleSwitch.rolling()`  
![animated_toggle_switch_example_1](https://user-images.githubusercontent.com/43761463/161432579-9fe81c57-6463-45c3-a48f-75db666a3a22.gif)  
`AnimatedToggleSwitch.rolling()` with loading animation  
![animated_toggle_switch_example_rolling_loading](https://user-images.githubusercontent.com/43761463/209121057-2ff2bfc3-063e-4704-a981-f5cc5f54720a.gif)  

Modified `AnimatedToggleSwitch.rolling()`  
![animated_toggle_switch_example_2](https://user-images.githubusercontent.com/43761463/161432589-d76f61f6-cb97-42e2-b1fd-8c5203a965fa.gif)  
![animated_toggle_switch_example_3](https://user-images.githubusercontent.com/43761463/161432610-e8e4014a-34f1-4cbc-876b-2ab6ef856484.gif)  
![animated_toggle_switch_example_gradient](https://user-images.githubusercontent.com/43761463/209117203-90a41ddc-db1c-41be-8375-5304317d1352.gif)  

You can build any other switch with `CustomAnimatedToggleSwitch()`  
![animated_toggle_switch_example_custom_1](https://user-images.githubusercontent.com/43761463/161433015-c3ec634a-38da-463d-a06e-4ae0b29f77ed.gif)  

`AnimatedToggleSwitch.size()`  
![animated_toggle_switch_example_4](https://user-images.githubusercontent.com/43761463/161432714-435d8369-7e54-432a-8b9b-6b55a0764f4a.gif)  
`AnimatedToggleSwitch.size()` with loading animation  
![animated_toggle_switch_example_size_loading](https://user-images.githubusercontent.com/43761463/209121115-ed0f634b-0ec4-46b5-b030-21dbdde8cf07.gif)  

Modified `AnimatedToggleSwitch.size()`  
![animated_toggle_switch_example_5](https://user-images.githubusercontent.com/43761463/161432720-1d5fa49e-6d20-401a-9a90-a6df88873266.gif)  

`AnimatedToggleSwitch.size()` with custom rolling animation  
 ![animated_toggle_switch_example_6](https://user-images.githubusercontent.com/43761463/161432744-f60b660d-30d9-4d1d-9b87-14b62bc54e39.gif)  
  
`AnimatedToggleSwitch.rolling()` with custom `indicatorSize`, `borderRadius` and `indicatorBorderRadius`  
![animated_toggle_switch_example_7](https://user-images.githubusercontent.com/43761463/161432823-6cf3c855-2a9a-4f4a-9e5c-2951c4166f49.gif)  
![animated_toggle_switch_example_8](https://user-images.githubusercontent.com/43761463/161432826-4b0c3e57-eed7-4567-8e7e-31b8a2ba6bee.gif)  

## Easy Usage

Easy to use and highly customizable.

### Simple rolling animation

```dart
AnimatedToggleSwitch<int>.rolling(
  current: value,
  values: [0, 1, 2, 3],
  onChanged: (i) => setState(() => value = i),
  iconBuilder: iconBuilder,
  ... // many more parameters available
)
```

### Simple rolling animation with loading
To use the loading animation, you simply have to return a future in `onChanged` or `onTap`.
You can alternatively control the loading manually with the `loading` parameter.  
Hence, to disable the loading animation, `loading: false` must be set.

```dart
AnimatedToggleSwitch<int>.rolling(
  current: value,
  values: [0, 1, 2, 3],
  onChanged: (i) {
    setState(() => value = i);
    return Future.delayed(Duration(seconds: 3));
  },
  loading: false, // for deactivating loading animation
  iconBuilder: iconBuilder,
  ... // many more parameters available
)
```

### Fully customizable toggle switch with `CustomAnimatedToggleSwitch`

```dart
CustomAnimatedToggleSwitch<int>(
  current: value,
  values: [0, 1, 2, 3],
  wrapperBuilder: ..., // the builder for the wrapper around the whole switch
  iconBuilder: ..., // the builder for the icons
  foregroundIndicatorBuilder: ..., // a builder for an indicator in front of the icons
  backgroundIndicatorBuilder: ..., // a builder for an indicator behind the icons
  ... // many more parameters available
)
```

### `AnimatedToggleSwitch.size` with some settings

```dart
AnimatedToggleSwitch<int>.size(
  current: value,
  values: [0, 1, 2, 3],
  iconOpacity: 0.2,
  indicatorSize: Size.fromWidth(100),
  iconBuilder: (value, size) {
    IconData data = Icons.access_time_rounded;
    if (value.isEven) data = Icons.cancel;
    return Icon(data, size: min(size.width, size.height));
  },
  borderColor: value.isEven ? Colors.blue : Colors.red,
  colorBuilder: (i) => i.isEven ? Colors.amber : Colors.red,
  onChanged: (i) => setState(() => value = i),
)
```

### Self-made rolling animation (with `foregroundIndicatorIconBuilder`)

```dart
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
          child: iconBuilder(pos.floor(), global.indicatorSize)),
        Opacity(
          opacity: transitionValue,
          child: iconBuilder(pos.ceil(), global.indicatorSize))
      ]),
    );
  },
  selectedIconSize: Size.square(20),
  iconSize: Size.square(20),
  iconBuilder: iconBuilder,
  colorBuilder: (i) => i.isEven ? Colors.green : Colors.tealAccent,
  onChanged: (i) => setState(() => value = i),
  borderRadius: BorderRadius.circular(8.0),
  borderColor: Colors.red,
),
```
