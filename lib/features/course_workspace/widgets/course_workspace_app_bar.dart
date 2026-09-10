import 'package:flutter/material.dart';

import '../../../../widgets/brand_header.dart';

class CourseWorkspaceAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String topic;

  const CourseWorkspaceAppBar({
    super.key,
    required this.title,
    required this.topic,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return BrandHeader(title: title, showBack: true);
  }
}
