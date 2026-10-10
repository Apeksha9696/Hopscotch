import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Sections 6 and 7: Shop for Girls / Shop for Boys.
/// Same widget, different API section: all category cards come from the API.
class CategorySection extends StatelessWidget {
  final PageComponent component;
  final String fallbackTitle;

  const CategorySection({
    super.key,
    required this.component,
    required this.fallbackTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(tile: component.titleTile, fallbackText: fallbackTitle),
        TileGrid(tiles: component.contentTiles, large: 4, medium: 3, small: 2),
      ],
    );
  }
}
