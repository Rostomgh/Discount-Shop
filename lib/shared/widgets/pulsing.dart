import 'package:flutter/material.dart';

/// Fades [child] in and out forever; used for loading placeholders.
class Pulsing extends StatefulWidget {
  const Pulsing({super.key, required this.child});

  final Widget child;

  @override
  State<Pulsing> createState() => _PulsingState();
}

class _PulsingState extends State<Pulsing> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
    lowerBound: 0.4,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _controller, child: widget.child);
  }
}
