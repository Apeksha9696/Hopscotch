import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Section 4: title image + responsive grid of trend tiles.
class TrendsSection extends StatelessWidget {
  final PageComponent component;
  const TrendsSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(tile: component.titleTile, fallbackText: 'Trends'),
        TileGrid(tiles: component.contentTiles, large: 4, medium: 3, small: 2),
      ],
    );
  }
}
