import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../constants/app_data.dart';
import '../../models/service.dart';
import '../../utils/responsive.dart';
import '../atoms/section_header.dart';
import '../atoms/tilt_card.dart';

/// Mirrors sections/About.tsx
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            subtitle: AppConfig.aboutSub,
            title: AppConfig.aboutHead,
          ),
          const SizedBox(height: 16),
          Text(
            AppConfig.aboutBody,
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: AppColors.secondary,
              height: 1.8,
            ),
          ).animate(target: _visible ? 1 : 0).fadeIn(duration: 800.ms),

          const SizedBox(height: 80),

          // Service cards grid
          _ServiceGrid(visible: _visible),
        ],
      ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  const _ServiceGrid({required this.visible});
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final count = Responsive.serviceGridCount(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.85,
      ),
      itemCount: services.length,
      itemBuilder: (_, i) => _ServiceCard(
        service: services[i],
        index: i,
        visible: visible,
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    required this.service,
    required this.index,
    required this.visible,
  });

  final Service service;
  final int index;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00CEA8), Color(0xFFBF61FF)],
          ),
        ),
        padding: const EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                service.icon,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.code,
                  color: AppColors.accent,
                  size: 64,
                ),
              ),
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(target: visible ? 1 : 0)
        .fadeIn(delay: Duration(milliseconds: index * 150), duration: 600.ms)
        .slideX(
          begin: -0.2,
          delay: Duration(milliseconds: index * 150),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}
