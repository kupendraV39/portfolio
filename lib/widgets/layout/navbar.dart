import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_3d/widgets/sections/download_section.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_config.dart';
import '../../constants/app_data.dart';
import '../../utils/responsive.dart';

/// Mirrors layout/Navbar.tsx.
///
/// • Desktop/Tablet: horizontal nav links
/// • Mobile: hamburger → drawer
/// • Scrolled: solid background; transparent at top
class AppNavbar extends StatefulWidget {
  const AppNavbar({
    super.key,
    required this.scrollController,
    required this.onNavTap,
    this.activeSection,
  });

  final ScrollController scrollController;
  final void Function(int index) onNavTap;
  final String? activeSection;

  @override
  State<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends State<AppNavbar> {
  bool _scrolled = false;
  bool _menuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 100;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  // Map nav link id to section index (0-based, matching HomeScreen list)
  int _indexForId(String id) {
    switch (id) {
      case 'about':
        return 1;
      case 'work':
        return 4;
      case 'contact':
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final ph = Responsive.paddingH(context);

    return Stack(
      children: [
        // 🔹 Navbar
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          color: _scrolled ? AppColors.primary : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: ph, vertical: 16),
          child: Row(
            children: [
              // Logo
              GestureDetector(
                onTap: () {
                  widget.scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      AppConfig.title,
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Desktop nav
              if (!isMobile)
                Row(
                  children: navLinks.map((nav) {
                    final isActive = widget.activeSection == nav.id;

                    return Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: GestureDetector(
                        onTap: () {
                          if (nav.id == 'download') {
                            downloadResume(context);
                          } else {
                            widget.onNavTap(_indexForId(nav.id));
                          }
                        },
                        child: Text(
                          nav.title,
                          style: GoogleFonts.poppins(
                            color: isActive
                                ? AppColors.white
                                : AppColors.secondary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              // Mobile hamburger
              if (isMobile)
                GestureDetector(
                  onTap: () => setState(() => _menuOpen = !_menuOpen),
                  child: Icon(
                    _menuOpen ? Icons.close : Icons.menu,
                    color: AppColors.white,
                    size: 28,
                  ),
                ),
            ],
          ),
        ),

        // ✅ THIS LINE WAS MISSING
        if (isMobile && _menuOpen)
          Positioned.fill(
            child: MobileNavMenu(
              activeSection: widget.activeSection,
              onNavTap: widget.onNavTap,
              onClose: () => setState(() => _menuOpen = false),
            ),
          ),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }
}

class MobileNavMenu extends StatelessWidget {
  const MobileNavMenu({
    super.key,
    required this.activeSection,
    required this.onNavTap,
    required this.onClose,
  });

  final String? activeSection;
  final void Function(int) onNavTap;
  final VoidCallback onClose;

  int _indexForId(String id) {
    switch (id) {
      case 'about':
        return 1;
      case 'work':
        return 4;
      case 'contact':
        return 6;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔲 Overlay background
        GestureDetector(
          onTap: onClose,
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),

        // 👉 Sliding drawer
        Align(
          alignment: Alignment.centerRight,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 1, end: 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(300 * value, 0),
                child: child,
              );
            },
            child: Container(
              width: 260,
              height: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: navLinks.map((nav) {
                  final isActive = activeSection == nav.id;

                  return GestureDetector(
                    onTap: () {
                      if (nav.id == 'download') {
                        downloadResume(context);
                      } else {
                        onNavTap(_indexForId(nav.id));
                      }
                      onClose();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        nav.title,
                        style: GoogleFonts.poppins(
                          color: isActive ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Mobile dropdown menu (shown when hamburger is open)
// class MobileNavMenu extends StatelessWidget {
//   const MobileNavMenu({
//     super.key,
//     required this.activeSection,
//     required this.onNavTap,
//     required this.onClose,
//     required this.paddingH,
//   });

//   final String? activeSection;
//   final void Function(int) onNavTap;
//   final VoidCallback onClose;
//   final double paddingH;

//   int _indexForId(String id) {
//     switch (id) {
//       case 'about':
//         return 1;
//       case 'work':
//         return 3;
//       case 'contact':
//         return 6;
//       default:
//         return 0;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 70,
//       right: paddingH,
//       child: Container(
//         constraints: const BoxConstraints(minWidth: 140),
//         decoration: BoxDecoration(
//           color: AppColors.black100,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: navLinks.map((nav) {
//             final isActive = activeSection == nav.id;
//             return GestureDetector(
//               // onTap: () {
//               //   onNavTap(_indexForId(nav.id));
//               //   onClose();
//               // },
//               onTap: () {
//                 if (nav.id == 'download') {
//                   downloadResume(context);
//                 } else {
//                   onNavTap(_indexForId(nav.id));
//                 }
//                 onClose();
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Text(
//                   nav.title,
//                   style: GoogleFonts.poppins(
//                     color: isActive ? AppColors.white : AppColors.secondary,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       )
//           .animate()
//           .fadeIn(duration: 200.ms)
//           .slideY(begin: -0.1, duration: 200.ms),
//     );
//   }
// }
