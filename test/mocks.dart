import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:mocktail/mocktail.dart';

abstract class TestOnTapFunction<T> {
  void call(TapProperties<T> props);
}

abstract class TestOnChangedFunction<T> {
  void call(T value);
}

abstract class TestPositionListenerFunction<T> {
  void call(PositionListenerInfo<T> positionListenerInfo);
}

class MockFunction<T> extends Mock implements TestOnTapFunction<T> {}

class MockOnChangedFunction<T> extends Mock
    implements TestOnChangedFunction<T> {}

class MockPositionListenerFunction<T> extends Mock
    implements TestPositionListenerFunction<T> {}
