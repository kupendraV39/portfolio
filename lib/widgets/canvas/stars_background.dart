import 'dart:math';
import 'package:flutter/material.dart';

/// Replicates StarsCanvas from Three.js using Flutter's CustomPainter.
/// Renders randomly placed, twinkling star particles on a dark background.
class StarsBackground extends StatefulWidget {
  const StarsBackground({super.key, this.child});
  final Widget? child;

  @override
  State<StarsBackground> createState() => _StarsBackgroundState();
}

class _StarsBackgroundState extends State<StarsBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_Star> _stars;

  @override
  void initState() {
    super.initState();
    final rng = Random(42); // fixed seed → consistent layout
    _stars = List.generate(200, (_) => _Star(rng));

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) => CustomPaint(
                painter: _StarsPainter(_stars, _ctrl.value),
              ),
            ),
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}

class _Star {
  _Star(Random rng)
      : x = rng.nextDouble(),
        y = rng.nextDouble(),
        radius = rng.nextDouble() * 1.5 + 0.3,
        phase = rng.nextDouble() * 2 * pi,
        brightness = rng.nextDouble() * 0.7 + 0.3;

  final double x;
  final double y;
  final double radius;
  final double phase;
  final double brightness;
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter(this.stars, this.animValue);
  final List<_Star> stars;
  final double animValue;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    for (final star in stars) {
      final opacity =
          ((sin(animValue * pi * 2 + star.phase) + 1) / 2) * star.brightness;
      // ignore: deprecated_member_use
      paint.color = Colors.white.withOpacity(opacity.clamp(0.1, 1.0));
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => old.animValue != animValue;
}
