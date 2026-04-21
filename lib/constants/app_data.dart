import 'package:flutter/material.dart';
import '../models/nav_link.dart';
import '../models/service.dart';
import '../models/technology.dart';
import '../models/experience.dart';
import '../models/testimonial.dart';
import '../models/project.dart';

/// All portfolio data — mirrors src/constants/index.ts from the React project.
/// Update this file with your own experience, projects, and testimonials.

// ── Navigation ────────────────────────────────────────────────────────────────
const List<NavLink> navLinks = [
  NavLink(id: 'about', title: 'About'),
  NavLink(id: 'work', title: 'Work'),
  NavLink(id: 'contact', title: 'Contact'),
  NavLink(id: 'download', title: 'Download'),
];

// ── Services (About cards) ────────────────────────────────────────────────────
const List<Service> services = [
  Service(
      title: 'Mobile App Development (Flutter)', icon: 'assets/images/web.png'),
  Service(
      title: 'Backend Systems (Spring Boot)', icon: 'assets/images/mobile.png'),
  Service(
      title: 'API Development & Integration',
      icon: 'assets/images/backend.png'),
  Service(title: 'AI-powered Features', icon: 'assets/images/creator.png'),
];

// ── Technologies (Tech section) ───────────────────────────────────────────────
const List<Technology> technologies = [
  Technology(name: 'HTML 5', icon: 'assets/images/tech/html.png'),
  Technology(name: 'CSS 3', icon: 'assets/images/tech/css.png'),
  Technology(name: 'JavaScript', icon: 'assets/images/tech/javascript.png'),
  // Technology(name: 'TypeScript', icon: 'assets/images/tech/typescript.png'),
  Technology(name: 'React JS', icon: 'assets/images/tech/reactjs.png'),
  // Technology(name: 'Redux Toolkit', icon: 'assets/images/tech/redux.png'),
  Technology(name: 'Tailwind CSS', icon: 'assets/images/tech/tailwind.png'),
  Technology(name: 'Node JS', icon: 'assets/images/tech/nodejs.png'),
  // Technology(name: 'MongoDB', icon: 'assets/images/tech/mongodb.png'),
  // Technology(name: 'Three JS', icon: 'assets/images/tech/threejs.svg'),
  Technology(name: 'git', icon: 'assets/images/tech/git.png'),
  Technology(name: 'figma', icon: 'assets/images/tech/figma.png'),
  Technology(name: 'docker', icon: 'assets/images/tech/docker.png'),
];

// ── Work Experience ───────────────────────────────────────────────────────────
final List<Experience> experiences = [
  const Experience(
    title: 'Software Engineer',
    companyName: 'DBQ Technology',
    icon: 'assets/images/company/dbq.png',
    iconBg: Color(0xFF383E56),
    date: '2025 - Present',
    points: [
      'Developing mobile applications using Flutter with a focus on performance and responsive UI.',
      'Integrating REST APIs with frontend applications for seamless data flow.',
      'Collaborating with backend teams to design and consume scalable APIs.',
      'Working on real-time features and improving user experience across devices.',
    ],
  ),
  const Experience(
    title: 'Intern',
    companyName: 'Tezhire',
    icon: 'assets/images/company/tezhire.png',
    iconBg: Color(0xFFE6DEDD),
    date: 'Jan 2025 - May 2025',
    points: [
      'Developed backend services using Java and Spring Boot.',
      'Designed and implemented REST APIs for application features.',
      'Worked with PostgreSQL for database design and CRUD operations.',
      'Tested APIs and ensured data consistency and performance.',
    ],
  ),
];

// ── Testimonials ──────────────────────────────────────────────────────────────
const List<Testimonial> testimonials = [
  Testimonial(
    testimonial:
        "I thought it was impossible to make a website as beautiful as our product, but Rick proved me wrong.",
    name: 'Sara Lee',
    designation: 'CFO',
    company: 'Acme Co',
    image: 'https://randomuser.me/api/portraits/women/4.jpg',
  ),
  Testimonial(
    testimonial:
        "I've never met a web developer who truly cares about their clients' success like Rick does.",
    name: 'Chris Brown',
    designation: 'COO',
    company: 'DEF Corp',
    image: 'https://randomuser.me/api/portraits/men/5.jpg',
  ),
  Testimonial(
    testimonial:
        'After Rick optimized our website, our traffic increased by 50%. We can\'t thank them enough!',
    name: 'Lisa Wang',
    designation: 'CTO',
    company: '456 Enterprises',
    image: 'https://randomuser.me/api/portraits/women/6.jpg',
  ),
];

// ── Projects ──────────────────────────────────────────────────────────────────
const List<Project> projects = [
  Project(
    name: 'AI Chat Application',
    description:
        'A real-time AI-powered chat application built using Flutter and Spring Boot. Integrated Spring AI to generate intelligent responses, with REST APIs handling communication between frontend and backend. Designed a scalable architecture and implemented secure data handling.',
    tags: [
      ProjectTag(name: 'flutter', colorType: 'blue'),
      ProjectTag(name: 'springboot', colorType: 'green'),
      ProjectTag(name: 'springai', colorType: 'pink'),
      ProjectTag(name: 'restapi', colorType: 'blue'),
    ],
    image: 'assets/images/carrent.png',
    sourceCodeLink: 'https://github.com/',
  ),
  Project(
    name: 'Learning Management System (Backend)',
    description:
        'Developed a backend system for a Learning Management System using Spring Boot. Implemented REST APIs for user management, course handling, and authentication. Designed database schemas and ensured scalable and maintainable backend architecture.',
    tags: [
      ProjectTag(name: 'springboot', colorType: 'green'),
      ProjectTag(name: 'restapi', colorType: 'blue'),
      ProjectTag(name: 'postgresql', colorType: 'pink'),
    ],
    image: 'assets/images/jobit.png',
    sourceCodeLink: 'https://github.com/',
  ),
  Project(
    name: 'E-commerce Application',
    description:
        'Built an e-commerce application with product listing, cart, and order management features. Developed backend APIs using Spring Boot and integrated them with a Flutter frontend. Focused on clean architecture and smooth user experience.',
    tags: [
      ProjectTag(name: 'flutter', colorType: 'blue'),
      ProjectTag(name: 'springboot', colorType: 'green'),
      ProjectTag(name: 'restapi', colorType: 'pink'),
    ],
    image: 'assets/images/tripguide.png',
    sourceCodeLink: 'https://github.com/',
  ),
];
