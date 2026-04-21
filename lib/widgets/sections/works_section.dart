import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../constants/app_data.dart';
import '../../models/project.dart';
import '../../utils/responsive.dart';
import '../atoms/section_header.dart';
import '../atoms/tilt_card.dart';
import '../atoms/gradient_text.dart';

/// Mirrors sections/Works.tsx
class WorksSection extends StatefulWidget {
  const WorksSection({super.key});

  @override
  State<WorksSection> createState() => _WorksSectionState();
}

class _WorksSectionState extends State<WorksSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final count = Responsive.projectGridCount(context);
    return VisibilityDetector(
      key: const Key('works-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            subtitle: AppConfig.worksSub,
            title: AppConfig.worksHead,
          ),
          const SizedBox(height: 16),
          Text(
            AppConfig.worksBody,
            style: GoogleFonts.poppins(
              fontSize: 17,
              color: AppColors.secondary,
              height: 1.8,
            ),
          ).animate(target: _visible ? 1 : 0).fadeIn(duration: 600.ms),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: count,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.72,
            ),
            itemCount: projects.length,
            itemBuilder: (_, i) => _ProjectCard(
              project: projects[i],
              index: i,
              visible: _visible,
            ),
          ),
        ],
      ),
    );
  }
}
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.visible,
  });

  final Project project;
  final int index;
  final bool visible;

  Gradient _tagGradient(String colorType) {
    switch (colorType) {
      case 'green':
        return AppColors.greenTextGradient;
      case 'pink':
        return AppColors.pinkTextGradient;
      default:
        return AppColors.blueTextGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ FIX 1: Give FIXED HEIGHT instead of Expanded
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      project.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.black100,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// GitHub button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () =>
                          launchUrl(Uri.parse(project.sourceCodeLink)),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/github.png',
                            width: 20,
                            height: 20,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.code,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ✅ FIX 2: Remove Expanded here also
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// ✅ FIX 3: No Expanded → use normal Text
                  Text(
                    project.description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.secondary,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: project.tags.map((tag) {
                      return GradientText(
                        '#${tag.name}',
                        gradient: _tagGradient(tag.colorType),
                        style: GoogleFonts.poppins(fontSize: 13),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate(target: visible ? 1 : 0)
        .fadeIn(
          delay: Duration(milliseconds: index * 150),
          duration: 600.ms,
        )
        .slideY(
          begin: 0.3,
          delay: Duration(milliseconds: index * 150),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}

// class _ProjectCard extends StatelessWidget {
//   const _ProjectCard({
//     required this.project,
//     required this.index,
//     required this.visible,
//   });

//   final Project project;
//   final int index;
//   final bool visible;

//   Gradient _tagGradient(String colorType) {
//     switch (colorType) {
//       case 'green':
//         return AppColors.greenTextGradient;
//       case 'pink':
//         return AppColors.pinkTextGradient;
//       default:
//         return AppColors.blueTextGradient;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TiltCard(
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.tertiary,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image + GitHub overlay
//             Expanded(
//               flex: 5,
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.asset(
//                       project.image,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         color: AppColors.black100,
//                         child: const Icon(
//                           Icons.image_not_supported,
//                           color: AppColors.secondary,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // GitHub button
//                   Positioned(
//                     top: 12,
//                     right: 12,
//                     child: GestureDetector(
//                       onTap: () => launchUrl(Uri.parse(project.sourceCodeLink)),
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [
//                               Colors.black.withOpacity(0.8),
//                               Colors.transparent,
//                             ],
//                           ),
//                         ),
//                         child: Center(
//                           child: Image.asset(
//                             'assets/images/github.png',
//                             width: 20,
//                             height: 20,
//                             errorBuilder: (_, __, ___) => const Icon(
//                               Icons.code,
//                               color: AppColors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Info
//             Expanded(
//               flex: 4,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       project.name,
//                       style: GoogleFonts.poppins(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Expanded(
//                       child: Text(
//                         project.description,
//                         style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           color: AppColors.secondary,
//                           height: 1.5,
//                         ),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 8,
//                       children: project.tags.map((tag) {
//                         return GradientText(
//                           '#${tag.name}',
//                           gradient: _tagGradient(tag.colorType),
//                           style: GoogleFonts.poppins(fontSize: 13),
//                         );
//                       }).toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
//         .animate(target: visible ? 1 : 0)
//         .fadeIn(
//           delay: Duration(milliseconds: index * 150),
//           duration: 600.ms,
//         )
//         .slideY(
//           begin: 0.3,
//           delay: Duration(milliseconds: index * 150),
//           duration: 600.ms,
//           curve: Curves.easeOutBack,
//         );
//   }
// }
