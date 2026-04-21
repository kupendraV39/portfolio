import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../constants/app_data.dart';
import '../../models/testimonial.dart';
import '../../utils/responsive.dart';
import '../atoms/section_header.dart';

/// Mirrors sections/Feedbacks.tsx — overlapping header + cards layout.
class FeedbacksSection extends StatefulWidget {
  const FeedbacksSection({super.key});

  @override
  State<FeedbacksSection> createState() => _FeedbacksSectionState();
}

class _FeedbacksSectionState extends State<FeedbacksSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final ph = Responsive.paddingH(context);
    final isMobile = Responsive.isMobile(context);

    return VisibilityDetector(
      key: const Key('feedbacks-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.black100,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: ph),
        child: Column(
          children: [
            // Purple header
            Container(
              decoration: BoxDecoration(
                color: AppColors.tertiary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ph,
                vertical: isMobile ? 40 : 60,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: SectionHeader(
                  subtitle: AppConfig.feedbacksSub,
                  title: AppConfig.feedbacksHead,
                ),
              ),
            ),

            // Cards (overlapping the header)
            Transform.translate(
              offset: const Offset(0, -60),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ph),
                child: isMobile
                    ? Column(
                        children: _buildCards(),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildCards()
                              .map((c) => Padding(
                                    padding: const EdgeInsets.only(right: 28),
                                    child: c,
                                  ))
                              .toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCards() {
    return testimonials.asMap().entries.map((entry) {
      return _FeedbackCard(
        testimonial: entry.value,
        index: entry.key,
        visible: _visible,
      );
    }).toList();
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({
    required this.testimonial,
    required this.index,
    required this.visible,
  });

  final Testimonial testimonial;
  final int index;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: isMobile ? double.infinity : 320,
      margin: EdgeInsets.only(bottom: isMobile ? 24 : 0),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.black200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"',
            style: GoogleFonts.poppins(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            testimonial.testimonial,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: AppColors.white,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (b) =>
                              AppColors.blueTextGradient.createShader(b),
                          child: Text(
                            '@ ',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          testimonial.name,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${testimonial.designation} of ${testimonial.company}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(testimonial.image),
                onBackgroundImageError: (_, __) {},
                backgroundColor: AppColors.tertiary,
              ),
            ],
          ),
        ],
      ),
    )
        .animate(target: visible ? 1 : 0)
        .fadeIn(
          delay: Duration(milliseconds: index * 200),
          duration: 700.ms,
        )
        .slideY(
          begin: 0.2,
          delay: Duration(milliseconds: index * 200),
          duration: 700.ms,
          curve: Curves.easeOutBack,
        );
  }
}
