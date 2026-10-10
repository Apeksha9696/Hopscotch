import 'package:flutter/material.dart';

import '../models/page_component.dart';
import 'image_tile.dart';

/// Section 2: Flash Sale image (aspect ratio comes from the API).
class FlashSale extends StatelessWidget {
  final PageComponent component;
  const FlashSale({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final tiles = component.tiles;
    if (tiles.isEmpty) return const SizedBox.shrink();
    return ImageTile(tile: tiles.first, borderRadius: 16, fallbackAspectRatio: 4);
  }
}
