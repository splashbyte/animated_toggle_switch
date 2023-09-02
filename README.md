# AnimatedToggleSwitch

[![pub.dev](https://img.shields.io/pub/v/animated_toggle_switch.svg?style=flat?logo=dart)](https://pub.dev/packages/animated_toggle_switch)
[![github](https://img.shields.io/static/v1?label=platform&message=flutter&color=1ebbfd)](https://github.com/SplashByte/animated_toggle_switch)
[![likes](https://img.shields.io/pub/likes/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![popularity](https://img.shields.io/pub/popularity/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![pub points](https://img.shields.io/pub/points/animated_toggle_switch)](https://pub.dev/packages/animated_toggle_switch/score)
[![license](https://img.shields.io/github/license/SplashByte/animated_toggle_switch.svg)](https://github.com/SplashByte/animated_toggle_switch/blob/main/LICENSE)
[![codecov](https://codecov.io/gh/splashbyte/animated_toggle_switch/branch/main/graph/badge.svg?token=NY1D6W88H2)](https://codecov.io/gh/splashbyte/animated_toggle_switch)

[![buy me a coffee](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20pizza&emoji=🍕&slug=splashbyte&button_colour=FF8838&font_colour=ffffff&font_family=Poppins&outline_colour=000000&coffee_colour=ffffff')](https://www.buymeacoffee.com/splashbyte)

### If you like this package, please like it on [pub.dev](https://pub.dev/packages/animated_toggle_switch) and star it on [GitHub](https://github.com/SplashByte/animated_toggle_switch).

Fully customizable, draggable and animated switch with multiple choices and [smooth loading animation](#loading-animation). It has prebuilt constructors for rolling and size animations, but it also allows you to create your own switches with `CustomAnimatedToggleSwitch`.  
`LTR` and `RTL` are both supported.  
[Switches without an (initial) selection](#nullable-selection) are also possible.  
Most builder arguments of `AnimatedToggleSwitch` have a standard and a custom version. This ensures that you can get started easily and still customize a lot if necessary. There are several options for [styling](#styling) it.

For a slider with a similar look you can check out [action_slider](https://pub.dev/packages/action_slider).

## Example Usage
![usage](https://user-images.githubusercontent.com/43761463/114942384-c1200d00-9e44-11eb-9904-3cb1d7296da4.gif)

## Examples
`AnimatedToggleSwitch.dual()`  
![animated_toggle_switch_example_dual](https://user-images.githubusercontent.com/43761463/161432631-e6dd3d16-7b64-410b-a9fa-c956d3442598.gif)
![animated_toggle_switch_example_borderradius_builder](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/ee615f64-d897-43f1-b508-0318805195e4)
![animated_toggle_switch_example_gradient](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/b0d390fc-cd18-45ad-b2ce-61e453f098ad)

Switch inspired by [lite_rolling_switch](https://pub.dev/packages/lite_rolling_switch) (made with `AnimatedToggleSwitch.dual()`)  
![animated_toggle_switch_example_lite_rolling_switch](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/34751d16-cbb1-42b5-a14d-6bd3340d676a)

Switch inspired by [toggle_switch](https://pub.dev/packages/toggle_switch) (made with `AnimatedToggleSwitch.size()`)  
![animated_toggle_switch_example_toggle_switch](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/884c8433-3b11-4fe1-b2a8-c02599c56aee)

Switch inspired by [crazy-switch](https://github.com/pedromassango/crazy-switch) (made with `CustomAnimatedToggleSwitch()`)  
![animated_toggle_switch_example_crazy_switch](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/106afaf5-88a0-4d4b-ad59-2b22182d18be)

`AnimatedToggleSwitch.rolling()`  
![animated_toggle_switch_example_1](https://user-images.githubusercontent.com/43761463/161432579-9fe81c57-6463-45c3-a48f-75db666a3a22.gif)
![animated_toggle_switch_example_2](https://user-images.githubusercontent.com/43761463/161432589-d76f61f6-cb97-42e2-b1fd-8c5203a965fa.gif)
![animated_toggle_switch_example_gradient](https://user-images.githubusercontent.com/43761463/209117203-90a41ddc-db1c-41be-8375-5304317d1352.gif)
![animated_toggle_switch_example_borderradius_builder_2](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/e9a6328e-fc6a-4080-9868-1f0eaf60f6db)
![animated_toggle_switch_example_rolling_separator](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/562fa54d-6a03-4099-a61b-0bc386d22adb)


You can build any other switch with `CustomAnimatedToggleSwitch()`  
![animated_toggle_switch_example_custom_1](https://user-images.githubusercontent.com/43761463/161433015-c3ec634a-38da-463d-a06e-4ae0b29f77ed.gif)  

`AnimatedToggleSwitch.size()`  
![animated_toggle_switch_example_size](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/805a0e3f-b3a2-4801-baf9-7a5509905452)
![animated_toggle_switch_example_size_2](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/ed2c1e50-1012-41ef-8218-71c1144e514b)

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
  style: ToggleStyle(...), // optional style settings
  ... // many more parameters available
)
```

### Styling
`style`, `styleBuilder`, `customStyleBuilder` and `styleList` can be used to style an `AnimatedToggleSwitch`.  
For the general look of the switch, you can use `style`.  
For parameters that should change with the selection, you can use `styleBuilder`.  
If you need additional parameters, you can use `customStyleBuilder`.  
```dart
AnimatedToggleSwitch<int>.rolling(
  ...
  style: ToggleStyle(backgroundColor: Colors.red), // backgroundColor is set independently of the current selection
  styleBuilder: (value) => ToggleStyle(indicatorColor: value.isEven ? Colors.yellow : Colors.green)), // indicatorColor changes and animates its value with the selection
  ...
)
```

### Loading animation
![animated_toggle_switch_example_rolling_loading](https://user-images.githubusercontent.com/43761463/209121057-2ff2bfc3-063e-4704-a981-f5cc5f54720a.gif)  
To use the loading animation, you simply have to return a `Future` in `onChanged` or `onTap`.
You can alternatively control the loading manually with the `loading` parameter.  
Hence, to disable the loading animation, `loading: false` must be set.

```dart
AnimatedToggleSwitch<int>.rolling(
  current: value,
  values: [0, 1, 2, 3],
  onChanged: (i) async {
    setState(() => value = i);
    await Future.delayed(Duration(seconds: 3));
  },
  loading: false, // for deactivating loading animation
  iconBuilder: iconBuilder,
  ... // many more parameters available
)
```

### Nullable selection
![animated_toggle_switch_example_unlisted_value](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/570f39e8-bc5c-4a19-a91a-d186d4bbd8fe)  
To use this feature, you simply have to set `allowUnlistedValues` to `true`.

```dart
AnimatedToggleSwitch<int?>.rolling(
   allowUnlistedValues: true,
   current: nullableValue, // no selection if nullableValue is not contained in values
   values: const [0, 1, 2, 3],
   onChanged: (i) => setState(() => nullableValue = i),
   iconBuilder: iconBuilder,
   indicatorAppearingBuilder: ..., // appearing animation is fully customizable (optional)
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
![animated_toggle_switch_example_size](https://github.com/splashbyte/animated_toggle_switch/assets/43761463/805a0e3f-b3a2-4801-baf9-7a5509905452)  
```dart
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
  styleBuilder: (i) => ToggleStyle(indicatorColor: colorBuilder(i)),
  onChanged: (i) => setState(() => value = i),
)
```

### Self-made rolling animation (with `foregroundIndicatorIconBuilder`)
![animated_toggle_switch_example_6](https://user-images.githubusercontent.com/43761463/161432744-f60b660d-30d9-4d1d-9b87-14b62bc54e39.gif)  
```dart
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
          child: iconBuilder(pos.floor(), global.indicatorSize)),
        Opacity(
          opacity: transitionValue,
          child: iconBuilder(pos.ceil(), global.indicatorSize))
        ]));
  },
  iconBuilder: iconBuilder,
  style: ToggleStyle(
    borderColor: Colors.red,
    borderRadius: BorderRadius.circular(8.0),
    indicatorBorderRadius: BorderRadius.zero,
  ),
  styleBuilder: (i) => ToggleStyle(indicatorColor: i.isEven == true ? Colors.green : Colors.tealAccent),
  onChanged: (i) => setState(() => value = i),
)
```
