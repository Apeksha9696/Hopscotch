import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'image_tile.dart';

/// Section 1: main banner (first CustomTiles section).
class HeroBanner extends StatelessWidget {
  final PageComponent component;
  const HeroBanner({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final tiles = component.tiles;
    if (tiles.isEmpty) return const SizedBox.shrink();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1600),
        child: ImageTile(
          tile: tiles.first,
          borderRadius: 0,
          fallbackAspectRatio: 3,
        ),
      ),
    );
  }
}
