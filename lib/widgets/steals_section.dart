import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Section 8: Can't Miss Steals (three promo cards).
class StealsSection extends StatelessWidget {
  final PageComponent component;
  const StealsSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(tile: component.titleTile, fallbackText: "Can't Miss Steals"),
        TileGrid(tiles: component.contentTiles, large: 3, medium: 3, small: 1),
      ],
    );
  }
}
