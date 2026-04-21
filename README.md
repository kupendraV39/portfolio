# 3D Portfolio — Flutter

A fully responsive Flutter port of the React 18 + Three.js 3D Portfolio.  
Runs on **Mobile (iOS/Android)**, **Tablet**, and **Web** from a single codebase.

## Project Structure

```
lib/
  main.dart                   # Entry point
  app.dart                    # MaterialApp + go_router
  constants/
    app_colors.dart           # All colours (ported from Tailwind config)
    app_theme.dart            # ThemeData + text styles
    app_config.dart           # Personal info (name, email, title)
    app_data.dart             # All portfolio data (nav, services, experiences…)
  models/                     # Dart data classes (Service, Experience, Project…)
  utils/
    responsive.dart           # Breakpoint helpers (mobile/tablet/desktop)
    animations.dart           # flutter_animate effect builders
  screens/
    home_screen.dart          # Single-page scroll layout
  widgets/
    layout/
      navbar.dart             # Responsive navbar + mobile hamburger menu
      loader.dart             # Loading spinner
    sections/
      hero_section.dart       # Full-screen hero with 3D computer + scroll indicator
      about_section.dart      # Overview + tilt service cards
      experience_section.dart # Vertical timeline
      tech_section.dart       # Rotating tech icon grid
      works_section.dart      # Project cards grid with GitHub overlay
      feedbacks_section.dart  # Testimonials with overlapping layout
      contact_section.dart    # Contact form + 3D Earth
    atoms/
      section_header.dart     # Subtitle + heading (used on every section)
      tilt_card.dart          # 3D tilt effect (replaces react-parallax-tilt)
      gradient_text.dart      # ShaderMask gradient text (for project tags)
    canvas/
      stars_background.dart   # Twinkling star particles (CustomPainter)
      computer_3d.dart        # Desktop PC GLTF model (model_viewer_plus)
      earth_3d.dart           # Rotating Earth GLTF (model_viewer_plus)
assets/
  images/                     # All PNG images from the React project
  images/tech/                # Tech stack icons
  images/company/             # Company logos
  models/desktop_pc/          # GLTF 3D model of desktop PC
  models/planet/              # GLTF 3D model of Earth
```

## Breakpoints

| Breakpoint | Width         | Tailwind Equiv | Behaviour                      |
|------------|---------------|----------------|--------------------------------|
| Mobile     | < 640px       | default        | Hamburger nav, single column   |
| Tablet     | 640–1279px    | sm / md        | Full nav, 2-col cards          |
| Desktop    | ≥ 1280px      | xl             | Full layout, alternating 3D    |

## Setup

### 1. Install Flutter
Follow https://docs.flutter.dev/get-started/install

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Configure EmailJS (Contact form)
Edit `.env` in the project root:
```
EMAILJS_SERVICE_ID=your_service_id
EMAILJS_TEMPLATE_ID=your_template_id
EMAILJS_PUBLIC_KEY=your_public_key
```
Get your keys at https://www.emailjs.com/

### 4. Personalise your info
Edit `lib/constants/app_config.dart` with your name, email and bio.  
Edit `lib/constants/app_data.dart` with your real work experience and projects.

## Running

```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios

# Release web build
flutter build web --release
```

## Key Packages

| Package | Purpose | Replaces |
|---------|---------|---------|
| `model_viewer_plus` | GLTF 3D models | Three.js |
| `flutter_animate` | Scroll animations | framer-motion |
| `go_router` | Web URL routing | react-router-dom |
| `responsive_framework` | Breakpoints | Tailwind sm/md/xl |
| `scrollable_positioned_list` | Scroll-to-section | anchor `#id` links |
| `flutter_svg` | SVG icons (threejs.svg etc.) | native browser SVG |
| `google_fonts` | Poppins font | Tailwind font-poppins |
| `visibility_detector` | Scroll-triggered animations | Intersection Observer |

## Notes

- On **mobile**, the 3D hero computer is replaced with a gradient placeholder for performance
- The Three.js star canvas is replicated with Flutter's `CustomPainter`
- Tilt card effect works with mouse on web and tap on mobile/tablet
- All assets (images + GLTF models) are bundled inside the app
