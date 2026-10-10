import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Section 3: title image + 4 occasion cards (Winter, Celebration, ...).
class ShopByOccasion extends StatelessWidget {
  final PageComponent component;
  const ShopByOccasion({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(tile: component.titleTile, fallbackText: 'Shop by Occasion'),
        TileGrid(tiles: component.contentTiles, large: 4, medium: 4, small: 2),
      ],
    );
  }
}
