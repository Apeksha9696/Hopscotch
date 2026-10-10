import 'package:flutter/material.dart';

import '../models/page_component.dart';
import '../models/tile.dart';
import 'image_tile.dart';
import 'section_title.dart';
import 'tile_grid.dart';

/// Section 5: title + wide banners + smaller tiles.
/// A tile counts as "wide" when its API width is close to the widest tile,
/// so the layout follows the API dimensions instead of being hard-coded.
class CouponCorner extends StatelessWidget {
  final PageComponent component;
  const CouponCorner({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final tiles = component.contentTiles;

    double widest = 0;
    for (final t in tiles) {
      if ((t.width ?? 0) > widest) widest = t.width!;
    }
    bool isWide(Tile t) => widest > 0 && (t.width ?? 0) >= widest * 0.7;

    final children = <Widget>[
      SectionTitle(tile: component.titleTile, fallbackText: 'Coupon Corner'),
    ];
    final smallGroup = <Tile>[];

    void flushSmall() {
      if (smallGroup.isEmpty) return;
      children.add(TileGrid(
        tiles: List.of(smallGroup),
        large: 2,
        medium: 2,
        small: 2,
      ));
      children.add(const SizedBox(height: 16));
      smallGroup.clear();
    }

    for (final t in tiles) {
      if (isWide(t)) {
        flushSmall();
        children.add(ImageTile(tile: t, fallbackAspectRatio: 4));
        children.add(const SizedBox(height: 16));
      } else {
        smallGroup.add(t);
      }
    }
    flushSmall();

    return Column(children: children);
  }
}
