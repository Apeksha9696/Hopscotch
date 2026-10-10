import 'json_utils.dart';
import 'page_component.dart';

/// The whole homepage API response: a list of CustomTiles sections.
class HomepageResponse {
  final List<PageComponent> components;

  const HomepageResponse({required this.components});

  factory HomepageResponse.fromJson(dynamic json) {
    final raw = findKey(json, 'pageComponents');
    final list = <PageComponent>[];

    if (raw is List) {
      for (final item in raw) {
        final m = asMap(item);
        if (m == null) continue;
        // Each item is { type, position, data: { name, useCase, tile_details } }
        final data = asMap(m['data']) ?? m;
        list.add(PageComponent.fromJson(data));
      }
    }

    // Keep only sections that actually contain images.
    final withTiles = list.where((c) => c.tiles.isNotEmpty).toList();

    // Sort by "position" when every section has one.
    if (withTiles.isNotEmpty && withTiles.every((c) => c.position != null)) {
      withTiles.sort((a, b) => a.position!.compareTo(b.position!));
    }
    return HomepageResponse(components: withTiles);
  }
}
