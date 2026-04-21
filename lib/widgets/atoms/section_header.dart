import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../utils/responsive.dart';

/// Mirrors Header.tsx — renders the small subtitle (p) + large heading (h2)
/// used at the top of every section.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.subtitle,
    required this.title,
    this.animate = true,
  });

  final String subtitle;
  final String title;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    Widget subtitleWidget = Text(
      subtitle.toUpperCase(),
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary,
        letterSpacing: 2,
      ),
    );

    Widget titleWidget = Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: Responsive.isMobile(context) ? 30 : 60,
        fontWeight: FontWeight.w900,
        color: AppColors.white,
        height: 1.1,
      ),
    );

    if (animate) {
      subtitleWidget = subtitleWidget
          .animate()
          .fadeIn(duration: 600.ms)
          .slideX(begin: -0.2, duration: 600.ms);
      titleWidget = titleWidget
          .animate()
          .fadeIn(delay: 100.ms, duration: 600.ms)
          .slideX(begin: -0.2, delay: 100.ms, duration: 600.ms);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [subtitleWidget, const SizedBox(height: 4), titleWidget],
    );
  }
}
