import 'json_utils.dart';
import 'tile.dart';

/// One entry of "tile_details": its "tileGrid" info plus the tiles inside it.
class TileDetail {
  final Map<String, dynamic>? tileGrid;
  final List<Tile> tiles;

  const TileDetail({this.tileGrid, this.tiles = const []});

  factory TileDetail.fromJson(Map<String, dynamic> json) {
    return TileDetail(
      tileGrid: asMap(json['tileGrid']),
      tiles: Tile.collectFrom(json),
    );
  }
}
