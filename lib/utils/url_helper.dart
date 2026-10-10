import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../models/tile.dart';

class UrlHelper {
  /// Returns a web URL for the tile, or null if the tile is not clickable.
  /// Prefers actionUriWeb, then action_value. Never uses hopscotch:// links.
  static Uri? resolve(Tile tile) {
    final fromWeb = _toWebUri(tile.actionUriWeb, allowBarePath: true);
    if (fromWeb != null) return fromWeb;
    return _toWebUri(tile.actionValue, allowBarePath: false);
  }

  static Uri? _toWebUri(String? value, {required bool allowBarePath}) {
    if (value == null) return null;
    final s = value.trim();
    if (s.isEmpty) return null;
    if (s.contains('://') && !s.startsWith('http')) return null; // deep link

    if (s.startsWith('http://') || s.startsWith('https://')) {
      return Uri.tryParse(s);
    }
    if (s.startsWith('//')) return Uri.tryParse('https:$s');
    if (s.startsWith('/')) return Uri.tryParse('${AppConfig.webBaseUrl}$s');
    if (allowBarePath) return Uri.tryParse('${AppConfig.webBaseUrl}/$s');
    return null;
  }

  static Future<void> open(Uri uri) async {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
