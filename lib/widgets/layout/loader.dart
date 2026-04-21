import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';

/// Mirrors layout/Loader.tsx — shown while assets/3D models are loading.
class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 3),
              ),
              child: const CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Loading...',
              style: TextStyle(color: AppColors.secondary, fontSize: 14),
            ),
          ],
        )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(duration: 1500.ms, color: AppColors.accent.withOpacity(0.3)),
      ),
    );
  }
}
