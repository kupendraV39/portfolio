import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../constants/app_data.dart';
import '../../models/experience.dart';
import '../../utils/responsive.dart';
import '../atoms/section_header.dart';

/// Mirrors sections/Experience.tsx — vertical timeline layout.
class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            subtitle: AppConfig.experienceSub,
            title: AppConfig.experienceHead,
          ),
          const SizedBox(height: 60),
          _Timeline(experiences: experiences, visible: _visible),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.experiences, required this.visible});
  final List<Experience> experiences;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      children: experiences.asMap().entries.map((entry) {
        final i = entry.key;
        final exp = entry.value;
        final isLeft = i.isEven;

        return _TimelineItem(
          experience: exp,
          index: i,
          visible: visible,
          isLeft: isDesktop ? isLeft : true, // mobile/tablet → single column
          isLast: i == experiences.length - 1,
        );
      }).toList(),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.experience,
    required this.index,
    required this.visible,
    required this.isLeft,
    required this.isLast,
  });

  final Experience experience;
  final int index;
  final bool visible;
  final bool isLeft;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final card = _ExperienceCard(experience: experience);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side (card or spacer on desktop)
          if (isDesktop)
            Expanded(
              child: isLeft
                  ? card
                      .animate(target: visible ? 1 : 0)
                      .fadeIn(
                        delay: Duration(milliseconds: index * 200),
                        duration: 600.ms,
                      )
                      .slideX(
                        begin: -0.3,
                        delay: Duration(milliseconds: index * 200),
                        duration: 600.ms,
                      )
                  : const SizedBox(),
            ),

          // Centre vertical line + icon
          Column(
            children: [
              // Icon circle
              Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: experience.iconBg,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  experience.icon,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.work,
                    color: AppColors.white,
                  ),
                ),
              ),
              // Vertical line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.secondary.withOpacity(0.3),
                  ),
                ),
            ],
          ),

          // Right side (card or spacer on desktop; always card on mobile)
          Expanded(
            child: (!isDesktop || !isLeft)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: card
                        .animate(target: visible ? 1 : 0)
                        .fadeIn(
                          delay: Duration(milliseconds: index * 200),
                          duration: 600.ms,
                        )
                        .slideX(
                          begin: 0.3,
                          delay: Duration(milliseconds: index * 200),
                          duration: 600.ms,
                        ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience});
  final Experience experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1d1836),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            experience.title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            experience.companyName,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            experience.date,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          ...experience.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7, right: 8),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white100,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.white100,
                        height: 1.6,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
