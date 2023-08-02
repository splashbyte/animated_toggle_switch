// coverage:ignore-file
part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleCursors {
  /// [MouseCursor] to show when not hovering an indicator or a tappable icon.
  ///
  /// This defaults to [MouseCursor.defer] if [onTap] is [null]
  /// and to [SystemMouseCursors.click] otherwise.
  final MouseCursor? defaultCursor;

  /// [MouseCursor] to show when hovering an tappable icon.
  final MouseCursor tapCursor;

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
    this.tapCursor = SystemMouseCursors.click,
    this.draggingCursor = SystemMouseCursors.grabbing,
    this.dragCursor = SystemMouseCursors.grab,
    this.loadingCursor = MouseCursor.defer,
    this.inactiveCursor = SystemMouseCursors.forbidden,
  });

  const ToggleCursors.all(MouseCursor cursor)
      : defaultCursor = cursor,
        tapCursor = cursor,
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
          tapCursor == other.tapCursor &&
          draggingCursor == other.draggingCursor &&
          dragCursor == other.dragCursor &&
          loadingCursor == other.loadingCursor &&
          inactiveCursor == other.inactiveCursor;

  @override
  int get hashCode =>
      defaultCursor.hashCode ^
      tapCursor.hashCode ^
      draggingCursor.hashCode ^
      dragCursor.hashCode ^
      loadingCursor.hashCode ^
      inactiveCursor.hashCode;
}
