part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class _HoverRegion extends StatefulWidget {
  final Widget child;
  final MouseCursor? Function(Offset offset) cursorByOffset;
  final MouseCursor defaultCursor;

  const _HoverRegion({
    Key? key,
    required this.child,
    required this.cursorByOffset,
    this.defaultCursor = MouseCursor.defer,
  }) : super(key: key);

  @override
  State<_HoverRegion> createState() => _HoverRegionState();
}

class _HoverRegionState extends State<_HoverRegion> {
  Offset? _position;
  MouseCursor? _cursor;

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
          hitTestBehavior: HitTestBehavior.translucent,
          cursor: _cursor ?? widget.defaultCursor,
          onExit: (e) => _setCursor(null),
          child: widget.child,
        ),
      ),
    );
  }

  void _updatePointer(PointerEvent event, {bool rebuild = true}) {
    _updateHovering(event.localPosition, rebuild: rebuild);
  }

  void _updateHovering(Offset offset, {bool rebuild = true}) {
    _setCursor(widget.cursorByOffset(_position = offset), rebuild: rebuild);
  }

  void _setCursor(MouseCursor? cursor, {bool rebuild = true}) {
    if (_cursor == cursor) return;
    _cursor = cursor;
    if (rebuild) setState(() {});
  }
}
