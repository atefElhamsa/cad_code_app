import 'package:flutter/material.dart';

import 'decorative_circle_cluster.dart';

class SplashOrbs extends StatelessWidget {
  const SplashOrbs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        PositionedDirectional(
          top: -36,
          start: -36,
          child: DecorativeCircleCluster(isTopLeft: true),
        ),
        PositionedDirectional(
          bottom: -36,
          end: -36,
          child: DecorativeCircleCluster(isTopLeft: false),
        ),
      ],
    );
  }
}
