// coverage:ignore-file
part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleCursors {
  /// [MouseCursor] to show when not hovering an indicator.
  ///
  /// Defaults to [SystemMouseCursors.click] if [iconsTappable] is [true]
  /// and to [MouseCursor.defer] otherwise.
  final MouseCursor? defaultCursor;

  /// [MouseCursor] to show when grabbing the indicators.
  final MouseCursor draggingCursor;

  /// [MouseCursor] to show when hovering the indicators.
  final MouseCursor dragCursor;

  /// [MouseCursor] to show during loading.
  final MouseCursor loadingCursor;

  /// [MouseCursor] to show when [active] is set to [false].
  final MouseCursor inactiveCursor;

  const ToggleCursors({
    this.defaultCursor,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.inactiveCursor = SystemMouseCursors.forbidden,
  });

  const ToggleCursors.all(MouseCursor cursor)
      : defaultCursor = cursor,
        draggingCursor = cursor,
        dragCursor = cursor,
        loadingCursor = cursor,
        inactiveCursor = cursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToggleCursors &&
          runtimeType == other.runtimeType &&
          defaultCursor == other.defaultCursor &&
          draggingCursor == other.draggingCursor &&
          dragCursor == other.dragCursor &&
          loadingCursor == other.loadingCursor &&
          inactiveCursor == other.inactiveCursor;

  @override
  int get hashCode =>
      defaultCursor.hashCode ^
      draggingCursor.hashCode ^
      dragCursor.hashCode ^
      loadingCursor.hashCode ^
      inactiveCursor.hashCode;
}
