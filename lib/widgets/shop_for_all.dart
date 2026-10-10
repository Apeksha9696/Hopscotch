import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Section 9: Explore more for Baby / Her / Him.
class ShopForAll extends StatelessWidget {
  final PageComponent component;
  const ShopForAll({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(tile: component.titleTile, fallbackText: 'Shop for All'),
        TileGrid(tiles: component.contentTiles, large: 3, medium: 3, small: 1),
      ],
    );
  }
}
