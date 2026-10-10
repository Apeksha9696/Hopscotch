import 'package:flutter/material.dart';

import '../models/tile.dart';
import 'image_tile.dart';

/// Section heading: the API title image (isTitleItem) if there is one,
/// otherwise a plain text fallback.
class SectionTitle extends StatelessWidget {
  final Tile? tile;
  final String fallbackText;

  const SectionTitle({super.key, this.tile, required this.fallbackText});

  @override
  Widget build(BuildContext context) {
    final t = tile;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: t != null
            ? ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ImageTile(
                  tile: t,
                  borderRadius: 0,
                  fit: BoxFit.contain,
                  fallbackAspectRatio: 8,
                ),
              )
            : Text(
                fallbackText,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
      ),
    );
  }
}
