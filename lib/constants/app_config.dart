/// Mirrors constants/config.ts from the React project.
/// Edit this file to personalise the portfolio.
class AppConfig {
  AppConfig._();

  // ── Personal info ─────────────────────────────────────────────
  static const String title = 'kupendra Portfolio';
  static const String fullName = 'Kupendra';
  static const String email = 'kupendrav34@mail.com';

  // ── Hero ─────────────────────────────────────────────────────
  static const String heroName = 'kupendra';
  static const List<String> heroSubtitle = [
    'Full-Stack Software Engineer',
    'Flutter & Spring Boot Developer',
    'Building scalable apps and APIs',
  ];

  // ── Section headers ───────────────────────────────────────────
  static const String aboutSub = 'Introduction';
  static const String aboutHead = 'Overview.';
  static const String aboutBody =
      "I'm a full-stack developer specializing in Flutter for frontend and "
      "Spring Boot for backend development. I build scalable mobile "
      "applications with secure REST APIs and integrate services like Firebase "
      "and AI-based features using Spring AI. I enjoy designing clean "
      "architectures and solving real-world problems through efficient systems.";

  static const String experienceSub = 'What I have done so far';
  static const String experienceHead = 'Experience.';

  static const String feedbacksSub = 'What others say';
  static const String feedbacksHead = 'Testimonials.';

  static const String worksSub = 'My work';
  static const String worksHead = 'Projects.';
  static const String worksBody =
      "These projects highlight my experience in building full-stack "
      "applications using Flutter and Spring Boot. They include real-time apps, "
      "REST API integrations, and AI-powered features. Each project reflects my "
      "ability to design, develop, and deploy scalable solutions.";
  static const String contactSub = 'Get in touch';
  static const String contactHead = 'Contact.';

  // ── Contact form labels ───────────────────────────────────────
  static const String contactNameLabel = 'Your Name';
  static const String contactNamePlaceholder = "What's your name?";
  static const String contactEmailLabel = 'Your Email';
  static const String contactEmailPlaceholder = "What's your email?";
  static const String contactMsgLabel = 'Your Message';
  static const String contactMsgPlaceholder = 'What do you want to say?';
}
