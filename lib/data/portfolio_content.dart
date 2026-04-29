/// Personalize your site by editing this file.
library;

class PortfolioContent {
  PortfolioContent._();

  static const String name = 'Franklin Anyaya';
  static const String headline = 'Full-Stack Flutter Developer';
  static const String profileImageAsset = 'assets/profile_photo.jpg';
  static const String profileImageRedEyesAsset =
      'assets/profile_photo_red_eyes.png';
  static const String tagline =
      'I build modern, scalable cross-platform apps with Flutter and Firebase\u2014'
      'from e-commerce platforms to booking systems with admin dashboards. '
      'Let\'s turn your idea into a polished product.';

  static const String aboutTitle = 'About';
  static const String aboutBody =
      "I'm Franklin Anyaya, a Flutter developer focused on shipping products end to end: "
      'layout and motion, state management, API integration, and deployment to web and stores. '
      'I care about maintainable code, accessible interfaces, and apps that feel fast and intentional.';

  static const String projectsTitle = 'Featured Projects';

  static const String servicesTitle = 'Services';
  static const List<Service> services = [
    Service(
      title: 'Flutter Development',
      description:
          'End-to-end Flutter app development for iOS, Android, and Web. Clean architecture, responsive UI, and smooth animations.',
      icon: 'smartphone',
    ),
    Service(
      title: 'Firebase Integration',
      description:
          'Complete Firebase backend setup including Authentication, Firestore, Cloud Functions, and Realtime Database.',
      icon: 'cloud',
    ),
    Service(
      title: 'Admin Dashboards',
      description:
          'Custom admin panels for managing your app data, analytics, and user base with intuitive interfaces.',
      icon: 'dashboard',
    ),
  ];

  static const String skillsTitle = 'Technical Skills';
  static const List<SkillGroup> skills = [
    SkillGroup(
      category: 'Frameworks & Core',
      skills: ['Flutter', 'Dart', 'Firebase', 'REST APIs'],
    ),
    SkillGroup(
      category: 'Architecture & State',
      skills: ['Provider', 'Riverpod', 'BLoC', 'Clean Architecture'],
    ),
    SkillGroup(
      category: 'Tools & Platforms',
      skills: [
        'Git',
        'GitHub',
        'Figma',
        'Play Store / App Store',
        'OpenStreetMap (OSM)',
      ],
    ),
    SkillGroup(
      category: 'AI & Orchestration',
      skills: ['AI-Assisted Development', 'AI Integrations'],
    ),
  ];

  static const String certificationsTitle = 'Certifications';
  static const List<Certification> certifications = [
    Certification(
      credentialType: 'Certificate of Participation',
      title: 'Based Build IRL Workshop',
      issuer: 'Base Philippines (Base PH)',
      issuedDateLabel: 'March 19, 2026',
      location: 'Makerspace Innovhub OPC, Mapandan, Pangasinan',
      description:
          'Participant in the Base PH Based Build IRL workshop hosted at Makerspace Innovhub. '
          'The in-person session was part of a global initiative to empower the next generation '
          'of on-chain builders -- recognizing dedication to learning, the builder community, '
          'and the wider on-chain economy.',
      imageAsset: 'assets/cert_base_build_irl.png',
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Canopy',
      description:
          'A 3D e-commerce and booking experience for the roofing industry. Customers can explore '
          'offerings, customize services, and book appointments in a modern storefront. Features include '
          'real-time availability, payment integration, and an admin dashboard for business management.',
      tags: [
        'Flutter',
        'Firebase',
        '3D',
        'E-commerce',
        'Booking',
        'Admin Panel',
      ],
      liveUrl: 'https://canopy-system-dev.web.app/',
    ),
    Project(
      title: 'Pro Track',
      description:
          'Built for gym enthusiasts and anyone serious about fitness: track daily protein intake '
          'so nutrition stays aligned with your goals. Includes an AI-powered coach you can ask '
          'for guidance on training, diet, and general wellness concerns.',
      tags: ['Flutter', 'Fitness', 'AI coach', 'Nutrition', 'Mobile'],
      apkUrl:
          'https://drive.google.com/file/d/1KAV3B90_0Mwr-Ys-3tF9-ww6p82XDg92/view?usp=sharing',
    ),
  ];

  static const String contactTitle = 'Contact';
  static const String contactBlurb =
      'Open to opportunities and collaborations. Reach out by email or connect on social.';

  static const String email = 'anyayafranklin27@gmail.com';

  /// Set to your URLs, or null to hide the button.
  static const String? githubUrl = null;
  static const String? linkedInUrl = null;
}

class Certification {
  const Certification({
    required this.credentialType,
    required this.title,
    required this.issuer,
    required this.issuedDateLabel,
    required this.location,
    required this.description,
    this.imageAsset,
  });

  final String credentialType;
  final String title;
  final String issuer;
  final String issuedDateLabel;
  final String location;
  final String description;
  final String? imageAsset;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    this.tags = const [],
    this.repoUrl,
    this.liveUrl,
    this.apkUrl,
    this.isFeatured = false,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String? repoUrl;
  final String? liveUrl;
  final String? apkUrl;
  final bool isFeatured;
}

class Service {
  const Service({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final String icon;
}

class SkillGroup {
  const SkillGroup({required this.category, required this.skills});

  final String category;
  final List<String> skills;
}
