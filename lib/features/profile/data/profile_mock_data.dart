import 'package:flutter/material.dart';

final List<Map<String, dynamic>> enrolledCoursesMock = [
  {
    'name': 'Flutter Masterclass',
    'icon': Icons.flutter_dash,
    'color': const Color(0xFF027DFD),
    'stats': {
      'Session': 0.85,
      'Behavior': 0.90,
      'Sharing': 0.70,
      'Assignment': 0.80,
      'Focus': 0.95,
    },
  },
  {
    'name': 'UI/UX Design',
    'icon': Icons.design_services_rounded,
    'color': const Color(0xFFE1306C),
    'stats': {
      'Session': 0.60,
      'Behavior': 0.85,
      'Sharing': 0.90,
      'Assignment': 0.50,
      'Focus': 0.75,
    },
  },
  {
    'name': 'Backend with Node.js',
    'icon': Icons.data_object_rounded,
    'color': const Color(0xFF25D366),
    'stats': {
      'Session': 0.40,
      'Behavior': 0.95,
      'Sharing': 0.50,
      'Assignment': 0.30,
      'Focus': 0.60,
    },
  },
];
