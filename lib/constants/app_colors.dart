import 'package:flutter/material.dart';

/// All colours ported from the React project's Tailwind config
/// and globals.css custom properties.
class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────
  static const Color primary   = Color(0xFF050816); // --primary (deep dark bg)
  static const Color tertiary  = Color(0xFF151030); // --tertiary (card bg)
  static const Color black100  = Color(0xFF100D25);
  static const Color black200  = Color(0xFF090325);

  // ── Text ─────────────────────────────────────────────────────
  static const Color secondary = Color(0xFFAAA6C3); // --secondary (muted text)
  static const Color white     = Color(0xFFFFFFFF);
  static const Color white100  = Color(0xFFE8E8E8); // --white-100

  // ── Accent ───────────────────────────────────────────────────
  static const Color accent    = Color(0xFF915EFF); // purple accent

  // ── Tag gradients (used on project tags) ─────────────────────
  static const Color blueGradStart  = Color(0xFF00D2FF);
  static const Color blueGradEnd    = Color(0xFF3A7BD5);
  static const Color greenGradStart = Color(0xFF00B09B);
  static const Color greenGradEnd   = Color(0xFF96C93D);
  static const Color pinkGradStart  = Color(0xFFF953C6);
  static const Color pinkGradEnd    = Color(0xFFB91D73);

  // ── Gradients ────────────────────────────────────────────────
  /// violet-gradient — the vertical line in the Hero section
  static const LinearGradient violetGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF804DEF), Color(0x00804DEF)],
  );

  /// green-pink-gradient — card border shine
  static const LinearGradient greenPinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00CEA8), Color(0xFFBF61FF)],
  );

  /// black-gradient — overlay on project image
  static const LinearGradient blackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A1A2E), Color(0x001A1A2E)],
  );

  // ── Tag gradient helpers ──────────────────────────────────────
  static const LinearGradient blueTextGradient = LinearGradient(
    colors: [blueGradStart, blueGradEnd],
  );
  static const LinearGradient greenTextGradient = LinearGradient(
    colors: [greenGradStart, greenGradEnd],
  );
  static const LinearGradient pinkTextGradient = LinearGradient(
    colors: [pinkGradStart, pinkGradEnd],
  );
}
