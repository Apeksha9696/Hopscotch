import 'package:flutter/material.dart';

import '../models/tile.dart';
import '../utils/url_helper.dart';

/// Shows one API image with loading/error placeholders, correct aspect ratio,
/// a hover effect, and opens actionUriWeb when clicked.
class ImageTile extends StatefulWidget {
  final Tile tile;
  final double borderRadius;
  final BoxFit fit;
  final double fallbackAspectRatio;

  const ImageTile({
    super.key,
    required this.tile,
    this.borderRadius = 12,
    this.fit = BoxFit.cover,
    this.fallbackAspectRatio = 1,
  });

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final uri = UrlHelper.resolve(widget.tile);
    final clickable = uri != null;
    final radius = BorderRadius.circular(widget.borderRadius);
    final ratio = widget.tile.aspectRatio ?? widget.fallbackAspectRatio;

    final image = AspectRatio(
      aspectRatio: ratio,
      child: Image.network(
        widget.tile.imageUrl,
        fit: widget.fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stack) => Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image_not_supported_outlined,
                  color: Colors.grey.shade400),
              const SizedBox(height: 4),
              Text(
                'Image unavailable',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ),
    );

    return MouseRegion(
      cursor: clickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: clickable ? () => UrlHelper.open(uri) : null,
        child: Semantics(
          label: widget.tile.label,
          button: clickable,
          child: AnimatedScale(
            scale: _hover && clickable ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: radius,
                boxShadow: _hover && clickable
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : const [],
              ),
              child: ClipRRect(borderRadius: radius, child: image),
            ),
          ),
        ),
      ),
    );
  }
}
