import 'package:flutter/material.dart';

import '../models/tile.dart';
import 'image_tile.dart';

/// Responsive grid of ImageTiles.
/// Column count depends on the available width:
///   >= 900 px -> [large], >= 600 px -> [medium], otherwise [small].
/// Each tile keeps the aspect ratio given by the API (width / height).
class TileGrid extends StatelessWidget {
  final List<Tile> tiles;
  final int large;
  final int medium;
  final int small;
  final double spacing;
  final double borderRadius;
  final double fallbackAspectRatio;

  const TileGrid({
    super.key,
    required this.tiles,
    this.large = 4,
    this.medium = 3,
    this.small = 2,
    this.spacing = 16,
    this.borderRadius = 12,
    this.fallbackAspectRatio = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (tiles.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      var columns = w >= 900 ? large : (w >= 600 ? medium : small);
      if (columns > tiles.length) columns = tiles.length;
      if (columns < 1) columns = 1;

      final itemWidth = (w - spacing * (columns - 1)) / columns - 0.01;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        alignment: WrapAlignment.center,
        children: [
          for (final tile in tiles)
            SizedBox(
              width: itemWidth,
              child: ImageTile(
                tile: tile,
                borderRadius: borderRadius,
                fallbackAspectRatio: fallbackAspectRatio,
              ),
            ),
        ],
      );
    });
  }
}
