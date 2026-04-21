import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reusable animation builders — mirrors src/utils/motion.ts (framer-motion variants).
///
/// Usage:
///   child.animate().fadeIn(duration: 600.ms).slideX(begin: -0.3)
///
/// All helpers below return [List<Effect>] that can be passed to
/// widget.animate(effects: AppAnimations.fadeInRight(index: 0))
class AppAnimations {
  AppAnimations._();

  /// Mirrors: fadeIn('right', 'spring', index * 0.5, 0.75)
  static List<Effect> fadeInRight({int index = 0}) => [
        FadeEffect(
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
        ),
        SlideEffect(
          begin: const Offset(-0.3, 0),
          end: Offset.zero,
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
          curve: Curves.easeOutBack,
        ),
      ];

  /// Mirrors: fadeIn('left', 'spring', index * 0.5, 0.75)
  static List<Effect> fadeInLeft({int index = 0}) => [
        FadeEffect(
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
        ),
        SlideEffect(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
          curve: Curves.easeOutBack,
        ),
      ];

  /// Mirrors: fadeIn('up', 'spring', index * 0.5, 0.75)
  static List<Effect> fadeInUp({int index = 0}) => [
        FadeEffect(
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
        ),
        SlideEffect(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
          delay: Duration(milliseconds: (index * 500)),
          duration: 750.ms,
          curve: Curves.easeOutBack,
        ),
      ];

  /// Mirrors: slideIn('left', 'tween', 0.2, 1)
  static List<Effect> slideInLeft({double delaySeconds = 0.2}) => [
        FadeEffect(
          delay: Duration(milliseconds: (delaySeconds * 1000).toInt()),
          duration: 1000.ms,
        ),
        SlideEffect(
          begin: const Offset(-1, 0),
          end: Offset.zero,
          delay: Duration(milliseconds: (delaySeconds * 1000).toInt()),
          duration: 1000.ms,
          curve: Curves.easeInOut,
        ),
      ];

  /// Mirrors: slideIn('right', 'tween', 0.2, 1)
  static List<Effect> slideInRight({double delaySeconds = 0.2}) => [
        FadeEffect(
          delay: Duration(milliseconds: (delaySeconds * 1000).toInt()),
          duration: 1000.ms,
        ),
        SlideEffect(
          begin: const Offset(1, 0),
          end: Offset.zero,
          delay: Duration(milliseconds: (delaySeconds * 1000).toInt()),
          duration: 1000.ms,
          curve: Curves.easeInOut,
        ),
      ];

  /// Section entry — used by SectionWrapper equivalent
  static List<Effect> sectionEntry = [
    FadeEffect(duration: 600.ms),
    SlideEffect(begin: const Offset(0, 0.1), end: Offset.zero, duration: 600.ms),
  ];
}
