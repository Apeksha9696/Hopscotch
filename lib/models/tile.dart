import 'json_utils.dart';

/// One image tile from the API (banner, card, title image ...).
class Tile {
  final String imageUrl;
  final double? width;
  final double? height;
  final String? actionUri; // mobile deep link (NOT used on web)
  final String? actionType;
  final String? actionUriWeb; // web link (used on web)
  final String? actionValue;
  final bool isTitleItem;
  final String? title;

  const Tile({
    required this.imageUrl,
    this.width,
    this.height,
    this.actionUri,
    this.actionType,
    this.actionUriWeb,
    this.actionValue,
    this.isTitleItem = false,
    this.title,
  });

  /// width / height from the API, or null if the API did not give both.
  double? get aspectRatio {
    final w = width, h = height;
    if (w != null && h != null && w > 0 && h > 0) return w / h;
    return null;
  }

  /// Text used for accessibility.
  String get label => title ?? actionValue ?? 'Hopscotch';

  factory Tile.fromJson(Map<String, dynamic> json) {
    var url = asString(json['imageUrl']) ?? '';
    if (url.startsWith('//')) url = 'https:$url';
    return Tile(
      imageUrl: url,
      width: asDouble(json['width']),
      height: asDouble(json['height']),
      actionUri: asString(json['actionUri']),
      actionType: asString(json['action_type']),
      actionUriWeb: asString(json['actionUriWeb']),
      actionValue: asString(json['action_value']),
      isTitleItem: asBool(json['isTitleItem']),
      title: asString(json['title']) ?? asString(json['name']),
    );
  }

  /// Walks any JSON structure and returns every map that has an "imageUrl",
  /// in the order they appear. This keeps parsing safe even if tiles are
  /// nested inside tile_details / tileGrid at different depths.
  static List<Tile> collectFrom(dynamic node) {
    final out = <Tile>[];
    _walk(node, out);
    return out;
  }

  static void _walk(dynamic node, List<Tile> out) {
    if (node is Map) {
      if (asString(node['imageUrl']) != null) {
        out.add(Tile.fromJson(Map<String, dynamic>.from(node)));
        return;
      }
      for (final v in node.values) {
        _walk(v, out);
      }
    } else if (node is List) {
      for (final v in node) {
        _walk(v, out);
      }
    }
  }
}
