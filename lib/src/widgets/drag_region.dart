part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class _HoverRegion extends StatefulWidget {
  final MouseCursor? cursor;
  final MouseCursor hoverCursor;
  final Widget child;
  final bool Function(Offset offset) hoverCheck;
  final MouseCursor defaultCursor;

  const _HoverRegion({
    Key? key,
    this.cursor,
    required this.hoverCursor,
    required this.child,
    this.hoverCheck = _defaultHoverCheck,
    this.defaultCursor = MouseCursor.defer,
  }) : super(key: key);

  static bool _defaultHoverCheck(Offset offset) => true;

  @override
  State<_HoverRegion> createState() => _HoverRegionState();
}

class _HoverRegionState extends State<_HoverRegion> {
  bool _hovering = false;
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    if (_position != null) _updateHovering(_position!, rebuild: false);
    // Listener is necessary because MouseRegion.onHover only gets triggered
    // without buttons pressed
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerHover: _updatePointer,
      onPointerMove: _updatePointer,
      child: GestureDetector(
        child: MouseRegion(
          opaque: false,
          cursor: widget.cursor ??
              (_hovering ? widget.hoverCursor : widget.defaultCursor),
          onExit: (e) => _setHovering(false),
          child: widget.child,
        ),
      ),
    );
  }

  void _updatePointer(PointerEvent event, {bool rebuild = true}) {
    _updateHovering(event.localPosition, rebuild: rebuild);
  }

  void _updateHovering(Offset offset, {bool rebuild = true}) {
    _setHovering(widget.hoverCheck(_position = offset), rebuild: rebuild);
  }

  void _setHovering(bool hovering, {bool rebuild = true}) {
    if (hovering == _hovering) return;
    _hovering = hovering;
    if (rebuild) setState(() {});
  }
}

class DragRegion extends StatelessWidget {
  final bool dragging;
  final Widget child;
  final bool Function(Offset offset) hoverCheck;
  final MouseCursor defaultCursor;
  final MouseCursor dragCursor;
  final MouseCursor draggingCursor;

  const DragRegion({
    Key? key,
    this.dragging = false,
    required this.child,
    this.hoverCheck = _HoverRegion._defaultHoverCheck,
    this.defaultCursor = MouseCursor.defer,
    this.dragCursor = SystemMouseCursors.grab,
    this.draggingCursor = SystemMouseCursors.grabbing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _HoverRegion(
      cursor: dragging ? draggingCursor : null,
      hoverCursor: dragCursor,
      child: child,
      hoverCheck: hoverCheck,
      defaultCursor: defaultCursor,
    );
  }
}
