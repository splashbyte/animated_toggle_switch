import 'package:mocktail/mocktail.dart';

abstract class TestFunction {
  void call();
}

abstract class TestOnChangedFunction<T> {
  void call(T value);
}

class MockFunction extends Mock implements TestFunction {}

class MockOnChangedFunction<T> extends Mock
    implements TestOnChangedFunction<T> {}
