import 'json_utils.dart';
import 'tile.dart';
import 'tile_detail.dart';

/// One "CustomTiles" section of the homepage (hero, flash sale, trends ...).
class PageComponent {
  final String name;
  final int? position;
  final String? useCase;
  final Map<String, dynamic>? margins;
  final List<TileDetail> tileDetails;

  const PageComponent({
    required this.name,
    this.position,
    this.useCase,
    this.margins,
    this.tileDetails = const [],
  });

  /// All tiles of this section, in API order.
  List<Tile> get tiles => [for (final d in tileDetails) ...d.tiles];

  /// The heading image (isTitleItem == true), if the section has one.
  Tile? get titleTile {
    for (final t in tiles) {
      if (t.isTitleItem) return t;
    }
    return null;
  }

  /// Tiles that are not the title image.
  List<Tile> get contentTiles => tiles.where((t) => !t.isTitleItem).toList();

  factory PageComponent.fromJson(Map<String, dynamic> json) {
    final raw = json['tile_details'] ?? findKey(json, 'tile_details');
    final details = <TileDetail>[];

    if (raw is List) {
      for (final item in raw) {
        final m = asMap(item);
        if (m != null) details.add(TileDetail.fromJson(m));
      }
    } else if (raw is Map) {
      details.add(TileDetail.fromJson(Map<String, dynamic>.from(raw)));
    }

    // Safety net: if nothing was found, look through the whole section.
    if (details.every((d) => d.tiles.isEmpty)) {
      details
        ..clear()
        ..add(TileDetail.fromJson(json));
    }

    return PageComponent(
      name: asString(json['name']) ?? '',
      position: asInt(json['position']),
      useCase: asString(json['useCase']) ?? asString(json['use_case']),
      margins: asMap(json['margins']),
      tileDetails: details,
    );
  }
}
