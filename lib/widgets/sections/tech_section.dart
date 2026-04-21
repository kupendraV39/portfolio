import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_data.dart';
import '../../models/technology.dart';
import '../../utils/responsive.dart';

class TechSection extends StatefulWidget {
  const TechSection({super.key});

  @override
  State<TechSection> createState() => _TechSectionState();
}

class _TechSectionState extends State<TechSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Responsive.techGridCount(context);
    return VisibilityDetector(
      key: const Key('tech-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: technologies.asMap().entries.map((entry) {
          return _TechBall(
            tech: entry.value,
            index: entry.key,
            visible: _visible,
          );
        }).toList(),
      ),
    );
  }
}

class _TechBall extends StatefulWidget {
  const _TechBall({
    required this.tech,
    required this.index,
    required this.visible,
  });

  final Technology tech;
  final int index;
  final bool visible;

  @override
  State<_TechBall> createState() => _TechBallState();
}

class _TechBallState extends State<_TechBall>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spinCtrl;

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = widget.tech.icon.endsWith('.svg');

    final ball = Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          radius: 0.8,
          colors: [Color(0xFF4a2d8c), Color(0xFF1a0533)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.4),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: _spinCtrl,
        builder: (_, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_spinCtrl.value * 2 * 3.14159),
          child: child,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isSvg
              ? SvgPicture.asset(
                  widget.tech.icon,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                )
              : Image.asset(
                  widget.tech.icon,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.code,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ball
            .animate(target: widget.visible ? 1 : 0)
            .fadeIn(
              delay: Duration(milliseconds: widget.index * 80),
              duration: 500.ms,
            )
            .scale(
              begin: const Offset(0.5, 0.5),
              delay: Duration(milliseconds: widget.index * 80),
              duration: 500.ms,
              curve: Curves.easeOutBack,
            ),
        const SizedBox(height: 8),
        Text(
          widget.tech.name,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
