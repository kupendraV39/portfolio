import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../utils/responsive.dart';
import '../canvas/computer_3d.dart';

/// Mirrors sections/Hero.tsx
class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onScrollDown});
  final VoidCallback onScrollDown;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceCtrl;
  late final Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _bounceAnim = Tween<double>(begin: 0, end: 24).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 120),

        // TEXT FIRST
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: AppColors.white,
                    height: 1.1,
                  ),
                  children: const [
                    TextSpan(text: "Hi, I'm "),
                    TextSpan(
                      text: AppConfig.heroName,
                      style: TextStyle(color: AppColors.accent),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -0.2, duration: 600.ms),
              const SizedBox(height: 10),
              Text(
                AppConfig.heroSubtitle.join('\n'),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white100,
                  height: 1.4,
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideX(begin: -0.2, delay: 200.ms, duration: 600.ms),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // 3D MODEL BELOW
        const Expanded(
          child: IgnorePointer(
            child: Computer3D(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ph = Responsive.paddingH(context);
    final isMobile = Responsive.isMobile(context);

    return SizedBox(
      height: size.height,
      child: isMobile
          ? _buildMobileLayout(context)
          : Stack(
              children: [
                // 3D BACKGROUND
                const Positioned.fill(
                  child: IgnorePointer(
                    child: Computer3D(),
                  ),
                ),

                // HERO TEXT
                Positioned(
                  top: 120,
                  left: ph,
                  right: ph,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.accent,
                            ),
                          ),
                          Container(
                            width: 4,
                            height: 320,
                            decoration: const BoxDecoration(
                              gradient: AppColors.violetGradient,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.white,
                                  height: 1.1,
                                ),
                                children: const [
                                  TextSpan(text: "Hi, I'm "),
                                  TextSpan(
                                    text: AppConfig.heroName,
                                    style: TextStyle(
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .slideX(begin: -0.2, duration: 600.ms),
                            const SizedBox(height: 8),
                            Text(
                              AppConfig.heroSubtitle.join('\n'),
                              style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white100,
                                height: 1.4,
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 200.ms, duration: 600.ms)
                                .slideX(
                                    begin: -0.2,
                                    delay: 200.ms,
                                    duration: 600.ms),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // SCROLL INDICATOR
                Positioned(
                  bottom: isMobile ? 80 : 40,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: widget.onScrollDown,
                    child: Center(
                      child: Container(
                        width: 35,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.secondary,
                            width: 4,
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.topCenter,
                        child: AnimatedBuilder(
                          animation: _bounceAnim,
                          builder: (_, __) => Transform.translate(
                            offset: Offset(0, _bounceAnim.value * 0.3),
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms, duration: 600.ms),
                ),
              ],
            ),
    );
  }
}
