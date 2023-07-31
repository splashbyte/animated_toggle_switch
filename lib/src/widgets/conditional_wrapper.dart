part of 'package:animated_toggle_switch/animated_toggle_switch.dart';

class _ConditionalWrapper extends StatefulWidget {
  final Widget Function(BuildContext context, Widget child) wrapper;
  final bool condition;
  final Widget child;

  const _ConditionalWrapper({
    required this.wrapper,
    required this.condition,
    required this.child,
  });

  @override
  State<_ConditionalWrapper> createState() => _ConditionalWrapperState();
}

class _ConditionalWrapperState extends State<_ConditionalWrapper> {
  final _childKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final child = _EmptyWidget(key: _childKey, child: widget.child);
    if(widget.condition) return widget.wrapper(context, child);
    return child;
  }
}

class _EmptyWidget extends StatelessWidget {
  final Widget child;

  const _EmptyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
