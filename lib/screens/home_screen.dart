import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../constants/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/canvas/stars_background.dart';
import '../widgets/layout/navbar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/tech_section.dart';
import '../widgets/sections/works_section.dart';
import '../widgets/sections/feedbacks_section.dart';
import '../widgets/sections/contact_section.dart';

/// Mirrors App.tsx — single-page scroll layout with all sections.
///
/// Section order (index):
///  0  Hero
///  1  About
///  2  Experience
///  3  Tech
///  4  Works
///  5  Feedbacks
///  6  Contact
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollController _navScrollController = ScrollController();

  String? _activeSection;
  bool _menuOpen = false;

  // Maps section index → nav link id
  static const _sectionIds = {
    0: 'hero',
    1: 'about',
    2: 'work', // experience maps to 'work' nav
    3: 'tech',
    4: 'work', // projects also in 'work'
    5: 'feedbacks',
    6: 'contact',
    7: 'download', // extra section for download link (not in design)
  };

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onPositionChange);
  }

  void _onPositionChange() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;
    // Find the item most visible at the top
    final visible = positions
        .where((p) => p.itemLeadingEdge < 0.5 && p.itemTrailingEdge > 0)
        .toList()
      ..sort((a, b) => a.itemLeadingEdge.compareTo(b.itemLeadingEdge));
    if (visible.isNotEmpty) {
      final id = _sectionIds[visible.last.index];
      if (id != null && id != _activeSection) {
        setState(() => _activeSection = id);
      }
    }
  }

  void _scrollToSection(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _navScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ph = Responsive.paddingH(context);
    final isMobile = Responsive.isMobile(context);

    // Section list with padding helpers
    final sections = <Widget>[
      // 0 — Hero (full screen, no extra padding)
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/herobg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: HeroSection(onScrollDown: () => _scrollToSection(1)),
      ),

      // 1 — About
      Padding(
        padding: Responsive.sectionPadding(context),
        child: const AboutSection(),
      ),

      // 2 — Experience
      Padding(
        padding: Responsive.sectionPadding(context),
        child: const ExperienceSection(),
      ),

      // 3 — Tech
      Padding(
        padding: Responsive.sectionPadding(context),
        child: const TechSection(),
      ),

      // 4 — Works
      Padding(
        padding: Responsive.sectionPadding(context),
        child: const WorksSection(),
      ),

      // 5 — Feedbacks
      const FeedbacksSection(),

      // 6 — Contact (dark section with stars)
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StarsBackground(
          child: Padding(
            padding: Responsive.sectionPadding(context),
            child: const ContactSection(),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // ── Main scrollable content ───────────────────────────
          ScrollablePositionedList.builder(
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            itemCount: sections.length,
            itemBuilder: (_, i) => sections[i],
          ),

          // ── Navbar (always on top) ────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavbar(
              scrollController: _navScrollController,
              onNavTap: (index) {
                _scrollToSection(index);
                if (_menuOpen) setState(() => _menuOpen = false);
              },
              activeSection: _activeSection,
            ),
          ),

          // ── Mobile dropdown menu ──────────────────────────────
          if (_menuOpen && isMobile)
            MobileNavMenu(
              activeSection: _activeSection,
              onNavTap: _scrollToSection,
              onClose: () => setState(() => _menuOpen = false),
              // paddingH: ph,
            ),
        ],
      ),
    );
  }
}
