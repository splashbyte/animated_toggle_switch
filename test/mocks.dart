import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:mocktail/mocktail.dart';

abstract class TestOnTapFunction<T> {
  void call(TapInfo<T> info);
}

abstract class TestOnChangedFunction<T> {
  void call(T value);
}

class MockFunction<T> extends Mock implements TestOnTapFunction<T> {}

class MockOnChangedFunction<T> extends Mock
    implements TestOnChangedFunction<T> {}
