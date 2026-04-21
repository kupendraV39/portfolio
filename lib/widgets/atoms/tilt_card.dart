import 'dart:math';
import 'package:flutter/material.dart';

/// Replaces react-parallax-tilt.
/// On mobile/touch: subtle scale on tap.
/// On desktop web: 3D tilt follows the cursor via MouseRegion.
class TiltCard extends StatefulWidget {
  const TiltCard({super.key, required this.child, this.maxAngle = 15});
  final Widget child;
  final double maxAngle; // max tilt in degrees

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0;
  double _rotateY = 0;
  double _scale = 1;

  late final AnimationController _resetCtrl;
  late Animation<double> _rotXAnim;
  late Animation<double> _rotYAnim;

  @override
  void initState() {
    super.initState();
    _resetCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _resetCtrl.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, BoxConstraints constraints) {
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;
    final dx = event.localPosition.dx - w / 2;
    final dy = event.localPosition.dy - h / 2;
    setState(() {
      _rotateY =  (dx / w) * widget.maxAngle * pi / 180;
      _rotateX = -(dy / h) * widget.maxAngle * pi / 180;
      _scale = 1.03;
    });
  }

  void _onExit() {
    // Animate back to flat
    _rotXAnim = Tween<double>(begin: _rotateX, end: 0).animate(
      CurvedAnimation(parent: _resetCtrl, curve: Curves.easeOut),
    );
    _rotYAnim = Tween<double>(begin: _rotateY, end: 0).animate(
      CurvedAnimation(parent: _resetCtrl, curve: Curves.easeOut),
    );
    _resetCtrl
      ..reset()
      ..forward().then((_) {
        if (mounted) {
          setState(() {
            _rotateX = 0;
            _rotateY = 0;
          });
        }
      });
    setState(() => _scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return MouseRegion(
        onHover: (e) => _onHover(e, constraints),
        onExit: (_) => _onExit(),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _scale = 0.97),
          onTapUp: (_) => setState(() => _scale = 1),
          onTapCancel: () => setState(() => _scale = 1),
          child: AnimatedBuilder(
            animation: _resetCtrl,
            builder: (_, child) {
              final rx = _resetCtrl.isAnimating ? _rotXAnim.value : _rotateX;
              final ry = _resetCtrl.isAnimating ? _rotYAnim.value : _rotateY;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..rotateX(rx)
                  ..rotateY(ry)
                  ..scale(_scale),
                child: child,
              );
            },
            child: widget.child,
          ),
        ),
      );
    });
  }
}
