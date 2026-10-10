// Small helpers so that missing / wrongly-typed JSON fields never crash the app.

String? asString(dynamic v) {
  if (v == null) return null;
  final s = v.toString().trim();
  return s.isEmpty ? null : s;
}

double? asDouble(dynamic v) {
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

int? asInt(dynamic v) => asDouble(v)?.toInt();

bool asBool(dynamic v) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) return v.toLowerCase() == 'true';
  return false;
}

Map<String, dynamic>? asMap(dynamic v) {
  if (v is Map) return Map<String, dynamic>.from(v);
  return null;
}

/// Finds the first non-null value stored under [key], searching nested
/// maps and lists. Lets us locate "pageComponents" wherever it is wrapped.
dynamic findKey(dynamic node, String key) {
  if (node is Map) {
    if (node[key] != null) return node[key];
    for (final v in node.values) {
      final r = findKey(v, key);
      if (r != null) return r;
    }
  } else if (node is List) {
    for (final v in node) {
      final r = findKey(v, key);
      if (r != null) return r;
    }
  }
  return null;
}
